//
//  YXScanViewController.m
//  baiwandian
//
//  Created by zdy on 15/10/22.
//  Copyright © 2015年 xinyunlian. All rights reserved.
//

#import "YXScanViewController.h"
#import "ZXingObjC.h"

@interface YXScanViewController ()
<ZXCaptureDelegate>

@property (nonatomic, strong) ZXCapture *zxCapture;
@property (nonatomic, strong) YXScanView *scanView;
@property (nonatomic, strong) NSString *resultString;
@end

@implementation YXScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"扫一扫";
    [self loadZXCapture];
    [self loadScanView];
}

- (void)loadZXCapture
{
    ZXCapture *capture = [[ZXCapture alloc] init];
    capture.rotation = 90.0f;
    capture.camera = capture.back;
    capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    [self.view.layer insertSublayer:capture.layer atIndex:0];
    
    self.zxCapture = capture;
}

- (void)loadScanView
{
    YXScanView *scanView = [[YXScanView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scanView];
    
//    [scanView startScanAnimation];
    
    self.scanView = scanView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBar.translucent = YES;
    CGFloat UIScreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat UIScreenHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.resultString = @"";
    
    self.zxCapture.delegate = self;
    self.zxCapture.layer.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    self.zxCapture.scanRect = CGRectMake((UIScreenWidth-300)/2, 100, 300, 300);
    self.scanView.scanRect = CGRectMake((UIScreenWidth-300)/2, 100, 300, 300);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark ZXCapture
- (void)captureCameraIsReady:(ZXCapture *)capture
{
    [self.scanView startScanAnimation];
}

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result
{
    if ([self.resultString isEqualToString:result.text]) {
        return;
    }
    else {
        self.resultString = result.text;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scanViewController:result: )]) {
        [self.delegate scanViewController:self result:self.resultString];
    }
}

- (void)captureSize:(ZXCapture *)capture width:(NSNumber *)width height:(NSNumber *)height
{
    
}
@end
