//
//  ImageScrollView.h
//  Combos
//
//  Created by Rolf Chen on 24/03/12.
//  Copyright 2012 Created by Rolf Chen on 24/03/12.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TilingView.h"

@interface ImageScrollView : UIScrollView <UIScrollViewDelegate> {
	UIView *imageView;
	NSString *caption;
	NSUInteger index;
}
@property (assign) NSUInteger index;
@property (nonatomic, strong) NSString *caption;

-(void)displayImage:(UIImage *)image;
-(void)displayTiledImageNamed:(NSString *)imageName size:(CGSize)imageSize;
-(void)setMaxMinZoomScalesForCurrentBounds;
-(CGPoint)pointToCenterAfterRotation;
-(CGFloat)scaleToRestoreAfterRotation;
-(void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale;
@end
