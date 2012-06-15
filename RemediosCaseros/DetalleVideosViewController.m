//
//  DetalleVideosViewController.m
//  RemediosCaseros
//
//  Created by Alex Diaz on 14/06/2012.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "DetalleVideosViewController.h"
#import "Analytics.h"

@interface DetalleVideosViewController ()

@end

@implementation DetalleVideosViewController
@synthesize url = _url;
@synthesize paquete = _paquete;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    PX = [ParseXML sharedInstance];
    [PX grabRSSVideos:self.url];
    
    Analytics *Tracker = [Analytics sharedInstance];
    
    NSString*trackPaquete = [NSString stringWithFormat:@"Videos del %@",self.paquete];
    [Tracker track:trackPaquete];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [PX.videos count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        //============Se Cambia el color al momento de selecionar una celda=========//
        UIView *vistaCellRemedios = [[[UIView alloc] init] autorelease];
        vistaCellRemedios.backgroundColor = [UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];
        cell.selectedBackgroundView = vistaCellRemedios;
        //=====================//
    }
    
    // Configure the cell...
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold"  size:15.0];     
    cell.textLabel.textColor=[UIColor colorWithRed:0.192 green:0.255 blue:0.349 alpha:1.0];
    cell.detailTextLabel.font= [UIFont fontWithName:@"Helvetica" size:12.0];    
    cell.detailTextLabel.numberOfLines=2;
    cell.textLabel.numberOfLines=2;
    
    
    
    NSString* imageURL = [[PX.videos objectAtIndex:indexPath.row]objectForKey:@"thumb"];
    NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imageURL]];
	
    UIImage* image = [[UIImage alloc] initWithData:imageData];

    cell.imageView.image = image;
    
    // Configure the cell...
    cell.textLabel.text = [[PX.videos objectAtIndex:indexPath.row]objectForKey:@"Name"];
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
