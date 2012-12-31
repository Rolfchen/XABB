//
//  ViewController.h
//  Combos
//
//  Created by Rolf Chen on 18/03/12.
//  Copyright (c) 2012 Created by Rolf Chen on 24/03/12.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ComboViewController : BaseViewController {
    UINavigationController *navController;
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *comboButton;
    IBOutlet UIButton *moveButton;
}

-(IBAction)comboButtonClicked:(id)sender;
-(IBAction)moveButtonClicked:(id)sender;
@end
