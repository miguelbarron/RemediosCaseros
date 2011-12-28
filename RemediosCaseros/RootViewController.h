//
//  RootViewController.h
//  RemediosCaseros
//
//  Created by Arturo Pruneda on 26/12/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Remedio.h"

@interface RootViewController : UITableViewController{
    NSArray *arrayConDOEnGrupos;
}
@property (nonatomic, retain) NSArray *arrayConDOEnGrupos;
@property (nonatomic, retain) Remedio *miRemedio;

@end
