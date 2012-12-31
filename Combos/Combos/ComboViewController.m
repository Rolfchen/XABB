//
//  ComboViewController.m
//  Combos
//
//  Created by Rolf Chen on 18/03/12.
//  Copyright (c) 2012 Rolf Chen. All rights reserved.
//

#import "ComboViewController.h"
#import "ComboListViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ComboViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark Button Actions
-(IBAction)comboButtonClicked:(id)sender {
    ComboListViewController *comboList = [[ComboListViewController alloc] initWithNibName:@"ComboListViewController" bundle:nil];
    [self.navigationController pushViewController:comboList animated:YES];
}
-(IBAction)moveButtonClicked:(id)sender {}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    NSLog(@"Names %@", [UIFont fontNamesForFamilyName:@"Univers Condensed"]);
    [titleLabel setFont:[UIFont fontWithName:@"UniversCondensed" size:36]];
    titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    
    [comboButton.titleLabel setFont:[UIFont fontWithName:@"UniversCondensed" size:20]];
    [moveButton.titleLabel setFont:[UIFont fontWithName:@"UniversCondensed" size:20]];
    [banner setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BannerBg"]]];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
