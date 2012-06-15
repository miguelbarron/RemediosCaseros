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

@interface videosViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    FacebookMethods *ObjFB;
    BOOL *flag_;
}

- (IBAction)LogOutFacebook:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnLogout;
- (IBAction)btnComprteCorreo:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnComparte;

@end
