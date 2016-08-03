//
//  AndyBrowserImageView.h
//  myPicture
//
//  Created by andy on 16/4/29.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AndyWaitingView.h"


@interface AndyBrowserImageView : UIImageView <UIGestureRecognizerDelegate>

@property (nonatomic, assign)           CGFloat     progress;
@property (nonatomic, assign, readonly) BOOL        isScaled;
@property (nonatomic, assign)           BOOL        hasLoadedImage;

- (void)eliminateScale;//清除缩放

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

- (void)doubleTapToZommWithScale:(CGFloat)scale;

- (void)clear;

@end
