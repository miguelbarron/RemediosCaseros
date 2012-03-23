//
//  FirstViewController.h
//  RemediosCaseros
//
//  Created by Arturo Pruneda on 26/12/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *tituloRemedio;
@property (retain, nonatomic) IBOutlet UITextView *ingredientesRemedios;
@property (retain, nonatomic) IBOutlet UITextView *preparacionRemedio;

@end
