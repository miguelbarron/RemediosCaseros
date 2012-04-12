//
//  FacebookMethods.m
//  Periodico
//
//  Created by Alejandro Diaz on 2/24/12.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "FacebookMethods.h"

FacebookMethods *sharedFacebook_;

@implementation FacebookMethods;
@synthesize facebook = facebook_;


+ (FacebookMethods *)sharedInstance {
    if (!sharedFacebook_ ) {
        sharedFacebook_ = [[FacebookMethods alloc]init];
    }
    return sharedFacebook_;
}

-(void)fbSetId
{
 facebook_ = [[Facebook alloc]initWithAppId:@"123176197710962" andDelegate:self];

}

#pragma mark Facebook Methods

-(void)logIn
{
    
    if (![facebook_ isSessionValid]) {
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"user_likes", 
                                @"read_stream",
                                nil];
        [facebook_ authorize:permissions];
        [permissions release];    
    }
}



-(void)newFeed:(NSMutableDictionary *)Dic
{
    
    //NSLog(@"FBDiccionario %@",[Dic description]);
    
    NSMutableDictionary *Cont = [[NSMutableDictionary alloc]init];
    
    NSString *descripcion = [Dic objectForKey:@"description"];
    NSString *desc;
    if ([descripcion length]>100) {
        desc =[NSString stringWithFormat:@"%@ ...", [descripcion substringToIndex:100]];
    }
    else
    {
        desc = descripcion;
    }
    
    
    [Cont setObject: desc forKey:@"description"];   
    [Cont setObject:[Dic objectForKey:@"link"] forKey:@"link"];
    [Cont setObject:[Dic objectForKey:@"picture"] forKey:@"picture"];
    [Cont setObject:[Dic objectForKey:@"title"] forKey:@"name"];
    [Cont setObject:[Dic objectForKey:@"message"] forKey:@"message"];
    //[Cont setObject: @"http://miRestaurante.com" forKey: @"href"];
    [Cont setObject:@"" forKey:@"caption"];
    
    
    
    
    
    
    
    flag =YES;
    
    [facebook_ dialog:@"feed"
            andParams:Cont
          andDelegate:self];
    
    //    [facebook_ dialog:@"stream.publish" andParams:Cont andDelegate:self];
    
    [Cont release];
}

-(BOOL)logged{
    if (flag) {
        return YES;
       
    }
    else{
        return NO;
        
    }
}

-(void)logOut
{
    flag = NO;
    [facebook_ logout];
    [self fbDidLogout];

}

- (void) fbDidLogout {
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
}

// Pre 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [facebook_ handleOpenURL:url]; 
}

// For 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [facebook_ handleOpenURL:url]; 
}

- (void)fbDidLogin {


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook_ accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook_ expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    flag =YES;     
}

@end
