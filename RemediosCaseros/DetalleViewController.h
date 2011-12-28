//
//  DetalleViewController.h
//  RemediosCaseros
//
//  Created by Arturo Pruneda on 26/12/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Remedio.h"

@interface DetalleViewController : UIViewController <UITabBarControllerDelegate>


@property (strong, nonatomic) UITabBarController *tabBarController;
@property (nonatomic, retain) Remedio *miRemedio;

@end
