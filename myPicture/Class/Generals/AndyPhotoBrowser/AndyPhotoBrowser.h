//
//  AndyPhotoBrowser.h
//  myPicture
//
//  Created by andy on 16/4/29.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AndyButton, AndyPhotoBrowser;

@protocol AndyPhotoBrowserDelegate <NSObject>

@optional

- (UIImage *)photoBrowser:(AndyPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;

- (NSURL *)photoBrowser:(AndyPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;

@end

@interface AndyPhotoBrowser : UIView <UIScrollViewDelegate>

@property (nonatomic, weak)     UIView      *sourceImagesContainerView;
@property (nonatomic, assign)   NSInteger   currentImageIndex;          //点击的图片index
@property (nonatomic, assign)   NSInteger   imageCount;                 //图片的数量
@property (nonatomic, copy)     void (^dismissCallBack)();
@property (nonatomic, assign)   id<AndyPhotoBrowserDelegate> delegate;

- (void)show;

@end
