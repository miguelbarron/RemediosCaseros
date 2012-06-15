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

@implementation videosViewController
@synthesize btnComparte;
@synthesize btnLogout;


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
        label.text =@"Extra"; 
        self.navigationItem.titleView = label;
        [label sizeToFit];
        
        //info tab bar
        self.title =@"Extra";
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
    
   
    return 2;
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

//    return ;

//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        //============Se Cambia el color al momento de selecionar una celda=========//
        UIView *vistaCellVideos = [[[UIView alloc] init] autorelease];
        vistaCellVideos.backgroundColor = [UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];
        cell.selectedBackgroundView = vistaCellVideos;
        //=====================//        
    }
    
    // Configure the cell...
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    
    DetalleVideosViewController *detailViewController = [[    DetalleVideosViewController alloc] initWithNibName:@"DetalleVideosViewController" bundle:nil];
    // ...      
    // Pass the selected object to the new view controller.
    NSString *paquete1 = @"http://gdata.youtube.com/feeds/api/playlists/93F0FD865BA8F4BD";
    detailViewController.url = paquete1;
    detailViewController.paquete  = @"Paquete 1";
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
    
    
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
    [strMessage appendString:[NSString stringWithFormat:@"<p align=justify> Es una aplicación gratuita para iPhone/iPod que contiene una serie de recetas y tips sobre belleza, salud y el hogar. Incluye un glosario para que conozcas algunos de los ingredientes utilizados, así como una nueva sección de Videos</p>La puedes bajar aquí: <a href=url>http://itun.es/isr2KS</a>"]];
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

@end

























