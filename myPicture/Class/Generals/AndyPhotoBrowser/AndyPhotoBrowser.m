//
//  AndyPhotoBrowser.m
//  myPicture
//
//  Author Andyjicw 479003573@qq.com
//
//  Created by andy on 16/4/29.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "AndyPhotoBrowser.h"
#import <UIImageView+WebCache.h>
#import "AndyBrowserImageView.h"
#import "AndyPhotoBrowserConfig.h"
#import "WXApiObject.h"
#import "WXApi.h"

@implementation AndyPhotoBrowser {
    UIScrollView            *_scrollView;
    BOOL                    _hasShowedFistView;
    UILabel                 *_indexLabel;
    UIButton                *_saveButton;
    UIButton                *_shareButton;
    UIActivityIndicatorView *_indicatorView;
    BOOL                    _willDisappear;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = AndyPhotoBrowserBackgrounColor;
    }
    return self;
}

- (void)dealloc {
    [[UIApplication sharedApplication].keyWindow removeObserver:self forKeyPath:@"frame"];
    _scrollView = nil;
    _indexLabel = nil;
    _saveButton = nil;
    _shareButton = nil;
    _indicatorView = nil;
}

- (void)setupToolbars {
    // 1. 序标
    UILabel *indexLabel = [[UILabel alloc] init];
    indexLabel.bounds = CGRectMake(0, 0, 80, 30);
    indexLabel.textAlignment = NSTextAlignmentCenter;
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.font = [UIFont boldSystemFontOfSize:20];
    indexLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    indexLabel.layer.cornerRadius = indexLabel.bounds.size.height * 0.5;
    indexLabel.clipsToBounds = YES;
    if (self.imageCount > 1) {
        indexLabel.text = [NSString stringWithFormat:@"1/%ld", (long)self.imageCount];
    }
    _indexLabel = indexLabel;
    [self addSubview:indexLabel];
    
    // 2.保存按钮
    UIButton *saveButton = [[UIButton alloc] init];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    saveButton.layer.cornerRadius = 5;
    saveButton.clipsToBounds = YES;
    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    _saveButton = saveButton;
    [self addSubview:saveButton];
    
    // 3.分享按钮
    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shareButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    shareButton.layer.cornerRadius = 5;
    shareButton.clipsToBounds = YES;
    [shareButton addTarget:self action:@selector(shareURL) forControlEvents:UIControlEventTouchUpInside];
    _shareButton = shareButton;
    [self addSubview:shareButton];
}
- (void)shareURL {
    int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    UIImageView *currentImageView = _scrollView.subviews[index];
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImagePNGRepresentation(currentImageView.image);
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"1";
    message.description = @"1";
    message.mediaObject = ext;
    message.messageExt = @"1";
    message.messageAction = @"1";
    message.mediaTagName = @"1";
    [message setThumbImage:currentImageView.image];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
    
}
- (void)saveImage {
    int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    UIImageView *currentImageView = _scrollView.subviews[index];
    UIImageWriteToSavedPhotosAlbum(currentImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 150, 30);
    label.center = self.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    if (error) {
        label.text = AndyPhotoBrowserSaveImageFailText;
    } else {
        label.text = AndyPhotoBrowserSaveImageSuccessText;
    }
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

- (void)setupScrollView {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    for (int i = 0; i < self.imageCount; i++) {
        AndyBrowserImageView *imageView = [[AndyBrowserImageView alloc] init];
        imageView.tag = i;
        // 单击图片
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(photoClick:)];
        // 双击放大图片
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(imageViewDoubleTaped:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [imageView addGestureRecognizer:singleTap];
        [imageView addGestureRecognizer:doubleTap];
        [_scrollView addSubview:imageView];
    }
    [self setupImageOfImageViewForIndex:self.currentImageIndex];
}

// 加载图片
- (void)setupImageOfImageViewForIndex:(NSInteger)index {
    AndyBrowserImageView *imageView = _scrollView.subviews[index];
    self.currentImageIndex = index;
    if (imageView.hasLoadedImage) return;
    if ([self highQualityImageURLForIndex:index]) {
        [imageView setImageWithURL:[self highQualityImageURLForIndex:index] placeholderImage:[self placeholderImageForIndex:index]];
    } else {
        imageView.image = [self placeholderImageForIndex:index];
    }
    imageView.hasLoadedImage = YES;
}

- (void)photoClick:(UITapGestureRecognizer *)recognizer {
    _scrollView.hidden = YES;
    _willDisappear = YES;
    AndyBrowserImageView *currentImageView = (AndyBrowserImageView *)recognizer.view;
    NSInteger currentIndex = currentImageView.tag;
    UIView *sourceView;
    if ([self.sourceImagesContainerView isKindOfClass:[UICollectionView class]]) {
        sourceView = [(UICollectionView *)self.sourceImagesContainerView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0]];
    } else {
        sourceView = self.sourceImagesContainerView.subviews[currentIndex];
    }
    CGRect targetTemp = [self.sourceImagesContainerView convertRect:sourceView.frame toView:self];
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.contentMode = sourceView.contentMode;
    tempView.clipsToBounds = YES;
    tempView.image = currentImageView.image;
    CGFloat h = (self.bounds.size.width / currentImageView.image.size.width) * currentImageView.image.size.height;
    if (!currentImageView.image) {
        // 防止 因imageview的image加载失败 导致 崩溃
        h = self.bounds.size.height;
    }
    tempView.bounds = CGRectMake(0, 0, self.bounds.size.width, h);
    tempView.center = self.center;
    [self addSubview:tempView];
    _saveButton.hidden = YES;
    _shareButton.hidden = YES;
    [UIView animateWithDuration:AndyPhotoBrowserHideImageAnimationDuration animations:^{
        tempView.frame = targetTemp;
        self.backgroundColor = [UIColor clearColor];
        _indexLabel.alpha = 0.1;
    } completion:^(BOOL finished) {
        if (self.dismissCallBack) {
            self.dismissCallBack();
        }
        [self removeFromSuperview];
    }];
}

