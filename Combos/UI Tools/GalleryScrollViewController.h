//
//  GalleryScrollViewController.h
//  Combos
//
//  Created by Rolf Chen on 24/03/12.
//  Copyright 2012 Created by Rolf Chen on 24/03/12.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"
#import "BaseViewController.h"

@interface GalleryScrollViewController : BaseViewController <UIScrollViewDelegate> {
	IBOutlet UIScrollView *pagingScrollView;
	IBOutlet UILabel *caption;
	
	NSMutableArray *galleryImageNames;
	NSMutableArray *galleryImageObjects;
	NSString *directoryString;
	
	NSMutableSet *recycledPages;
    NSMutableSet *visiblePages;
	
	// these values are stored off before we start rotation so we adjust our content offset appropriately during rotation
    int firstVisiblePageIndexBeforeRotation;
    CGFloat percentScrolledIntoFirstVisiblePage;
    
    NSInteger currentIndex;
}
-(id)initViewWithNameArray:(NSArray *)array andDirectory:(NSString *)directory;
-(id)initViewWithMovesArray:(NSArray *)array atIndex:(NSInteger)pageIndex;
-(void)showPage:(int)page;
@end