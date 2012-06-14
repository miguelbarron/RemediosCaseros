//
//  videosViewController.m
//  RemediosCaseros
//
//  Created by User on 6/11/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "videosViewController.h"
#import "DetalleVideosViewController.h"
@implementation videosViewController
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
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];
    
    btnLogout.tintColor=[UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];
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
    
    NSString *paquete1 = @"http://gdata.youtube.com/feeds/api/playlists/93F0FD865BA8F4BD";
    
    
    DetalleVideosViewController *detailViewController = [[    DetalleVideosViewController alloc] initWithNibName:@"DetalleVideosViewController" bundle:nil];
    // ...      
    // Pass the selected object to the new view controller.

    detailViewController.url = paquete1;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
    
    
}




- (void)dealloc {
    
    [btnLogout release];
    [super dealloc];
}
- (IBAction)LogOutFacebook:(id)sender {
    
    [ObjFB logOut];
    btnLogout.enabled=NO;
}
@end
