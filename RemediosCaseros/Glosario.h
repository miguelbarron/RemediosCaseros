//
//  Glosario.h
//  RemediosCaseros
//
//  Created by User on 3/28/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Imagen;

@interface Glosario : NSManagedObject

@property (nonatomic, retain) NSString * detalleIngrediente;
@property (nonatomic, retain) NSString * nombreIngrediente;
@property (nonatomic, retain) NSNumber * comprarIngrediente;
@property (nonatomic, retain) Imagen *imagen;

@end
