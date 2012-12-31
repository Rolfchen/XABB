//
//  BaseViewController.h
//  Combos
//
//  Created by Rolf Chen on 24/03/12.
//  Copyright (c) 2012 Australian Tourism Data Warehouse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController {
    IBOutlet UIButton *backButton;
    IBOutlet UIView *banner;
    
}

-(IBAction)backButtonClicked:(id)sender;
@end
