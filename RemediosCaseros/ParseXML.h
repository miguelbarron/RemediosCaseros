//
//  ParseXML.h
//  RemediosCaseros
//
//  Created by Alex Diaz on 12/06/2012.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ParseXML : NSObject
{

}

@property (nonatomic,retain)NSMutableArray *videos;

-(void)grabRSSVideos:(NSString*)urlPlaylist;


+(ParseXML *)sharedInstance;

@end
