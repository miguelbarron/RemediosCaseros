//
//  detalleGlosarioViewController.m
//  RemediosCaseros
//
//  Created by User on 3/27/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "detalleGlosarioViewController.h"
//#import "Imagen.h"
#import "detalleViewController.h"
#import "AppDelegate.h"
@implementation detalleGlosarioViewController
@synthesize detalleGlosario;
@synthesize imagenGlosario;
@synthesize glosario,svView,managedObjectContext;

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
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext=appDelegate.managedObjectContext;
    
    [self.svView setContentSize:CGSizeMake(100,1000)];
    // Do any additional setup after loading the view from its nib.  
    
    favoritoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(favorito:)];
    self.navigationItem.rightBarButtonItem = favoritoButton;
    [favoritoButton release];
    
    self.title=glosario.nombreIngrediente;
//    Imagen *imrem=glosario.imagen;
//    NSString *direccionImagen=imrem.imagenVista;
    NSString *direccionImagen=glosario.imagenVista;
    imagenGlosario.image=[UIImage imageNamed:direccionImagen];      
    detalleGlosario.text=glosario.detalleIngrediente;

    
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

-(void)favorito:(id)sender
{

    NSLog(@"agregado a favorito");
    if (!glosario.comprarIngrediente) {
        
        NSError *saveError;
        [glosario setComprarIngrediente:[NSNumber numberWithBool:YES]];
        if (![managedObjectContext save:&saveError]) {
            NSLog(@"Guardar a compras Fallo: %@", saveError);
        } else {
            
            UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Registro agregado" message:@"Registro agregado a Compras" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
            [errorAlert show];
            [errorAlert release];
            return;
            
            // The changes to bookTwo have been persisted.
        }
        
    }  else{
        UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Registro ya existe" message:@"Registro ya se encuentra en Compras" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
        return;
        
    }

}
@end
