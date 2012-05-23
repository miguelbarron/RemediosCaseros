//
//  Analytics.m
//  GoogleAnalyticsPie
//
//  Created by Alex Diaz on 22/05/2012.
//  Copyright (c) 2012 solu. All rights reserved.
//

#import "Analytics.h"
#import "GANTracker.h"

@implementation Analytics

-(void)track:(NSString *)ViewName{

    NSLog(@"Traking :%@",ViewName);
    NSError *error;
   
    
    if (![[GANTracker sharedTracker] trackPageview:ViewName withError:&error])
    {
        NSLog(@"error");
    }

}

-(void)trackEv:(NSInteger)value
{
    NSLog(@"traking Event");
    NSError *error;
    
    if (![[GANTracker sharedTracker] trackEvent:@"TrackEvent" action:@"Evento" label:@"Evento" value:value withError:&error])
    {
        NSLog(@"error");
    }
    
}

@end
