//
//  Imagen.h
//  RemediosCaseros
//
//  Created by User on 3/24/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Glosario, Remedios;

@interface Imagen : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * imagenVista;
@property (nonatomic, retain) NSString * imagenThumb;
@property (nonatomic, retain) Glosario *imagenGlosario;
@property (nonatomic, retain) Remedios *imagenRemedio;

@end
