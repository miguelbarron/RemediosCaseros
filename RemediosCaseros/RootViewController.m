//
//  RootViewController.m
//  RemediosCaseros
//
//  Created by Arturo Pruneda on 26/12/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import "RootViewController.h"

#import "AppDelegate.h"
#import "SBJson.h"
#import "Remedios.h"
#import "Glosario.h"
#import "detalleViewController.h"
#import "Analytics.h"

@implementation RootViewController
@synthesize searchBar;
@synthesize filteredListContent,savedSearchTerm,searchWasActive,savedScopeButtonIndex;
@synthesize fetchedResultsController,managedObjectContext;

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
        label.text = NSLocalizedString(@"Remedios Caseros", @"");
        [label sizeToFit];        
        self.title = NSLocalizedString(@"Remedios", @"Remedio");
        self.tabBarItem.image = [UIImage imageNamed:@"icono_remedios_tab.png"];
        
    
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
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext=appDelegate.managedObjectContext;
 
    
   self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];
   self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo_general@2x.png"]]; 
   self.tableView.backgroundColor = [UIColor clearColor];  
    
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
    [self setSearchBar:nil];
    [super viewDidUnload];
    
}


- (void)viewWillAppear:(BOOL)animated {

    Tracker = [Analytics sharedInstance];
    [Tracker track:self.title];

}



#pragma mark Table view methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
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
        id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];    
        NSString *clasificacion = [sectionInfo name];
        return clasificacion;
}
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
  }
  
  // Configure the cell...
  
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold"  size:15.0];     
    cell.textLabel.textColor=[UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];
    cell.detailTextLabel.font= [UIFont fontWithName:@"Helvetica" size:12.0];    
    cell.detailTextLabel.numberOfLines=2;
    cell.textLabel.numberOfLines=2;
    
       
    Remedios *rem=nil;

    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        rem = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        rem = [fetchedResultsController objectAtIndexPath:indexPath];
    }
    
     
    NSString *url=rem.imagenThumb;
    UIImage *myimagen=[UIImage imageNamed:url];
    
    cell.textLabel.text=rem.nombreRemedio;
    cell.detailTextLabel.text=rem.subtitulo;
    cell.imageView.image=myimagen;
    
    
    
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    detalleViewController *detalle=[[detalleViewController alloc]initWithNibName:@"detalleViewController" bundle:nil];
   
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        
        detalle.remedio = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    else
    {
        detalle.remedio =  [fetchedResultsController objectAtIndexPath:indexPath];
    }
    
    [self.navigationController pushViewController:detalle animated:YES];
    
    
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [searchBar release];
    [super dealloc];
}

#pragma mark fetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController {
    
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Remedios" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
//     NSPredicate *predicate =[NSPredicate predicateWithFormat:@"nombreRemedio = %@" , self.remedio];  
//    [NSFetchedResultsController deleteCacheWithName:nil];
    
  //  [fetchRequest setPredicate:predicate];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"categoriaRemedio" ascending:YES];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"nombreRemedio" ascending:YES];
    
    // Edit the sort key as appropriate.
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numero" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, sortDescriptor1, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:@"categoriaRemedio" cacheName:@"Root"];
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
        NSPredicate *sPredicate = [NSPredicate predicateWithFormat:@"nombreRemedio CONTAINS[cd] %@ or subtitulo CONTAINS[cd] %@", searchText, searchText];
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
