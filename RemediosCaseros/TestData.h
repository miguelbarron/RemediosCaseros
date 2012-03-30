//
//  TestData.h
//  RemediosCaseros
//
//  Created by User on 3/21/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestData : NSObject
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSManagedObjectContext *addingManagedObjectContext;
-(void)createData;
@end
