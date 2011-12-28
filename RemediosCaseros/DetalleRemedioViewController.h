//
//  DetalleRemedioViewController.h
//  RemediosCaseros
//
//  Created by Arturo Pruneda on 27/12/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Remedio.h"

@interface DetalleRemedioViewController : UIViewController

@property (nonatomic, retain) Remedio *miRemedio;
@property (retain, nonatomic) IBOutlet UILabel *labelRemedio;

@end
