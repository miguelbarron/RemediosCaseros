//
//  FacebookMethods.h
//  Periodico
//
//  Created by Alejandro Diaz on 2/24/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"

@interface FacebookMethods : NSObject<FBSessionDelegate, FBRequestDelegate, FBDialogDelegate>
{
    Facebook *facebook_;
    BOOL flag;
 
}

@property (nonatomic,retain)Facebook *facebook;


+ (FacebookMethods *)sharedInstance;
-(void)fbSetId;
-(void)logIn;
-(void)newFeed:(NSMutableDictionary *)Dic;
-(void)logOut;
-(BOOL)logged;



@end
