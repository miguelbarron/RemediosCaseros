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
#import "Classes/SBJson.h"

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
    
    Imagen *imagenRemedio2=[NSEntityDescription insertNewObjectForEntityForName:@"Imagen" inManagedObjectContext:managedObjectContext];
    imagenRemedio2.nombre=@"Ficus";
    imagenRemedio2.imagenThumb=@"menta.jpg";
    imagenRemedio2.imagenVista=@"menta.jpg";
    
    Imagen *imagenRemedio3=[NSEntityDescription insertNewObjectForEntityForName:@"Imagen" inManagedObjectContext:managedObjectContext];
    imagenRemedio3.nombre=@"Ficus";
    imagenRemedio3.imagenThumb=@"cannabis.jpg";
    imagenRemedio3.imagenVista=@"cannabis.jpg";
    

    
    //crear glosario
    Glosario *glosario1=[NSEntityDescription insertNewObjectForEntityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
    glosario1.nombreIngrediente=@"Ficus Religiosa";
    glosario1.detalleIngrediente=@"Es un gran árbol de estación seca, caducifolio o semi-siempreverde, de más de 30 m de altura y con un diámetro de tronco de más de 3 m. Las hojas son cordadas con un distintivo zarcillo en la punta; de 10-17 cm de longitud y 8-12 cm de ancho, con pecíolo de 6-10 cm. El fruto es un pequeño higo de 1-1,5 cm de diámetro, verde que madura a púrpura.";
    glosario1.imagen=imagenRemedio;
    
    
    
    
    Glosario *glosario2=[NSEntityDescription insertNewObjectForEntityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
    glosario2.nombreIngrediente=@"Mentha aquatica";
    glosario2.detalleIngrediente=@"Crece alrededor de 90 cm de altura, aunque puede alcanzar 1,5 m cuando es soportada por vegetación más alta, y tiene un característico aroma a menta. Las hojas son ovadas a ovado-lanceoladas, verdes (a veces purpúreas), opuestas, suaves, venadas pueden tener pilosidad o ser glabra. Los tallos son frecuentemente de color púrpura. Las flores son pequeñas, densas, tubulares, de color rosado a lila. Florece de julio a septiembre. Es polinizada por insectos, aunque se puede propagar fácilmente por cortes de raíces, como otras especies de menta.";
    glosario2.imagen=imagenRemedio2;
    
    Glosario *glosario3=[NSEntityDescription insertNewObjectForEntityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
    glosario3.nombreIngrediente=@"Cannabis sativa";
    glosario3.detalleIngrediente=@"Cannabis sativa (cáñamo o marihuana)1 es una especie herbácea de la familia Cannabaceae, con propiedades psicoactivas. Es una planta anual originaria de las cordilleras del Himalaya, Asia.2 Los seres humanos han cultivado esta planta en el transcurso de la historia como fuente de fibra textil, aceite de semillas y como alimentos, —en el caso de las variedades sin contenido de THC (cáñamo)—. Se ha utilizado durante milenios la planta como una medicina —con registros escritos que datan de 2737 a.C.—,3 como droga, y como una herramienta espiritual. Su fibra tiene usos variados, incluyendo la manufactura de vestidos, cuerdas, ropa, y papel. El aceite de sus semillas se puede usar como combustible.";
    glosario3.imagen=imagenRemedio3;
    
 /*
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext=appDelegate.managedObjectContext;
    NSManagedObject *newData;
    
    
    //==========Conexion Categoria
    NSString *urlStringCategoria = [NSString stringWithFormat:@"http://neostar.org/test/Remedios_JSON/Categoria.json"];         
    NSURL *urlCategoria = [NSURL URLWithString:urlStringCategoria];    
    NSString *dataCategoria = [NSString stringWithContentsOfURL:urlCategoria encoding:NSUTF8StringEncoding error:nil];    
    SBJsonParser *parserCategoria = [[SBJsonParser alloc] init];   
    NSMutableDictionary *myCategoria =[parserCategoria objectWithString:dataCategoria];    
    NSMutableArray *arrayCategoria=[myCategoria objectForKey:@"Categoria"];    
    int categoriaIndex=0;
    //NSManagedObject *newData;
    for (NSDictionary *RecorrerjsonCategoria in arrayCategoria){
        //=========== llenando Categoria core ============    
        
        
        newData=[NSEntityDescription insertNewObjectForEntityForName:@"Categoria" inManagedObjectContext:managedObjectContext];
        [newData setValue:[[arrayCategoria objectAtIndex:categoriaIndex] objectForKey:@"titulo"] forKey:@"titulo"];
        

        
        
        categoriaIndex++;   
    }    
    
 
    //=================== conexion  Remedios ============//    
    NSString *urlString = [NSString stringWithFormat:@"http://neostar.org/test/Remedios_JSON/Remedios.json"];         
    NSURL *url = [NSURL URLWithString:urlString];    
    NSString *dataRemedios = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];    
    SBJsonParser *parser = [[SBJsonParser alloc] init];   
    NSMutableDictionary *myRemedios =[parser objectWithString:dataRemedios];    
    NSMutableArray *arrayRemedios=[myRemedios objectForKey:@"Remedios"];

    
    
    
    int remedioIndex=0;
    
    
    for (NSDictionary *Recorrerjson in arrayRemedios){
        //=========== llenando Remedios core ============    
        
        
        newData=[NSEntityDescription insertNewObjectForEntityForName:@"Remedios" inManagedObjectContext:managedObjectContext];
        [newData setValue:[[arrayRemedios objectAtIndex:remedioIndex] objectForKey:@"nombreRemedio"] forKey:@"nombreRemedio"];
        [newData setValue:[[arrayRemedios objectAtIndex:remedioIndex] objectForKey:@"preparacion"] forKey:@"preparacion"];    
        [newData setValue:[[arrayRemedios objectAtIndex:remedioIndex] objectForKey:@"ingredientes"] forKey:@"ingredientes"];  
        [newData setValue:[[arrayRemedios objectAtIndex:remedioIndex] objectForKey:@"subtitulo"] forKey:@"subtitulo"];



                
        
        
        remedioIndex++;   
    }    
    //==========Conexion Glosario
    NSString *urlStringGlosario = [NSString stringWithFormat:@"http://neostar.org/test/Remedios_JSON/Glosario.json"];         
    NSURL *urlGlosario = [NSURL URLWithString:urlStringGlosario];    
    NSString *dataGlosario = [NSString stringWithContentsOfURL:urlGlosario encoding:NSUTF8StringEncoding error:nil];    
    SBJsonParser *parserGlosario = [[SBJsonParser alloc] init];   
    NSMutableDictionary *myGlosario =[parserGlosario objectWithString:dataGlosario];    
    NSMutableArray *arrayGlosario=[myGlosario objectForKey:@"Glosario"];    
    int GlosarioIndex=0;
    
    for (NSDictionary *RecorrerjsonGlosario in arrayGlosario){
        //=========== llenando Glosario core ============    
        
        
        newData=[NSEntityDescription insertNewObjectForEntityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
        [newData setValue:[[arrayGlosario objectAtIndex:GlosarioIndex] objectForKey:@"comprarIngrediente"] forKey:@"comprarIngrediente"];
        [newData setValue:[[arrayGlosario objectAtIndex:GlosarioIndex] objectForKey:@"detalleIngredientes"] forKey:@"detalleIngrediente"];
        [newData setValue:[[arrayGlosario objectAtIndex:GlosarioIndex] objectForKey:@"nombreIngrediente"] forKey:@"nombreIngrediente"];

        
        
        
        GlosarioIndex++;   
    }


    //==========Conexion Imagen
    NSString *urlStringImagen = [NSString stringWithFormat:@"http://neostar.org/test/Remedios_JSON/Imagen.json"];         
    NSURL *urlImagen = [NSURL URLWithString:urlStringImagen];    
    NSString *dataImagen = [NSString stringWithContentsOfURL:urlImagen encoding:NSUTF8StringEncoding error:nil];    
    SBJsonParser *parserImagen = [[SBJsonParser alloc] init];   
    NSMutableDictionary *myImagen =[parserImagen objectWithString:dataImagen];    
    NSMutableArray *arrayImagen=[myImagen objectForKey:@"Imagen"];    
    int imagenIndex=0;
    
    for (NSDictionary *RecorrerjsonImagen in arrayImagen){
        //=========== llenando Imagen core ============    
        
        
        newData=[NSEntityDescription insertNewObjectForEntityForName:@"Imagen" inManagedObjectContext:managedObjectContext];
        [newData setValue:[[arrayImagen objectAtIndex:imagenIndex] objectForKey:@"imagenThumb"] forKey:@"imagenThumb"];
        [newData setValue:[[arrayImagen objectAtIndex:imagenIndex] objectForKey:@"imagenVista"] forKey:@"imagenVista"];
        [newData setValue:[[arrayImagen objectAtIndex:imagenIndex] objectForKey:@"nombre"] forKey:@"nombre"];

        
        
        
        imagenIndex++;   
    }    
    
    
    
    */
    
    
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
