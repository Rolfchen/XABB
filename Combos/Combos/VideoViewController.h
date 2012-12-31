//
//  VideoViewController.h
//  Combos
//
//  Created by Rolf Chen on 7/10/12.
//  Copyright (c) 2012 Australian Tourism Data Warehouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "BaseViewController.h"

#define kVideoURL @"video"
#define kVideoDescription @"description"

@interface VideoViewController : BaseViewController {
    MPMoviePlayerController *player;
    IBOutlet UIView *videoFrame;
    IBOutlet UITextField *textField;
}

@property (nonatomic, strong) NSDictionary *videoData;



@end
