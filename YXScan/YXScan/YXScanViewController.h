//
//  YXScanViewController.h
//  baiwandian
//
//  Created by zdy on 15/10/22.
//  Copyright © 2015年 xinyunlian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXScanView.h"

@class YXScanViewController;
@protocol YXScanDelegate <NSObject>

@optional
- (void)scanViewController:(YXScanViewController *)scanController result:(NSString *)result;
@end

@interface YXScanViewController : UIViewController
@property (nonatomic, weak) id<YXScanDelegate>delegate;
@end
