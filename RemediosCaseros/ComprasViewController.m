//
//  ComprasViewController.m
//  RemediosCaseros
//
//  Created by User on 4/2/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "ComprasViewController.h"
#import "AppDelegate.h"
#import "Glosario.h"

@implementation ComprasViewController
@synthesize myTableView;
@synthesize fetchedResultsController,managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = NSLocalizedString(@"Compras", @"Compras");        
        self.tabBarItem.image = [UIImage imageNamed:@"icono_compras_tab.png"];
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
    
    
    
    UIImage *imagenEliminar=[UIImage imageNamed:@"icono_basura_compras.png"];
    eliminarButton = [[UIBarButtonItem alloc] initWithImage:imagenEliminar style:UIBarButtonItemStyleBordered target:self action:@selector(eliminarCompra:)];
    self.navigationItem.rightBarButtonItem = eliminarButton;
    [eliminarButton release]; 

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.myTableView reloadData];
    
    
    
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark Table view methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return 0;
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return [[fetchedResultsController sections] count]; 
    
    
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   // return 0;
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//
//    
//    return ;
//    
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    Glosario *glosario;
    glosario = (Glosario *)[fetchedResultsController objectAtIndexPath:indexPath];
    

    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;  
    cell.textLabel.numberOfLines = 2;  
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica"  size:20.0];      
    cell.detailTextLabel.font          = [UIFont fontWithName:@"Helvetica" size:15.0];    
    cell.detailTextLabel.numberOfLines = 2;    

    
    
    cell.textLabel.text=glosario.nombreIngrediente;
    
    UIImage *marcaVacia=[UIImage imageNamed:@"marca_vacia_compras.png"];
    UIImage *marcaLlena=[UIImage imageNamed:@"marca_llena_compras.png"];
    
    if ([glosario.seleccionCompra intValue] > 0) {
        
        cell.imageView.image=marcaLlena;
    }
    else
    {
    cell.imageView.image=marcaVacia;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cambiar imagen");
    Glosario *glosario;
    glosario = (Glosario *)[fetchedResultsController objectAtIndexPath:indexPath];
    if ([glosario.seleccionCompra intValue]<1 ) 
    {
        [glosario setSeleccionCompra:[NSNumber numberWithBool:YES]];
        
    }
    else
    {
    
        [glosario setSeleccionCompra:[NSNumber numberWithBool:NO]];
    }
    
    NSError *saveError;
    [managedObjectContext save:&saveError];
    
    
    
    [myTableView reloadData];
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Glosario *glosario;
        NSError *saveError;
        glosario = (Glosario *)[fetchedResultsController objectAtIndexPath:indexPath]; 
        [glosario setSeleccionCompra:NO];
        [glosario setComprarIngrediente:NO];
        [managedObjectContext save:&saveError];
        [self.myTableView reloadData];
        
        //    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    //    else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //  }   
}



#pragma mark - NSFetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:nil];
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"comprarIngrediente == YES"];  
    [NSFetchedResultsController deleteCacheWithName:nil];
    
    [fetchRequest setPredicate:predicate];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nombreIngrediente" ascending:YES];
    
    // Edit the sort key as appropriate.
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numero" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:@"comprarIngrediente" cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    return fetchedResultsController;
}


- (void)dealloc {
    [myTableView release];
    [super dealloc];
}

-(void)eliminarCompra:(id)sender
{
    NSLog(@"eliminar elementos del glosario selecionado");

    
}
@end




