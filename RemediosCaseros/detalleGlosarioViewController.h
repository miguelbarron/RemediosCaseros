//
//  detalleGlosarioViewController.h
//  RemediosCaseros
//
//  Created by User on 3/27/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Glosario.h"
@interface detalleGlosarioViewController : UIViewController
{
    Glosario *glosario;
    UIBarButtonItem *favoritoButton;
    NSManagedObjectContext *managedObjectContext;
}
@property (retain, nonatomic) Glosario *glosario;
@property (retain, nonatomic) IBOutlet UITextView *detalleGlosario;
@property (retain, nonatomic) IBOutlet UIImageView *imagenGlosario;
@property (retain, nonatomic) IBOutlet UIScrollView *svView;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
-(void)favorito:(id)sender ;
@end
