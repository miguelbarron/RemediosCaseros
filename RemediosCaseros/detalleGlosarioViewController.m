//
//  detalleGlosarioViewController.m
//  RemediosCaseros
//
//  Created by User on 3/27/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "detalleGlosarioViewController.h"
#import "Imagen.h"
@implementation detalleGlosarioViewController
@synthesize detalleGlosario;
@synthesize imagenGlosario;
@synthesize glosario,svView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
     [self.svView setContentSize:CGSizeMake(100,1000)];
    // Do any additional setup after loading the view from its nib.
    
    self.title=glosario.nombreIngrediente;
    Imagen *imrem=glosario.imagen;
    NSString *direccionImagen=imrem.imagenThumb;
    imagenGlosario.image=[UIImage imageNamed:direccionImagen];   
    
   // detalleGlosario.text=glosario.detalleIngrediente;
    
}

- (void)viewDidUnload
{
    [self setImagenGlosario:nil];
    [self setDetalleGlosario:nil];
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
    [imagenGlosario release];
    [detalleGlosario release];
    [svView release];
    [super dealloc];
}
@end
