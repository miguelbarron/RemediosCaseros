//
//  ParseXML.m
//  RemediosCaseros
//
//  Created by Alex Diaz on 12/06/2012.
//  Copyright (c) 2012 Somos Software. All rights reserved.
//

#import "ParseXML.h"
#import "TBXML.h"


ParseXML *sharedParser_;

@implementation ParseXML

@synthesize videos = _videos;

+(ParseXML *)sharedInstance{
    if (!sharedParser_ ) {
        sharedParser_ = [[ParseXML alloc] init];
    }
    return sharedParser_;
}

-(void)grabRSSVideos:(NSString*)urlPlaylist{
    
    NSURL *good_url = [[NSURL alloc] initWithString:urlPlaylist];
    
    NSString *string5 = [NSString stringWithContentsOfURL:good_url encoding:NSUTF8StringEncoding error:nil];
  //  NSString *string5 = [[NSString alloc] initWithContentsOfURL:good_url];
    
   // NSLog(@"Resultado %@", string5);
    NSMutableDictionary *item = [[[NSMutableDictionary alloc]init]autorelease];
     self.videos = [[[NSMutableArray alloc]init] autorelease];
    
    NSError *error;
    TBXML *xml = [TBXML newTBXMLWithXMLString:string5 error:&error];
    
    if (error) {
        NSLog(@"%@ %@", [error localizedDescription], [error userInfo]);
    } 
    
    TBXMLElement * rootXMLElement = xml.rootXMLElement;
    TBXMLElement * entry =[TBXML childElementNamed:@"entry" parentElement:rootXMLElement];
    
    do {
        BOOL band = FALSE;
        TBXMLElement * link =[TBXML childElementNamed:@"link" parentElement:entry];
        TBXMLElement * title =[TBXML childElementNamed:@"title" parentElement:entry];


        NSString *check = [TBXML valueOfAttributeNamed:@"rel" forElement:link];

        NSString *videoTitle = [TBXML textForElement:title];

         [item setObject:videoTitle forKey:@"Name"];
        
        
        
        do {
                     
            check = [TBXML valueOfAttributeNamed:@"rel" forElement:link];


            //NSLog(@"checklink %@",check);
            
            if ([check isEqualToString:@"alternate"]) {
                NSString *name = [TBXML valueOfAttributeNamed:@"href" forElement:link];
            //    NSLog(@"LIGA Video %@", name);
                
                [item setObject:name forKey:@"url"];
                band = TRUE;
            }
            else {
                link = link->nextSibling;
            }

        } while (band==FALSE);
                
        
        TBXMLElement * media =[TBXML childElementNamed:@"media:group" parentElement:entry];
//        NSLog(@"Media %@", [TBXML elementName:media]);
        
        TBXMLElement * mediaThumb =[TBXML childElementNamed:@"media:thumbnail" parentElement:media];
//        NSLog(@"MediaThum %@", [TBXML elementName:mediaThumb]);
        
        NSString *ligaThumb = [TBXML valueOfAttributeNamed:@"url" forElement:mediaThumb];
        
        //NSLog(@"LIGA Thumb %@", ligaThumb);
        
        [item setObject:ligaThumb forKey:@"thumb"];
        
        [self.videos addObject:[item copy]];
        
       
    } while ((entry = entry->nextSibling));
    
     NSLog(@"live  %@",[self.videos description]);
}


@end
