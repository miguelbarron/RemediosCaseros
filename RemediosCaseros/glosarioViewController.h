//
//  glosarioViewController.h
//  RemediosCaseros
//
//  Created by User on 3/27/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface glosarioViewController : UIViewController<NSFetchedResultsControllerDelegate>{
    
    NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext; 
    
}
@property(retain,nonatomic)NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
