//
//  YoutubeViewController.m
//  Combos
//
//  Created by Rolf Chen on 24/03/12.
//  Copyright (c) 2012 Australian Tourism Data Warehouse. All rights reserved.
//

#import "YoutubeViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation YoutubeViewController

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
    [titleLabel setFont:[UIFont fontWithName:@"UniversCondensed" size:36]];
    titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    
    [banner setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BannerBg"]]];
    
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated {
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.youtube.com/dundeekim1"]]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
