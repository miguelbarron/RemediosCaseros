//
//  Remedio.m
//  RemediosCaseros
//
//  Created by Arturo Pruneda on 27/12/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import "Remedio.h"

@implementation Remedio

@synthesize remedio, imagen, instrucciones, ingredientes;

- (void) dealloc {
  [remedio release];
  [imagen release];
  [instrucciones release];
  [ingredientes release];
   
}

@end
