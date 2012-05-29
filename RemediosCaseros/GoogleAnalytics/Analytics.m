//
//  Analytics.m
//  GoogleAnalyticsPie
//
//  Created by Alex Diaz on 22/05/2012.
//  Copyright (c) 2012 solu. All rights reserved.
//

#import "Analytics.h"
#import "GANTracker.h"


Analytics *sharedAnalytics_;


@implementation Analytics



+ (Analytics *)sharedInstance {
    if (!sharedAnalytics_ ) {
        sharedAnalytics_ = [[Analytics alloc] init];
        
    }
    return sharedAnalytics_;
}
-(void)track:(NSString *)ViewName{

    NSError *error;
   
    
    if (![[GANTracker sharedTracker] trackPageview:ViewName withError:&error])
    {
        NSLog(@"error");
    }

}

-(void)trackEv:(NSInteger)value
{

    NSError *error;
    
    if (![[GANTracker sharedTracker] trackEvent:@"TrackEvent" action:@"Evento" label:@"Evento" value:value withError:&error])
    {
        NSLog(@"error");
    }
    
}

@end
