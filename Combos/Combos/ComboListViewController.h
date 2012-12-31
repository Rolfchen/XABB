//
//  ComboListViewController.h
//  Combos
//
//  Created by Rolf Chen on 24/03/12.
//  Copyright (c) 2012 Created by Rolf Chen on 24/03/12.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ComboListViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *comboTable;
    NSArray *tableSource;
    IBOutlet UILabel *titleLabel;
}
@end
