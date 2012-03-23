//
//  Glosario.h
//  RemediosCaseros
//
//  Created by User on 3/23/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Imagen;

@interface Glosario : NSManagedObject

@property (nonatomic, retain) NSString * detalleIngrediente;
@property (nonatomic, retain) NSString * nombreIngrediente;
@property (nonatomic, retain) NSSet *imagen;
@end

@interface Glosario (CoreDataGeneratedAccessors)

- (void)addImagenObject:(Imagen *)value;
- (void)removeImagenObject:(Imagen *)value;
- (void)addImagen:(NSSet *)values;
- (void)removeImagen:(NSSet *)values;

@end
