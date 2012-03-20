//
//  Remedios.h
//  RemediosCaseros
//
//  Created by User on 3/20/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Remedios : NSManagedObject

@property (nonatomic, retain) NSString * nombreRemedio;
@property (nonatomic, retain) NSString * ingredientes;
@property (nonatomic, retain) NSString * preparacion;

@end
