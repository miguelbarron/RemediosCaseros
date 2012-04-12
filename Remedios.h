//
//  Remedios.h
//  RemediosCaseros
//
//  Created by User on 4/12/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Remedios : NSManagedObject

@property (nonatomic, retain) NSString * categoriaRemedio;
@property (nonatomic, retain) NSString * imagenThumb;
@property (nonatomic, retain) NSString * ingredientes;
@property (nonatomic, retain) NSString * nombreRemedio;
@property (nonatomic, retain) NSString * preparacion;
@property (nonatomic, retain) NSString * subtitulo;

@end
