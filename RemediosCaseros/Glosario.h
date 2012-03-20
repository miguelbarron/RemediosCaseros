//
//  Glosario.h
//  RemediosCaseros
//
//  Created by User on 3/20/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Glosario : NSManagedObject

@property (nonatomic, retain) NSString * nombreIngrediente;
@property (nonatomic, retain) NSString * detalleIngrediente;

@end
