//
//  ComboDetailViewController.h
//  Combos
//
//  Created by Rolf Chen on 24/03/12.
//  Copyright (c) 2012 Australian Tourism Data Warehouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "BaseViewController.h"

@interface ComboDetailViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *comboBreakDownTable;
    IBOutlet UIButton *videoButton;
    IBOutlet UIButton *closeButton;
    IBOutlet UITextView *videoCaption;
    
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UITextView *detailText;
    IBOutlet UILabel *comboTitleLabel;
    IBOutlet UIScrollView *contentScrollView;
    
    NSDictionary *comboDetail;
    
    
}

@property (nonatomic, strong) MPMoviePlayerController *player;

-(id)initWithComboDetail:(NSDictionary *)comboSource;
-(IBAction)playVideo:(id)sender;
-(IBAction)closeVideo:(id)sender;

@end
