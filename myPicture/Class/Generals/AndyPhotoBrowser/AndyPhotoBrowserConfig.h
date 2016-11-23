//
//  AndyPhotoBrowserConfig.h
//  myPicture
//
//  Author Andyjicw 479003573@qq.com
//
//  Created by andy on 16/4/29.
//  Copyright © 2016年 andy. All rights reserved.
//


typedef enum {
    AndyWaitingViewModeLoopDiagram,     // 环形
    AndyWaitingViewModePieDiagram       // 饼型
} AndyWaitingViewMode;

// 图片保存成功提示文字
#define AndyPhotoBrowserSaveImageSuccessText        @"保存成功";

// 图片保存失败提示文字
#define AndyPhotoBrowserSaveImageFailText           @"保存失败";

// browser背景颜色
#define AndyPhotoBrowserBackgrounColor              [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]

// browser中图片间的margin
#define AndyPhotoBrowserImageViewMargin             10

// browser中显示图片动画时长
#define AndyPhotoBrowserShowImageAnimationDuration  0.4f

// browser中显示图片动画时长
#define AndyPhotoBrowserHideImageAnimationDuration  0.4f

// 图片下载进度指示进度显示样式（AndyWaitingViewModeLoopDiagram 环形，AndyWaitingViewModePieDiagram 饼型）
#define AndyWaitingViewProgressMode                 AndyWaitingViewModeLoopDiagram

// 图片下载进度指示器背景色
#define AndyWaitingViewBackgroundColor              [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]

// 图片下载进度指示器内部控件间的间距
#define AndyWaitingViewItemMargin                   10


