//
//  MainViewController.h
//  myPicture
//
//  Created by andy on 16/4/29.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageModel : NSObject

@property (nonatomic,copy) NSString *image;

@end

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end

