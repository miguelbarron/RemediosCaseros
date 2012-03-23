//
//  Imagen.h
//  RemediosCaseros
//
//  Created by User on 3/23/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Glosario, Remedios;

@interface Imagen : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Remedios *imagenRemedio;
@property (nonatomic, retain) Glosario *imagenGlosario;

@end