- (void)imageViewDoubleTaped:(UITapGestureRecognizer *)recognizer {
    AndyBrowserImageView *imageView = (AndyBrowserImageView *)recognizer.view;
    CGFloat scale;
    if (imageView.isScaled) {
        scale = 1.0;
    } else {
        scale = 2.0;
    }
    AndyBrowserImageView *view = (AndyBrowserImageView *)recognizer.view;
    [view doubleTapToZommWithScale:scale];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    rect.size.width += AndyPhotoBrowserImageViewMargin * 2;
    _scrollView.bounds = rect;
    _scrollView.center = self.center;
    CGFloat y = 0;
    CGFloat w = _scrollView.frame.size.width - AndyPhotoBrowserImageViewMargin * 2;
    CGFloat h = _scrollView.frame.size.height;
    [_scrollView.subviews enumerateObjectsUsingBlock:^(AndyBrowserImageView *obj, NSUInteger idx, BOOL *stop) {
        CGFloat x = AndyPhotoBrowserImageViewMargin + idx * (AndyPhotoBrowserImageViewMargin * 2 + w);
        obj.frame = CGRectMake(x, y, w, h);
    }];
    _scrollView.contentSize = CGSizeMake(_scrollView.subviews.count * _scrollView.frame.size.width, 0);
    _scrollView.contentOffset = CGPointMake(self.currentImageIndex * _scrollView.frame.size.width, 0);
    if (!_hasShowedFistView) {
        [self showFirstImage];
    }
    _indexLabel.center = CGPointMake(self.bounds.size.width * 0.5, 35);
    _saveButton.frame = CGRectMake(0, 0, 50, 25);
    _saveButton.center = CGPointMake(self.bounds.size.width * 0.25, self.bounds.size.height - 35);
    _shareButton.frame = CGRectMake(0, 0, 50, 25);
    _shareButton.center = CGPointMake(self.bounds.size.width * 0.75, self.bounds.size.height - 35);
}

- (void)show {
    [self setupScrollView];
    [self setupToolbars];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addObserver:self forKeyPath:@"frame" options:0 context:nil];
    [window addSubview:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(UIView *)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"frame"]) {
        self.frame = object.bounds;
        AndyBrowserImageView *currentImageView = _scrollView.subviews[_currentImageIndex];
        if ([currentImageView isKindOfClass:[AndyBrowserImageView class]]) {
            [currentImageView clear];
        }
    }
}

- (void)showFirstImage {
    UIView *sourceView;
    if ([self.sourceImagesContainerView isKindOfClass:[UICollectionView class]]) {
        sourceView = [(UICollectionView *)self.sourceImagesContainerView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentImageIndex inSection:0]];
    } else {
        sourceView = self.sourceImagesContainerView.subviews[self.currentImageIndex];
    }
    CGRect rect = [self.sourceImagesContainerView convertRect:sourceView.frame toView:self];
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.image = [self placeholderImageForIndex:self.currentImageIndex];
    [self addSubview:tempView];
    CGRect targetTemp = [_scrollView.subviews[self.currentImageIndex] bounds];
    tempView.frame = rect;
    tempView.contentMode = [_scrollView.subviews[self.currentImageIndex] contentMode];
    _scrollView.hidden = YES;
    [UIView animateWithDuration:AndyPhotoBrowserShowImageAnimationDuration animations:^{
        tempView.center = self.center;
        tempView.bounds = (CGRect){CGPointZero, targetTemp.size};
    } completion:^(BOOL finished) {
        _hasShowedFistView = YES;
        [tempView removeFromSuperview];
        _scrollView.hidden = NO;
    }];
}

- (UIImage *)placeholderImageForIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(photoBrowser:placeholderImageForIndex:)]) {
        return [self.delegate photoBrowser:self placeholderImageForIndex:index];
    }
    return nil;
}

- (NSURL *)highQualityImageURLForIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(photoBrowser:highQualityImageURLForIndex:)]) {
        return [self.delegate photoBrowser:self highQualityImageURLForIndex:index];
    }
    return nil;
}

#pragma mark - scrollview代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = (scrollView.contentOffset.x + _scrollView.bounds.size.width * 0.5) / _scrollView.bounds.size.width;
    // 有过缩放的图片在拖动一定距离后清除缩放
    CGFloat margin = 150;
    CGFloat x = scrollView.contentOffset.x;
    if ((x - index * self.bounds.size.width) > margin || (x - index * self.bounds.size.width) < - margin) {
        AndyBrowserImageView *imageView = _scrollView.subviews[index];
        if (imageView.isScaled) {
            [UIView animateWithDuration:0.5 animations:^{
                imageView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [imageView eliminateScale];
            }];
        }
    }
    if (!_willDisappear) {
        _indexLabel.text = [NSString stringWithFormat:@"%d/%ld", index + 1, (long)self.imageCount];
    }
    [self setupImageOfImageViewForIndex:index];
}

@end
