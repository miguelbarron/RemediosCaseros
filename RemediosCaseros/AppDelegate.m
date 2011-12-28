//
//  AppDelegate.m
//  RemediosCaseros
//
//  Created by Arturo Pruneda on 26/12/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import "AppDelegate.h"

#import "RootViewController.h"



@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController;

- (void)dealloc
{
  [_window release];
  
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  // Override point for customization after application launch.
  UIViewController *viewController = [[[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil] autorelease];
  navigationController = [[UINavigationController alloc]
                          initWithRootViewController:viewController];
  
  [self.window addSubview:navigationController.view];
  [self.window makeKeyAndVisible];
  return YES;
}


@end
