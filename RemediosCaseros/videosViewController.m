//
//  videosViewController.m
//  RemediosCaseros
//
//  Created by User on 6/11/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "videosViewController.h"
#import "DetalleVideosViewController.h"
#import "Analytics.h"
#import "Compras.h"
#import <SystemConfiguration/SCNetworkReachability.h>
//#import <sys/socket.h>
#import <netinet/in.h>
//#import <arpa/inet.h>
//#import <netdb.h>

@implementation videosViewController
@synthesize btnComparte;
@synthesize btnLogout;
@synthesize fetchedResultsController;
@synthesize managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //custom navigationController
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.font=[UIFont fontWithName:@"Cochin-BoldItalic" size:27];
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];        
        label.text =@"Extras"; 
        self.navigationItem.titleView = label;
        [label sizeToFit];
        
        //info tab bar
        self.title =@"Extras";
        self.tabBarItem.image = [UIImage imageNamed:@"IconoExtras.png"];
        
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
    
    btnLogout.tintColor=[UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];
    btnComparte.tintColor=[UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];
    
    Analytics *Tracker = [Analytics sharedInstance];
    
    [Tracker track:@"Extra"];
    
 
    
    ObjFB = [FacebookMethods sharedInstance];
    if([ObjFB logged])
    {
        btnLogout.enabled=YES;
    }
    else
    {
        btnLogout.enabled=NO;
    }
    
    NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}

    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
 
    [self setBtnLogout:nil];
    [self setBtnComparte:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)viewWillAppear:(BOOL)animated
{
    ObjFB = [FacebookMethods sharedInstance];
    if([ObjFB logged])
    {
        btnLogout.enabled=YES;
    }
    else
    {
        btnLogout.enabled=NO;
    }
}
#pragma mark - TableView
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 60;
//    
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
    
    
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   
    return 1;
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

//    return ;

//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        
        //============Se Cambia el color al momento de selecionar una celda=========//
        UIView *vistaCellVideos = [[[UIView alloc] init] autorelease];
        vistaCellVideos.backgroundColor = [UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];
        cell.selectedBackgroundView = vistaCellVideos;
        //=====================//        
    }
    
    
    Compras *compra= [fetchedResultsController objectAtIndexPath:indexPath];
    if ([compra.comprarVideos intValue]>0)
    {

        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text=@"Videos";        
        cell.imageView.image= [UIImage imageNamed:@"IconoVideos.png"];
        return cell;    
    }
    
    
    // Configure the cell...
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.textColor=[UIColor redColor];
    cell.textLabel.text=@"Videos";
    cell.detailTextLabel.text=@"Desbloquea";
    cell.imageView.image= [UIImage imageNamed:@"IconoVideos.png"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    Compras *comprar=nil;    
    comprar = [fetchedResultsController objectAtIndexPath:indexPath];
    

    // verificar en la bd si esta comprado
    if ([comprar.comprarVideos intValue]>0){
        
        NSLog(@"Videos Comprados");
        //verificar si ahy red de datos
        if ((![self connectedToNetwork])) {
            NSLog(@"NO HAY CONEXION");
            // no hay red de datos
            UIAlertView * alertViewSinConexion = [[UIAlertView alloc] initWithTitle:@"Sin conexiòn" message:@"Debes estar conectado a una red de datos o WI-FI para ver los videos" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:Nil];
            [alertViewSinConexion show];        
            [alertViewSinConexion release];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            return;
            
        }
        
        else{    
 
    // si se cuenta con red y esta comprado
    DetalleVideosViewController *detailViewController = [[    DetalleVideosViewController alloc] initWithNibName:@"DetalleVideosViewController" bundle:nil];
    
    NSString *paquete1 = @"http://gdata.youtube.com/feeds/api/playlists/93F0FD865BA8F4BD";
    detailViewController.url = paquete1;
    detailViewController.paquete  = @"Paquete 1";
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [detailViewController release];
        } 
    }
    
    //los videos no estan comprados
    else{
        
        //verificar si ahy red
        if ((![self connectedToNetwork])) {
            NSLog(@"NO HAY CONEXION");
            // no hay red de datos
            UIAlertView * alertViewSinConexion = [[UIAlertView alloc] initWithTitle:@"Sin conexiòn" message:@"Debes estar conectado a una red de datos o WI-FI para ver los videos" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:Nil];
            [alertViewSinConexion show];        
            [alertViewSinConexion release];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            return;
            
        }
        
        
        
        UIAlertView * alertViewCompra = [[UIAlertView alloc] initWithTitle:@"Confirma tu compra dentro de la App" message:@"¿Quieres comprar una unidad de Extra: Videos a $12.00?" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar",Nil];
        [alertViewCompra show];        
        [alertViewCompra release];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
        
    }
    
    
    
    
}




- (void)dealloc {
    
    [btnLogout release];
    [btnComparte release];
    [super dealloc];
}

#pragma mark - Logout FaceBook
- (IBAction)LogOutFacebook:(id)sender {
    
    [ObjFB logOut];
    btnLogout.enabled=NO;
}

#pragma mark - Comparte correo
- (IBAction)btnComprteCorreo:(id)sender {
    
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
	mailController.mailComposeDelegate = self;
    
    
    //Add Asunto
	[mailController setSubject:@"Prueba esta útil aplicación - Remedios Caseros Tradicionales"];
    
    // Add Mensaje 
    NSMutableString* strMessage = [[[NSMutableString alloc] init]autorelease];	
    [strMessage appendString:[NSString stringWithFormat:@"<p align=justify> Es una aplicación gratuita para iPhone/iPod que contiene una serie de recetas y tips sobre belleza, salud y el hogar. Incluye un glosario para que conozcas algunos de los ingredientes utilizados, así como una nueva sección de Videos</p>La puedes bajar aquí: <a href=http://itun.es/isr2KS>http://itun.es/isr2KS</a>"]];
    NSString *emailBody =  strMessage;         
	[mailController setMessageBody:emailBody isHTML:YES];
    
    //    Add imagen
    UIImage *img = [UIImage imageNamed:@"remedios_114x114.png"];    
    NSData *imageData = UIImagePNGRepresentation(img);    
    [mailController addAttachmentData:imageData mimeType:@"image/png" fileName:@"Image"];
    
    //Presenta Correo
    [self presentModalViewController:mailController animated:YES];
	[mailController release];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)mailController didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark fetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController {
    
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Compras" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    //  NSPredicate *predicate =[NSPredicate predicateWithFormat:@"Categoria.titulo = %@" , self.remedio];  
    //[NSFetchedResultsController deleteCacheWithName:nil];
    
    //[fetchRequest setPredicate:predicate];
    
//     Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"comprarVideos" ascending:YES];
    
    // Edit the sort key as appropriate.
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numero" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:@"comprarVideos" cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    return fetchedResultsController;
}




#pragma mark AlertViewCompras

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
        NSLog(@"CANCELAR COMPRA!!!");
        return;
    }
    
    else if (buttonIndex == 1){
        
        NSLog(@"HACER PROCESO DE COMPRA Y CAMBIAR BASE DE DATOS A 1");
        
    }
}

#pragma mark Conexion a datos o wifi
- (BOOL) connectedToNetwork
{
	// Create zero addy
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags)
	{
		return NO;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	return (isReachable && !needsConnection) ? YES : NO;
}


@end

























