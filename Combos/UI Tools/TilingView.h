//
//  TilingView.h
//  Combos
//
//  Created by Rolf Chen on 24/03/12.
//  Copyright 2012 Created by Rolf Chen on 24/03/12.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TilingView : UIView {
    NSString *imageName;
    BOOL annotates;
}
-(id)initWithImageName:(NSString *)name size:(CGSize)size;
@end
