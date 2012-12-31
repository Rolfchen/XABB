//
//  WebViewController.m
//  Combos
//
//  Created by Rolf Chen on 9/12/12.
//  Copyright (c) 2012 Australian Tourism Data Warehouse. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize urlString = _urlString;
@synthesize titleString = _titleString;

-(id)initWithHTML:(NSString *)htmlString {
    self = [super initWithNibName:@"WebViewController" bundle:nil];
    if (self) {
        self.urlString = htmlString;
    }
    return self;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    titleLabel.text = self.titleString;
    [banner setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BannerBg"]]];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:self.urlString ofType:@"html"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSLog(@"URL String: %@ URL: %@", filePath, fileURL);
    [webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
    
    //HACK OUT THE SHADOW
    for (UIView *subview in [webView.scrollView subviews]) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            subview.hidden = YES;
        }
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
