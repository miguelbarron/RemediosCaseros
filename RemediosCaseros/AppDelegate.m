//
//  AppDelegate.m
//  RemediosCaseros
//
//  Created by Arturo Pruneda on 26/12/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import "AppDelegate.h"

#import "RootViewController.h"
#import "TestData.h"
#import "ConstantRemedios.h"
#import "detalleViewController.h"
#import "glosarioViewController.h"
#import "ComprasViewController.h"
#import "GANTracker.h"

static const NSInteger kGANDispatchPeriodSec = 10;
static NSString *const kGANDAccountId= @"UA-30984548-6";

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize tabBarController = _tabBarController;

- (void)dealloc
{
  [_window release];
  [__managedObjectContext release];
  [__managedObjectModel release];
  [__persistentStoreCoordinator release];
  
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    [[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-30984548-6" dispatchPeriod:kGANDispatchPeriodSec delegate:nil];
    [[GANTracker sharedTracker] setAnonymizeIp:YES];
    
    
    
    NSError *error;
    
    if (![[GANTracker sharedTracker] trackEvent:@"Application Launched"
                                         action:@"Launch app"
                                          label:@"Launch app"
                                          value:99
                                      withError:&error]) {
        NSLog(@"error in trackEvent");
    }
    
    if (![[GANTracker sharedTracker] trackPageview:@"Application Launched"
                                         withError:&error]) {
        NSLog(@"error in trackPageview");
    }
    
    
  UIViewController *viewController = [[[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil] autorelease];
  navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil] autorelease];
    UINavigationController *remediosNavController = [[[UINavigationController alloc] initWithRootViewController:viewController1] autorelease];
    
    
    UIViewController *viewController2 = [[[glosarioViewController alloc] initWithNibName:@"glosarioViewController" bundle:nil] autorelease];
    UINavigationController *glosarioNavController = [[[UINavigationController alloc] initWithRootViewController:viewController2] autorelease];
   

    UIViewController *viewController3 = [[[ComprasViewController alloc] initWithNibName:@"ComprasViewController" bundle:nil] autorelease];
    UINavigationController *comprasNavController = [[[UINavigationController alloc] initWithRootViewController:viewController3] autorelease];
       
    
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:remediosNavController,glosarioNavController,comprasNavController, nil];
    self.window.rootViewController = self.tabBarController;
    
    
    [self createEditableCopyOfDatabaseIfNeeded];
    
#if DEBUG_CREATE_DATA
    TestData *newTestData = [[TestData alloc] init];
    [newTestData createData];
#endif 
    [self.window makeKeyAndVisible];
    return YES;
    
}



#pragma mark - Core Data stack
/*

 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return __managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    __managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return __managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
	
    NSURL *storePath = [NSURL fileURLWithPath:[[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"RemediosCaseros.sqlite"]];
	
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storePath options:nil error:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return __persistentStoreCoordinator;
}

#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}


// Creates a writable copy of the bundled default database in the application Documents directory.
- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"RemediosCaseros.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
        return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"RemediosCaseros.sqlite"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}




@end
