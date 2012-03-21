//
//  RootViewController.m
//  RemediosCaseros
//
//  Created by Arturo Pruneda on 26/12/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import "RootViewController.h"
#import "DetalleViewController.h"
#import "AppDelegate.h"

@implementation RootViewController
@synthesize arrayConDOEnGrupos, miRemedio,fetchedResultsController,managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
   NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
    
    // Do any additional setup after loading the view from its nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"lasdo" ofType:@"plist"];
    //inicializamos nuestra propiedad arrayConDOEnGrupos con el
    //contenido de ese fichero
    arrayConDOEnGrupos = [[NSArray alloc] initWithContentsOfFile:path];
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [arrayConDOEnGrupos count];
    

}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	NSDictionary *diccionarioConDatosDO = [arrayConDOEnGrupos objectAtIndex:section];
    
    NSArray *tipos = [diccionarioConDatosDO objectForKey:@"tipos"];
    
    return [tipos count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSDictionary *diccionarioConDatosDO = [arrayConDOEnGrupos objectAtIndex:section];
    
    NSString *nombre = [diccionarioConDatosDO objectForKey:@"nombre"];
    
    return nombre;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  // Configure the cell...
  //cell.textLabel.text = @"Hola";
    int seccion =	[indexPath section];
    
    NSDictionary *diccionarioConDatosDO = [arrayConDOEnGrupos objectAtIndex:seccion];
    
    NSArray *tipos = [diccionarioConDatosDO objectForKey:@"tipos"];
    
    
    int fila	=	[indexPath row];
    
    NSDictionary *elemento = [tipos objectAtIndex:fila];
 
    
  self.miRemedio = [[Remedio alloc] init];
  self.miRemedio.remedio = [elemento objectForKey:@"remedio"];
  self.miRemedio.imagen = [elemento objectForKey:@"imagen"];
  self.miRemedio.ingredientes = [elemento objectForKey:@"ingredientes"];
  self.miRemedio.instrucciones = [elemento objectForKey:@"instrucciones"];
  
    cell.textLabel.text = self.miRemedio.remedio;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
  
	//DestinoDetailViewController *ddvController;
    DetalleViewController *dvc = [[DetalleViewController alloc] init];
  dvc.miRemedio = self.miRemedio;
	[self.navigationController pushViewController:dvc animated:YES];
  
	[dvc release];
	dvc = nil;
    
    NSLog(@"seccion %i, fila %i", [indexPath section], [indexPath row]);
    
    /*
     
     DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
     
     // ...
     
     // Pass the selected object to the new view controller.
     
     [self.navigationController pushViewController:detailViewController animated:YES];
     
     [detailViewController release];
     
     */
  
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark fetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController {
    
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:/**/@"Categoria" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    // NSPredicate *predicate =[NSPredicate predicateWithFormat:@"seccion.titulo = %@" , @"Eventos"];  
    //[NSFetchedResultsController deleteCacheWithName:nil];
    
    //[fetchRequest setPredicate:predicate];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"titulo" ascending:YES];
    
    // Edit the sort key as appropriate.
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numero" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:@"titulo" cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    return fetchedResultsController;
}


@end
