//
//  AndyBrowserImageView.h
//  myPicture
//
//  Author Andyjicw 479003573@qq.com
//
//  Created by andy on 16/4/29.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AndyWaitingView.h"


@interface AndyBrowserImageView : UIImageView <UIGestureRecognizerDelegate>

@property (nonatomic, assign)           CGFloat progress;
@property (nonatomic, assign, readonly) BOOL    isScaled;
@property (nonatomic, assign)           BOOL    hasLoadedImage;
// 清除缩放
- (void)eliminateScale;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

- (void)doubleTapToZommWithScale:(CGFloat)scale;

- (void)clear;

@end
