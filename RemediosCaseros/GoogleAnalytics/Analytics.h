//
//  Analytics.h
//  GoogleAnalyticsPie
//
//  Created by Alex Diaz on 22/05/2012.
//  Copyright (c) 2012 solu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Analytics : NSObject


-(void)track:(NSString *)ViewName;
-(void)trackEv:(NSInteger)value;

+ (Analytics *)sharedInstance ;
@end
