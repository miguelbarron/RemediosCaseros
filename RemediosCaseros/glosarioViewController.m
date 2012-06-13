//
//  glosarioViewController.m
//  RemediosCaseros
//
//  Created by User on 3/27/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "glosarioViewController.h"
#import "Glosario.h"
#import "detalleGlosarioViewController.h"

@implementation glosarioViewController
@synthesize managedObjectContext,fetchedResultsController;
@synthesize savedScopeButtonIndex,savedSearchTerm,searchBar,searchWasActive,filteredListContent;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.font=[UIFont fontWithName:@"Cochin-BoldItalic" size:27];
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor]; // change this color
        self.navigationItem.titleView = label;
        label.text = NSLocalizedString(@"Glosario", @"");
        [label sizeToFit];
        
        self.title = NSLocalizedString(@"Glosario", @"Glosario");
        self.tabBarItem.image = [UIImage imageNamed:@"icono_glosario_tab.png"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Tracker = [Analytics sharedInstance];
    // Do any additional setup after loading the view from its nib.
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext=appDelegate.managedObjectContext;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];
    
    // create a filtered list that will contain products for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[[fetchedResultsController sections] count]];	
    
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }

    
    NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setSearchBar:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [Tracker track:self.title];    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark Table view methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //  return [[fetchedResultsController sections]count];     
    if (tableView==self.searchDisplayController.searchResultsTableView) 
    {
        return 1;
    }
    
    else        
        return [[fetchedResultsController sections]count]; 
    
    
    
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
	else
	{
            id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];    
            return [sectionInfo numberOfObjects];
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) 
    {
        return @"Resultado de busqueda";
    }
    
    else
    {

        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        //============Se Cambia el color al momento de selecionar una celda=========//
        UIView *vistaCellGlosario = [[[UIView alloc] init] autorelease];
        vistaCellGlosario.backgroundColor = [UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];
        cell.selectedBackgroundView = vistaCellGlosario;
        //=====================//
    }
    
    // Configure the cell...
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold"  size:15.0]; 
    cell.textLabel.textColor=[UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];    
    cell.textLabel.numberOfLines=3;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    
   
    
    Glosario *glo=nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        glo = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        glo = [fetchedResultsController objectAtIndexPath:indexPath];
    }
    
    
    
    NSString *url=glo.imagenThumb;    
    UIImage *myimagen=[UIImage imageNamed:url];
    
    cell.textLabel.text=glo.nombreIngrediente;   
    cell.imageView.image=myimagen;

    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    detalleGlosarioViewController *detalleGlosario=[[detalleGlosarioViewController alloc]init];
    
   
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        
        detalleGlosario.glosario = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    else
    {
        detalleGlosario.glosario =  [fetchedResultsController objectAtIndexPath:indexPath];
    }
    
        [self.navigationController pushViewController:detalleGlosario animated:YES];    
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





#pragma mark fetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController {
    
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    //  NSPredicate *predicate =[NSPredicate predicateWithFormat:@"Categoria.titulo = %@" , self.remedio];  
    //[NSFetchedResultsController deleteCacheWithName:nil];
    
    //[fetchRequest setPredicate:predicate];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nombreIngrediente" ascending:YES];
    
    // Edit the sort key as appropriate.
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numero" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:@"imagenThumb" cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    return fetchedResultsController;
}


#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    if (searchText && searchText.length > 0) {
        NSPredicate *sPredicate = [NSPredicate predicateWithFormat:@"nombreIngrediente CONTAINS[cd] %@", searchText];
        self.filteredListContent = [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:sPredicate];
    }
    
   	
}



#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
	
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}



@end
