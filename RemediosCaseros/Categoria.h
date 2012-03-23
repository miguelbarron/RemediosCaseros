//
//  Categoria.h
//  RemediosCaseros
//
//  Created by User on 3/23/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Remedios;

@interface Categoria : NSManagedObject

@property (nonatomic, retain) NSString * titulo;
@property (nonatomic, retain) NSSet *remedio;
@end

@interface Categoria (CoreDataGeneratedAccessors)

- (void)addRemedioObject:(Remedios *)value;
- (void)removeRemedioObject:(Remedios *)value;
- (void)addRemedio:(NSSet *)values;
- (void)removeRemedio:(NSSet *)values;

@end
