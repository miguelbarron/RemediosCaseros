//
//  Categoria.h
//  RemediosCaseros
//
//  Created by User on 3/20/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Categoria : NSManagedObject

@property (nonatomic, retain) NSString * titulo;
@property (nonatomic, retain) NSSet *remedio;
@end

@interface Categoria (CoreDataGeneratedAccessors)

- (void)addRemedioObject:(NSManagedObject *)value;
- (void)removeRemedioObject:(NSManagedObject *)value;
- (void)addRemedio:(NSSet *)values;
- (void)removeRemedio:(NSSet *)values;

@end
