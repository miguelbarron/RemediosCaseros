//
//  detalleViewController.m
//  RemediosCaseros
//
//  Created by User on 3/26/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "detalleViewController.h"
#import "Remedios.h"
//#import "Imagen.h"
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
       
    //compartirButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(favorito:)];
    UIImage *imagenCompartir=[UIImage imageNamed:@"icono_compartir_detalleremedio.png"];
    compartirButton = [[UIBarButtonItem alloc] initWithImage:imagenCompartir style:UIBarButtonItemStyleBordered target:self action:@selector(compartir:)];
    self.navigationItem.rightBarButtonItem = compartirButton;
    [compartirButton release]; 
    
    [self.svView setContentSize:CGSizeMake(100,500)];
//    Imagen *imrem=remedio.imagen;
//    NSString *direccionImagen=imrem.imagenThumb;
    NSString *direccionImagen=remedio.imagenThumb;
    imagenRemedio.image=[UIImage imageNamed:direccionImagen];   
    
    self.title=remedio.nombreRemedio;
    ingredientesRemedios.text=remedio.ingredientes;
    preparacionRemedio.text=remedio.preparacion;
    

   
 
    
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

-(void)compartir:(id)sender{
    NSLog(@"compartir Remedio");
}


@end
