//
//  Glosario.h
//  RemediosCaseros
//
//  Created by User on 4/9/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Glosario : NSManagedObject

@property (nonatomic, retain) NSNumber * comprarIngrediente;
@property (nonatomic, retain) NSString * detalleIngrediente;
@property (nonatomic, retain) NSString * imagenThumb;
@property (nonatomic, retain) NSString * imagenVista;
@property (nonatomic, retain) NSString * nombreIngrediente;
@property (nonatomic, retain) NSNumber * seleccionCompra;

@end
