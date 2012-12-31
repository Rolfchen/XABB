//
//  VideoViewController.m
//  Combos
//
//  Created by Rolf Chen on 7/10/12.
//  Copyright (c) 2012 Australian Tourism Data Warehouse. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *videoURLString = [[NSBundle mainBundle] pathForResource:@"combo-1" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath:videoURLString];
    
    //Test Video Player
    player = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    [player prepareToPlay];
    [self.view addSubview:[player view]];
    
    [self.view bringSubviewToFront:backButton];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self repositionVideo];
}

-(void)repositionVideo {
    
    [[player view] setFrame:self.view.bounds];
    NSLog(@"Self.view %f, %f", self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self repositionVideo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button Action
-(IBAction)backButtonClicked:(id)sender {
    [super backButtonClicked:sender];
    [player stop];
}

@end
