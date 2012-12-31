//
//  WebViewController.h
//  Combos
//
//  Created by Rolf Chen on 9/12/12.
//  Copyright (c) 2012 Australian Tourism Data Warehouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WebViewController : BaseViewController {
    IBOutlet UIWebView *webView;
    IBOutlet UILabel *titleLabel;
    
}

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *titleString;
-(id)initWithHTML:(NSString *)htmlString;

@end
