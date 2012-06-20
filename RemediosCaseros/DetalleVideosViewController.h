//
//  DetalleVideosViewController.h
//  RemediosCaseros
//
//  Created by Alex Diaz on 14/06/2012.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseXML.h"
@interface DetalleVideosViewController : UITableViewController
{
    ParseXML *PX;
    
    NSMutableArray * arrImagenes;
}

@property (nonatomic,retain)NSString *url;
@property (nonatomic,retain)NSString *paquete;
@end
