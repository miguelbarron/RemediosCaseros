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
#import "Categoria.h"
#import "Remedios.h"
#import "Glosario.h"
//#import "Imagen.h"
#import "detalleViewController.h"


@implementation RootViewController
@synthesize fetchedResultsController,managedObjectContext,tabBarController,arrayRemedios;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
 
    
    
   self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo_general@2x.png"]]; 
   self.tableView.backgroundColor = [UIColor clearColor];  
    
   NSError *error = nil;
   if (![[self fetchedResultsController] performFetch:&error]) {
             
             NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
             abort();
   }
    
    // Do any additional setup after loading the view from its nib.
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"lasdo" ofType:@"plist"];
    //inicializamos nuestra propiedad arrayConDOEnGrupos con el
    //contenido de ese fichero
   // arrayConDOEnGrupos = [[NSArray alloc] initWithContentsOfFile:path];
    
     
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




#pragma mark Table view methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[fetchedResultsController sections]count];   
    

}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];    
    return [sectionInfo numberOfObjects];
    }

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];   
    
    NSString *clasificacion = [sectionInfo name];
    
    return clasificacion;
    
    
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
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold"  size:13.0];     
    cell.detailTextLabel.font= [UIFont fontWithName:@"Helvetica" size:11.0];    
    cell.detailTextLabel.numberOfLines=2;
    cell.textLabel.numberOfLines=2;
    
        

    
    Remedios *rem=[fetchedResultsController objectAtIndexPath:indexPath ];
//    Imagen *imagenRemedio=rem.imagen;
//    NSString *url=imagenRemedio.imagenThumb;    
    NSString *url=rem.imagenThumb;
    UIImage *myimagen=[UIImage imageNamed:url];
    
    cell.textLabel.text=rem.nombreRemedio;
    cell.detailTextLabel.text=rem.subtitulo;
    cell.imageView.image=myimagen;
    
    
    
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    
    
    
    detalleViewController *detalle=[[detalleViewController alloc]init];
    detalle.remedio=[fetchedResultsController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:detalle animated:YES];
    
    
//    DetalleViewController *dvc = [[DetalleViewController alloc] init];
// 
//	[self.navigationController pushViewController:dvc animated:YES];
//  
//	[dvc release];
//	dvc = nil;
//    

  
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:/**/@"Remedios" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
   //  NSPredicate *predicate =[NSPredicate predicateWithFormat:@"Categoria.titulo = %@" , self.remedio];  
    //[NSFetchedResultsController deleteCacheWithName:nil];
    
    //[fetchRequest setPredicate:predicate];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nombreRemedio" ascending:YES];
    
    // Edit the sort key as appropriate.
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numero" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
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



@end
