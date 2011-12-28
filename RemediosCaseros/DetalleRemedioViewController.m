//
//  DetalleRemedioViewController.m
//  RemediosCaseros
//
//  Created by Arturo Pruneda on 27/12/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import "DetalleRemedioViewController.h"

@implementation DetalleRemedioViewController
@synthesize miRemedio;
@synthesize labelRemedio;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 NSLog(@"DetalleRemedio elemento: %@", [self.miRemedio.remedio description]);
  labelRemedio.text = self.miRemedio.remedio;
}

- (void)viewDidUnload
{
  [self setLabelRemedio:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
  [labelRemedio release];
  [super dealloc];
}
@end
