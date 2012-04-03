//
//  detalleViewController.h
//  RemediosCaseros
//
//  Created by User on 3/26/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Remedios.h"

@interface detalleViewController : UIViewController
{
    Remedios *remedio;
    UIBarButtonItem *compartirButton;
}
@property (retain, nonatomic) IBOutlet UIImageView *imagenRemedio;
@property (retain, nonatomic) IBOutlet UITextView *ingredientesRemedios;
@property (retain, nonatomic) IBOutlet UITextView *preparacionRemedio;
@property (retain, nonatomic) IBOutlet UIScrollView *svView;
@property (retain, nonatomic) Remedios *remedio;
-(void)compartir:(id)sender ;
@end
