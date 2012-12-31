//
//  GalleryScroll.m
//  Combos
//
//  Created by Rolf Chen on 24/03/12.
//  Copyright 2012 Created by Rolf Chen on 24/03/12.. All rights reserved.
//

#import "GalleryScrollViewController.h"


@implementation GalleryScrollViewController

#pragma mark -
#pragma mark Helper methods
-(void)displayCaption {
	if ([[visiblePages allObjects] count] == 1) {
		ImageScrollView *image = [[visiblePages allObjects] objectAtIndex:0];
		caption.text = image.caption;
	}
}

#pragma mark -
#pragma mark Public methods
-(void)showPage:(int)page {
	//create frame for the parsed page
	CGRect imgFrame = pagingScrollView.frame;
	imgFrame.origin.x = imgFrame.size.width * page;
	imgFrame.origin.y = 0;
	
	//tell scrollview to update
	[pagingScrollView scrollRectToVisible:imgFrame animated:NO];
	
	//get displayed image caption
	[self displayCaption];
}

#pragma mark -
#pragma mark Image wrangling

//Name Array should contain the image name and description. 
-(void)loadImages:(NSArray *)movesArray {
    
    for (NSDictionary *move in movesArray) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@Image.jpg", [move objectForKey:@"type"]]];
        if (img != nil) {
            [galleryImageObjects addObject:img];
            [galleryImageNames addObject:[move objectForKey:@"name"]];
        }
    }
    
    /* //OLD
	//iterate parsed string array of image names
	for (int i=0; i<[nameArray count]; i++) {
		
		//see if item is an image
		UIImage *img = [UIImage imageWithContentsOfFile:
						[NSString stringWithFormat:@"%@/%@", directoryString, [nameArray objectAtIndex:i]]];
		
		if (img != nil) {
			//file is image
			[galleryImageObjects addObject:img];
			[galleryImageNames addObject:[nameArray objectAtIndex:i]];
		}
	}
     */
}

#pragma mark -
#pragma mark Frame calculations
#define PADDING 10
-(CGRect)frameForPagingScrollView {
    CGRect frame = [self.view bounds]; 
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    return frame;
}
-(CGRect)frameForPageAtIndex:(NSUInteger)index {
    // We have to use our paging scroll view's bounds, not frame, to calculate the page placement. When the device is in
    // landscape orientation, the frame will still be in portrait because the pagingScrollView is the root view controller's
    // view, so its frame is in window coordinate space, which is never rotated. Its bounds, however, will be in landscape
    // because it has a rotation transform applied.
    CGRect bounds = pagingScrollView.bounds;
    CGRect pageFrame = bounds;
    pageFrame.size.width -= (2 * PADDING);
    pageFrame.origin.x = (bounds.size.width * index) + PADDING;
    return pageFrame;
}
-(CGSize)contentSizeForPagingScrollView {
    // We have to use the paging scroll view's bounds to calculate the contentSize, for the same reason outlined above.
    CGRect bounds = pagingScrollView.bounds;
    return CGSizeMake(bounds.size.width * [galleryImageObjects count], bounds.size.height);
}

