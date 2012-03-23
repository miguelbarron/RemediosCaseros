//
//  Remedios.h
//  RemediosCaseros
//
//  Created by User on 3/23/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categoria, Imagen;

@interface Remedios : NSManagedObject

@property (nonatomic, retain) NSString * ingredientes;
@property (nonatomic, retain) NSString * nombreRemedio;
@property (nonatomic, retain) NSString * preparacion;
@property (nonatomic, retain) NSString * subtitulo;
@property (nonatomic, retain) Categoria *categoria;
@property (nonatomic, retain) Imagen *imagen;

@end
