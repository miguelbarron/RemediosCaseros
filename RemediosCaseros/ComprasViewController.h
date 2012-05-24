//
//  ComprasViewController.h
//  RemediosCaseros
//
//  Created by User on 4/2/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Glosario.h"
#import "Analytics.h"

@interface ComprasViewController : UIViewController<NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    UIBarButtonItem *eliminarButton;
    Analytics *Tracker;
}

@property(retain,nonatomic)NSFetchedResultsController *fetchedResultsController;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
-(void)eliminarCompra:(id)sender ;

@end
