//
//  detalleViewController.m
//  RemediosCaseros
//
//  Created by User on 3/26/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "detalleViewController.h"
#import "Remedios.h"
#import "Imagen.h"
#import "AppDelegate.h"

@implementation detalleViewController
@synthesize imagenRemedio;
@synthesize ingredientesRemedios;
@synthesize preparacionRemedio;
@synthesize svView;
@synthesize remedio;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
       //[self.svView setContentSize:CGSizeMake(320,1700)];
//    detalleViewController *viewController1 = [[[detalleViewController alloc] ;
      
        //UIViewController *viewController2 = [[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil] autorelease];
       
    [self.svView setContentSize:CGSizeMake(100,500)];
    Imagen *imrem=remedio.imagen;
    NSString *direccionImagen=imrem.imagenThumb;
    imagenRemedio.image=[UIImage imageNamed:direccionImagen];   
    
    self.title=remedio.nombreRemedio;
    ingredientesRemedios.text=remedio.ingredientes;
    preparacionRemedio.text=remedio.preparacion;
    
//    UITabBarController *tabBController = [[UITabBarController alloc] init];
//    tabBController.view.frame = CGRectMake(0, 0, 320, 460);
  //  [self addSubview:tabBarController.view];
   
 
    
}
- (void)viewDidUnload
{
    [self setImagenRemedio:nil];
    [self setIngredientesRemedios:nil];
    [self setPreparacionRemedio:nil];
    [self setSvView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [imagenRemedio release];
    [ingredientesRemedios release];
    [preparacionRemedio release];
    [svView release];
    [super dealloc];
}
@end
