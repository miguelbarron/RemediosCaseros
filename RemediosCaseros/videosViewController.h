//
//  videosViewController.h
//  RemediosCaseros
//
//  Created by User on 6/11/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookMethods.h"

@interface videosViewController : UIViewController
{
    FacebookMethods *ObjFB;
    BOOL *flag_;
}

- (IBAction)LogOutFacebook:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnLogout;

@end
