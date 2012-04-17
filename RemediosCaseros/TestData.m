//
//  TestData.m
//  RemediosCaseros
//
//  Created by User on 3/21/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "TestData.h"
#import "AppDelegate.h"
#import "Remedios.h"
#import "Glosario.h"
#import "SBJson.h"

@implementation TestData
@synthesize addingManagedObjectContext,managedObjectContext;


-(void)createData
{
    
    /*/Obtener Contexto

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    managedObjectContext = appDelegate.managedObjectContext;

    
    //se crea remedios
    Remedios *remedio1=[NSEntityDescription insertNewObjectForEntityForName:@"Remedios" inManagedObjectContext:managedObjectContext];
    remedio1.nombreRemedio=@"Aceite de coco";
    remedio1.subtitulo=@"Crear un aceite de coco";
    remedio1.ingredientes=@"pulpa de coco";
    remedio1.preparacion=@"Se extrae de la pulpa de coco mediante prensado, y contiene un 90% de ácidos grasos saturados.    El aceite de coco es, también, conocido como mantequilla de coco pues se solidifica por debajo de los 23º C. El aceite de coco es muy resistente ya que puede durar años sin estropearse ";
    remedio1.categoriaRemedio=@"Salud";
    remedio1.imagenThumb=@"foto_celda_remedios.png";
    
    
    
     
    
    
    Remedios *remedio2=[NSEntityDescription insertNewObjectForEntityForName:@"Remedios" inManagedObjectContext:managedObjectContext];
    remedio2.nombreRemedio=@"Cómo ahorrar energía en el hogar";
    remedio2.subtitulo=@"Tips para ahorrar energia";
    remedio2.ingredientes=@"ingredientes de remedios 3";
    remedio2.preparacion=@"Lavadora:    Usar en lo posible lavados fríos o a menos temperatura. Mejor si se disuelve el detergente en polvo antes de echarlo a la lavadora. Utilizar los programas de lavado económico y centrifugar lo menos posible.Hacer lavados con el electrodoméstico lleno ";
    remedio2.imagenThumb=@"foto2_celda_remedios.png";        
    remedio2.categoriaRemedio=@"Hogar";
    
    Remedios *remedio3=[NSEntityDescription insertNewObjectForEntityForName:@"Remedios" inManagedObjectContext:managedObjectContext];
    remedio3.nombreRemedio=@"limpiacristales ecológicos";
    remedio3.subtitulo=@"Crear un Limpiacristales con un limón";
    remedio3.ingredientes=@"*Un limón grande. \n *Un vaso de vinagre blanco. \n *Un vaso y medio de agua. \n *Una botellita con difusor";
    remedio3.preparacion=@"Se exprime el limón y se introduce en la botella con difusor, se añade el vaso de vinagre y el de agua. Se agita y ya está listo el limpiacristales ecológico casero. No olvide agitar en cada uso.";   
    remedio3.categoriaRemedio=@"Hogar";
    remedio3.imagenThumb=@"limpia.jpg";
    

    

    Remedios *remedio4=[NSEntityDescription insertNewObjectForEntityForName:@"Remedios" inManagedObjectContext:managedObjectContext];
    remedio4.nombreRemedio=@"remedio ";
    remedio4.subtitulo=@"subtitulo de remedio";
    remedio4.ingredientes=@"ingredientes de remedios ";
    remedio4.preparacion=@"preparacion de remedios ";
    remedio4.categoriaRemedio=@"Belleza";
    remedio4.imagenThumb=@"second.png";
    
    

    

    
    //crear glosario
    Glosario *glosario1=[NSEntityDescription insertNewObjectForEntityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
    glosario1.nombreIngrediente=@"Ficus Religiosa";
    glosario1.detalleIngrediente=@"Es un gran árbol de estación seca, caducifolio o semi-siempreverde, de más de 30 m de altura y con un diámetro de tronco de más de 3 m. Las hojas son cordadas con un distintivo zarcillo en la punta; de 10-17 cm de longitud y 8-12 cm de ancho, con pecíolo de 6-10 cm. El fruto es un pequeño higo de 1-1,5 cm de diámetro, verde que madura a púrpura.";
    glosario1.imagenThumb=@"ficus.jpg";
        
    
    
    
    Glosario *glosario2=[NSEntityDescription insertNewObjectForEntityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
    glosario2.nombreIngrediente=@"Mentha aquatica";
    glosario2.detalleIngrediente=@"Crece alrededor de 90 cm de altura, aunque puede alcanzar 1,5 m cuando es soportada por vegetación más alta, y tiene un característico aroma a menta. Las hojas son ovadas a ovado-lanceoladas, verdes (a veces purpúreas), opuestas, suaves, venadas pueden tener pilosidad o ser glabra. Los tallos son frecuentemente de color púrpura. Las flores son pequeñas, densas, tubulares, de color rosado a lila. Florece de julio a septiembre. Es polinizada por insectos, aunque se puede propagar fácilmente por cortes de raíces, como otras especies de menta.";
    glosario2.imagenThumb=@"menta.jpg";
        
    Glosario *glosario3=[NSEntityDescription insertNewObjectForEntityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
    glosario3.nombreIngrediente=@"Cannabis sativa";
    glosario3.detalleIngrediente=@"Cannabis sativa (cáñamo o marihuana)1 es una especie herbácea de la familia Cannabaceae, con propiedades psicoactivas. Es una planta anual originaria de las cordilleras del Himalaya, Asia.2 Los seres humanos han cultivado esta planta en el transcurso de la historia como fuente de fibra textil, aceite de semillas y como alimentos, —en el caso de las variedades sin contenido de THC (cáñamo)—. Se ha utilizado durante milenios la planta como una medicina —con registros escritos que datan de 2737 a.C.—,3 como droga, y como una herramienta espiritual. Su fibra tiene usos variados, incluyendo la manufactura de vestidos, cuerdas, ropa, y papel. El aceite de sus semillas se puede usar como combustible.";
    glosario3.imagenThumb=@"cannabis.jpg";
    
    
 */
    
    // Obtiene el número de remedios para saber si hay actualizaciones
    
    NSString *urlConfigString = [NSString stringWithFormat:@"http://neostar.org/test/Remedios_JSON/Configuracion.json"];         
    NSURL *urlConfig = [NSURL URLWithString:urlConfigString];    
    NSString *dataConfig = [NSString stringWithContentsOfURL:urlConfig encoding:NSUTF8StringEncoding error:nil];    
    SBJsonParser *parser = [[SBJsonParser alloc] init];   
    NSMutableDictionary *myConfig =[parser objectWithString:dataConfig];    
 
    NSMutableArray *arrayRemedios=[myConfig objectForKey:@"Configuracion"];
   
    int i = 0;
    
    int numTotalRemedios = 0;
    int numTotalGlosario = 0;
    //NSString *registros = [[arrayRemedios objectAtIndex:i] objectForKey:@"Registros"];
    numTotalRemedios = [[[arrayRemedios objectAtIndex:i] objectForKey:@"Registros"] intValue]; 
    numTotalGlosario = [[[arrayRemedios objectAtIndex:i] objectForKey:@"Glosario"]  intValue];                          
                         
    
    
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    managedObjectContext=appDelegate.managedObjectContext;
    NSManagedObject *newData;
    
    // Revisa si la Entidad Remedios está vacía o hay nuevos remedios que descargar
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Remedios" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *array = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (array == nil)
    {
        // Deal with error...
    }
    
    else if (([array count] <= 0) || (([array count] != numTotalRemedios)) ) {
        
        //=================== conexion  Remedios ============//    
        NSString *urlString = [NSString stringWithFormat:@"http://neostar.org/test/Remedios_JSON/Remedios.json"];         
        NSURL *url = [NSURL URLWithString:urlString];    
        NSString *dataRemedios = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];    
        SBJsonParser *parser = [[SBJsonParser alloc] init];   
        NSMutableDictionary *myRemedios =[parser objectWithString:dataRemedios];    
        NSMutableArray *arrayRemedios=[myRemedios objectForKey:@"Remedios"];
        
        
        
        //=========== llenando Remedios Core Data ============  
        int remedioIndex=0;        
        for (NSDictionary *Recorrerjson in arrayRemedios){
            
            newData=[NSEntityDescription insertNewObjectForEntityForName:@"Remedios" inManagedObjectContext:managedObjectContext];
            
            [newData setValue:[[arrayRemedios objectAtIndex:remedioIndex] objectForKey:@"nombreRemedio"] forKey:@"nombreRemedio"];
            [newData setValue:[[arrayRemedios objectAtIndex:remedioIndex] objectForKey:@"preparacion"] forKey:@"preparacion"];    
            [newData setValue:[[arrayRemedios objectAtIndex:remedioIndex] objectForKey:@"ingredientes"] forKey:@"ingredientes"];  
            [newData setValue:[[arrayRemedios objectAtIndex:remedioIndex] objectForKey:@"subtitulo"] forKey:@"subtitulo"];
            [newData setValue:[[arrayRemedios objectAtIndex:remedioIndex] objectForKey:@"categoriaRemedio"] forKey:@"categoriaRemedio"];
            [newData setValue:[[arrayRemedios objectAtIndex:remedioIndex] objectForKey:@"imagenThumb"] forKey:@"imagenThumb"];
            remedioIndex++;   
        }
        
    
        
       //Revisar si  la entidad Glosario esta vacia o hay nuevos elementos por descargar 
        NSFetchRequest *glosarioRequest = [[NSFetchRequest alloc] init];
       //Edit entity name as appropiate.
        NSEntityDescription *entityGlosario = [NSEntityDescription entityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
        [glosarioRequest setEntity:entityGlosario];
        
        NSArray *glosarioArray = [managedObjectContext executeFetchRequest:glosarioRequest error:&error];
        if (glosarioArray == nil) {
            // Deal with error
        }
        
        else if (([glosarioArray count] <= 0) || (([arrayRemedios count] != numTotalGlosario)))
          {
            //==========Conexion Glosario
            NSString *urlStringGlosario = [NSString stringWithFormat:@"http://neostar.org/test/Remedios_JSON/Glosario.json"];         
            NSURL *urlGlosario = [NSURL URLWithString:urlStringGlosario];    
            NSString *dataGlosario = [NSString stringWithContentsOfURL:urlGlosario encoding:NSUTF8StringEncoding error:nil];    
            SBJsonParser *parserGlosario = [[SBJsonParser alloc] init];   
            NSMutableDictionary *myGlosario =[parserGlosario objectWithString:dataGlosario];    
            NSMutableArray *arrayGlosario=[myGlosario objectForKey:@"Glosario"];    
            
            
            //=========== llenando Glosario Core Data ============    
            int GlosarioIndex=0;    
            for (NSDictionary *RecorrerjsonGlosario in arrayGlosario)
              {
                
                
                
                newData=[NSEntityDescription insertNewObjectForEntityForName:@"Glosario" inManagedObjectContext:managedObjectContext];
                
                [newData setValue:[[arrayGlosario objectAtIndex:GlosarioIndex] objectForKey:@"detalleIngredientes"] forKey:@"detalleIngrediente"];
                [newData setValue:[[arrayGlosario objectAtIndex:GlosarioIndex] objectForKey:@"nombreIngrediente"] forKey:@"nombreIngrediente"];
                [newData setValue:[[arrayGlosario objectAtIndex:GlosarioIndex] objectForKey:@"imagenThumb"] forKey:@"imagenThumb"];        
                GlosarioIndex++;   
              }
        
            
                     
        
        
       
          }
        
        ///salvar contexto
        if (![managedObjectContext save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }

    }
    
    
}
@end
