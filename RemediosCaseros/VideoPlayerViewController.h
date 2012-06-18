//
//  VideoPlayerViewController.h
//  RemediosCaseros
//
//  Created by Alex Diaz on 18/06/2012.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayerViewController : UIViewController
{

    IBOutlet UILabel *nombre_;
}
@property(nonatomic,retain) NSString *url;
@property(nonatomic,retain) NSString *nombre;

@end
