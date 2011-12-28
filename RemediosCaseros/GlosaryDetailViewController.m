//
//  GlosaryDetailViewController.m
//  RemediosCaseros
//
//  Created by developer on 12/26/11.
//  Copyright (c) 2011 Somos Software. All rights reserved.
//

#import "GlosaryDetailViewController.h"

@implementation GlosaryDetailViewController
@synthesize glosaryImageView;
@synthesize glosaryLabel;

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
}

- (void)viewDidUnload
{
    [self setGlosaryImageView:nil];
    [self setGlosaryLabel:nil];
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
    [glosaryImageView release];
    [glosaryLabel release];
    [super dealloc];
}
@end
