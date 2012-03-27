//
//  TestData.m
//  RemediosCaseros
//
//  Created by User on 3/21/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "TestData.h"
#import "AppDelegate.h"
#import "Categoria.h"
#import "Remedios.h"
#import "Glosario.h"
#import "Imagen.h"


@implementation TestData
@synthesize addingManagedObjectContext,managedObjectContext;

-(void)createData
{
    //Obtener Contexto

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    managedObjectContext = appDelegate.managedObjectContext;
    
    // crear categoria
    Categoria *categoria1=[NSEntityDescription insertNewObjectForEntityForName:@"Categoria" inManagedObjectContext:managedObjectContext];
    categoria1.titulo=@"Salud";
    
    Categoria *categoria2=[NSEntityDescription insertNewObjectForEntityForName:@"Categoria" inManagedObjectContext:managedObjectContext];
    categoria2.titulo=@"Hogar";
    
    Categoria *categoria3=[NSEntityDescription insertNewObjectForEntityForName:@"Categoria" inManagedObjectContext:managedObjectContext];
    categoria3.titulo=@"Belleza";
    
    //crear imagenes
    Imagen *imagen1=[NSEntityDescription insertNewObjectForEntityForName:@"Imagen" inManagedObjectContext:managedObjectContext];
    imagen1.imagenThumb=@"coco.png";
    imagen1.nombre=@"coco";
    
    Imagen *imagen2=[NSEntityDescription insertNewObjectForEntityForName:@"Imagen" inManagedObjectContext:managedObjectContext];
    imagen2.imagenThumb=@"foco.jpg";
    imagen2.nombre=@"foco";
    
    Imagen *imagen3=[NSEntityDescription insertNewObjectForEntityForName:@"Imagen" inManagedObjectContext:managedObjectContext];
    imagen3.imagenThumb=@"limpia.jpg";
    imagen3.nombre=@"limpia";
    
    //se crea remedios
    Remedios *remedio1=[NSEntityDescription insertNewObjectForEntityForName:@"Remedios" inManagedObjectContext:managedObjectContext];
    remedio1.nombreRemedio=@"Aceite de coco";
    remedio1.subtitulo=@"Crear un aceite de coco";
    remedio1.ingredientes=@"pulpa de coco";
    remedio1.preparacion=@"Se extrae de la pulpa de coco mediante prensado, y contiene un 90% de ácidos grasos saturados.    El aceite de coco es, también, conocido como mantequilla de coco pues se solidifica por debajo de los 23º C. El aceite de coco es muy resistente ya que puede durar años sin estropearse ";
    remedio1.imagen=imagen1;
    
    
    NSSet *agregarremedio=[[[NSSet alloc] initWithObjects:remedio1, nil] autorelease];
    [categoria3 addRemedio:agregarremedio];
    
    
    
    
    Remedios *remedio2=[NSEntityDescription insertNewObjectForEntityForName:@"Remedios" inManagedObjectContext:managedObjectContext];
    remedio2.nombreRemedio=@"Cómo ahorrar energía en el hogar";
    remedio2.subtitulo=@"Tips para ahorrar energia";
    remedio2.ingredientes=@"ingredientes de remedios 3";
    remedio2.preparacion=@"Lavadora:    Usar en lo posible lavados fríos o a menos temperatura. Mejor si se disuelve el detergente en polvo antes de echarlo a la lavadora. Utilizar los programas de lavado económico y centrifugar lo menos posible.Hacer lavados con el electrodoméstico lleno ";
    remedio2.imagen=imagen2;
    
    Remedios *remedio3=[NSEntityDescription insertNewObjectForEntityForName:@"Remedios" inManagedObjectContext:managedObjectContext];
    remedio3.nombreRemedio=@"limpiacristales ecológicos";
    remedio3.subtitulo=@"Crear un Limpiacristales con un limón";
    remedio3.ingredientes=@"Un limón grande.Un vaso de vinagre blanco.Un vaso y medio de agua.Una botellita con difusor";
    remedio3.preparacion=@"Se exprime el limón y se introduce en la botella con difusor, se añade el vaso de vinagre y el de agua. Se agita y ya está listo el limpiacristales ecológico casero. No olvide agitar en cada uso.";   
    remedio3.imagen=imagen3;
   
    NSSet *agregarremedio2=[[[NSSet alloc] initWithObjects:remedio2,remedio3, nil] autorelease];
    [categoria2 addRemedio:agregarremedio2];
    

    Remedios *remedio4=[NSEntityDescription insertNewObjectForEntityForName:@"Remedios" inManagedObjectContext:managedObjectContext];
    remedio4.nombreRemedio=@"remedio categoria salud";
    remedio4.subtitulo=@"subtitulo de remedio";
    remedio4.ingredientes=@"ingredientes de remedios de salud";
    remedio4.preparacion=@"preparacion de remedios ";
    
    NSSet *agregarremedio3=[[[NSSet alloc] initWithObjects:remedio4, nil] autorelease];
    [categoria1 addRemedio:agregarremedio3];
    

    //crear imagen Glosario
    Imagen *imagenRemedio=[NSEntityDescription insertNewObjectForEntityForName:@"Imagen" inManagedObjectContext:managedObjectContext];
    imagenRemedio.nombre=@"Ficus";
    imagenRemedio.imagenThumb=@"ficus.jpg";
    imagenRemedio.imagenVista=@"ficus.jpg";
    
    //crear glosario
    Glosario *glosario1=[NSEntityDescription insertNewObjectForEntityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
    glosario1.nombreIngrediente=@"nombre Glosario";
    glosario1.detalleIngrediente=@"detalle del glosario";
    glosario1.imagen=imagenRemedio;
    
    
    
    
    Glosario *glosario2=[NSEntityDescription insertNewObjectForEntityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
    glosario2.nombreIngrediente=@"nombre Glosario 2";
    glosario2.detalleIngrediente=@"detalle del glosario 2";
    
    Glosario *glosario3=[NSEntityDescription insertNewObjectForEntityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
    glosario3.nombreIngrediente=@"nombre Glosario 3";
    glosario3.detalleIngrediente=@"detalle del glosario 3";
    
 
    
    
    

    
    
    
    
    
    
    
    ///salvar contexto
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }

    
    
}
@end
