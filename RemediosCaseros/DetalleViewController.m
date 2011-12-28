//
//  DetalleViewController.m
//  RemediosCaseros
//
//  Created by Arturo Pruneda on 26/12/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import "DetalleViewController.h"
#import "CompartirViewController.h"
#import "GlosarioViewController.h"
#import "DetalleRemedioViewController.h"


@implementation DetalleViewController

@synthesize tabBarController = _tabBarController;
@synthesize miRemedio;


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
   NSLog(@"Detalle elemento: %@", [self.miRemedio.remedio description]);

  DetalleRemedioViewController *drvc = [[DetalleRemedioViewController alloc] initWithNibName:@"DetalleRemedioViewController"
                                                                         bundle:[NSBundle mainBundle]];
  GlosarioViewController *gvc = [[GlosarioViewController alloc] initWithNibName:@"GlosarioViewController"
                                                                         bundle:[NSBundle mainBundle]];
  CompartirViewController *cvc = [[CompartirViewController alloc] initWithNibName:@"CompartirViewController"
                                                                           bundle:[NSBundle mainBundle]];
  // Create an empty tab controller and set it to fill the screen minus the top title bar
  UITabBarController *tabBController = [[UITabBarController alloc] init];
	tabBController.view.frame = CGRectMake(0, 0, 320, 460);
  drvc.miRemedio = self.miRemedio;
  
  
  drvc.tabBarItem.image =  [UIImage imageNamed:@"receta.png"];
  gvc.tabBarItem.image  =  [UIImage imageNamed:@"glosario.png"];
  cvc.tabBarItem.image  =  [UIImage imageNamed:@"tweet.png"];
  
  // Set each tab to show an appropriate view controller
  [tabBController setViewControllers:[NSArray arrayWithObjects:drvc, gvc, cvc, nil]];
  
  // Clean up objects we don't need anymore
  [drvc release];
  [gvc release];
	[cvc release];

  
  // Finally, add the tab controller view to the parent view
  [self.view addSubview:tabBController.view];   
    // Do any additional setup after loading the view from its nib.
  // Override point for customization after application launch.
  
}



- (void) dealloc {
    [_tabBarController release];
}

@end
