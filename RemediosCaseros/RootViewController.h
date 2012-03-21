//
//  RootViewController.h
//  RemediosCaseros
//
//  Created by Arturo Pruneda on 26/12/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Remedio.h"
#import "AppDelegate.h"

@interface RootViewController : UITableViewController<NSFetchedResultsControllerDelegate>{
    NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext; 
    
    NSArray *arrayConDOEnGrupos;
}
@property(retain,nonatomic)NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSArray *arrayConDOEnGrupos;
@property (nonatomic, retain) Remedio *miRemedio;

@end
