//
//  videosViewController.h
//  RemediosCaseros
//
//  Created by User on 6/11/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookMethods.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"

@interface videosViewController : UIViewController<MFMailComposeViewControllerDelegate,NSFetchedResultsControllerDelegate>
{
    FacebookMethods *ObjFB;
    BOOL *flag_;
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

- (IBAction)LogOutFacebook:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnLogout;
- (IBAction)btnComprteCorreo:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnComparte;
@property (retain,nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (retain,nonatomic)NSManagedObjectContext *managedObjectContext;
@end