#pragma mark -
#pragma mark Tiling and page config
-(ImageScrollView *)dequeueRecycledPage {
    ImageScrollView *page = [recycledPages anyObject];
    if (page) {
        [recycledPages removeObject:page];
    }
    return page;
}
-(BOOL)isDisplayingPageForIndex:(NSUInteger)index {
    BOOL foundPage = NO;
    for (ImageScrollView *page in visiblePages) {
        if (page.index == index) {
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}
-(void)configurePage:(ImageScrollView *)page forIndex:(NSUInteger)index {
    page.index = index;
    page.frame = [self frameForPageAtIndex:index];
    
    // Use tiled images
    /*
	[page displayTiledImageNamed:[galleryImageNames objectAtIndex:index]
                            size:((UIImage *)[galleryImageObjects objectAtIndex:index]).size];
    */
    // To use full images instead of tiled images, replace the "displayTiledImageNamed:" call
    // above by the following line:
    [page displayImage:[galleryImageObjects objectAtIndex:index]];
	//get filename
	NSString *fileName = [galleryImageNames objectAtIndex:index];
	//remove extension and set as caption
	page.caption = [fileName stringByDeletingPathExtension];
}
-(void)tilePages {
    // Calculate which pages are visible
    CGRect visibleBounds = pagingScrollView.bounds;
    int firstNeededPageIndex = floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
    int lastNeededPageIndex  = floorf((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds));
    firstNeededPageIndex = MAX(firstNeededPageIndex, 0);
    lastNeededPageIndex  = MIN(lastNeededPageIndex, [galleryImageObjects count] - 1);
    
    // Recycle no-longer-visible pages 
    for (ImageScrollView *page in visiblePages) {
        if (page.index < firstNeededPageIndex || page.index > lastNeededPageIndex) {
            [recycledPages addObject:page];
            [page removeFromSuperview];
        }
    }
    [visiblePages minusSet:recycledPages];
    
    // add missing pages
    for (int index = firstNeededPageIndex; index <= lastNeededPageIndex; index++) {
        if (![self isDisplayingPageForIndex:index]) {
            ImageScrollView *page = [self dequeueRecycledPage];
            if (page == nil) {
                page = [[ImageScrollView alloc] init];
            }
            [self configurePage:page forIndex:index];
            [pagingScrollView addSubview:page];
            [visiblePages addObject:page];
        }
    }    
}

#pragma mark -
#pragma mark ScrollView delegate methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self tilePages];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	//get displayed image caption
	[self displayCaption];
}

#pragma mark -
#pragma mark View controller rotation methods
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    // here, our pagingScrollView bounds have not yet been updated for the new interface orientation. So this is a good
    // place to calculate the content offset that we will need in the new orientation
    CGFloat offset = pagingScrollView.contentOffset.x;
    CGFloat pageWidth = pagingScrollView.bounds.size.width;
    
    if (offset >= 0) {
        firstVisiblePageIndexBeforeRotation = floorf(offset / pageWidth);
        percentScrolledIntoFirstVisiblePage = (offset - (firstVisiblePageIndexBeforeRotation * pageWidth)) / pageWidth;
    } else {
        firstVisiblePageIndexBeforeRotation = 0;
        percentScrolledIntoFirstVisiblePage = offset / pageWidth;
    }    
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    // recalculate contentSize based on current orientation
    pagingScrollView.contentSize = [self contentSizeForPagingScrollView];
    
    // adjust frames and configuration of each visible page
    for (ImageScrollView *page in visiblePages) {
        CGPoint restorePoint = [page pointToCenterAfterRotation];
        CGFloat restoreScale = [page scaleToRestoreAfterRotation];
        page.frame = [self frameForPageAtIndex:page.index];
        [page setMaxMinZoomScalesForCurrentBounds];
        [page restoreCenterPoint:restorePoint scale:restoreScale];
    }
    
    // adjust contentOffset to preserve page location based on values collected prior to location
    CGFloat pageWidth = pagingScrollView.bounds.size.width;
    CGFloat newOffset = (firstVisiblePageIndexBeforeRotation * pageWidth) + (percentScrolledIntoFirstVisiblePage * pageWidth);
    pagingScrollView.contentOffset = CGPointMake(newOffset, 0);
}

#pragma mark -
#pragma mark Lifecycle methods
-(id)initViewWithNameArray:(NSArray *)array andDirectory:(NSString *)directory {
	if (self = [super initWithNibName:@"GalleryScroll" bundle:nil]) {
		galleryImageNames = [[NSMutableArray alloc] init];
		galleryImageObjects = [[NSMutableArray alloc] init];
		directoryString = directory;
		[self loadImages:array];
	}
	return self;
}

-(id)initViewWithMovesArray:(NSArray *)array atIndex:(NSInteger)pageIndex {
    if (self = [super initWithNibName:@"GalleryScroll" bundle:nil]) {
		galleryImageNames = [[NSMutableArray alloc] init];
		galleryImageObjects = [[NSMutableArray alloc] init];
        currentIndex = pageIndex;
		[self loadImages:array];
	}
	return self;
}

-(void)viewDidLoad {
	//setup outer paging scroll view
    CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
    pagingScrollView.frame = pagingScrollViewFrame;
	pagingScrollView.contentSize = [self contentSizeForPagingScrollView];
    
    CGRect frame = [self frameForPageAtIndex:currentIndex];
    [pagingScrollView scrollRectToVisible:frame animated:NO];
	
    
	//prepare to tile content
	recycledPages = [[NSMutableSet alloc] init];
	visiblePages  = [[NSMutableSet alloc] init];
	[self tilePages];
	
	[super viewDidLoad];
}
@end
