//
//  YXScanView.m
//  baiwandian
//
//  Created by zdy on 15/10/22.
//  Copyright © 2015年 xinyunlian. All rights reserved.
//

#import "YXScanView.h"

@implementation YXScanView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置背景为透明
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置遮罩颜色
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.0 alpha:0.7].CGColor);
    
    CGContextFillRect(context, rect);
    
    // 扫描区域透明
    CGContextClearRect(context, self.scanRect);
}

- (void)setScanRect:(CGRect)scanRect
{
    _scanRect = scanRect;
    
    if (![self viewWithTag:300]) {
        UIImage *image = [UIImage imageNamed:@"scan_frame"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = self.scanRect;
        imageView.tag = 300;
        [self addSubview:imageView];
    }
    
    
    [self setNeedsDisplay];
}

- (void)startScanAnimation
{
    UIImage *image = [UIImage imageNamed:@"scan_redline"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    imageView.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetMinY(self.scanRect));
    imageView.tag = 200;
    [self addSubview:imageView];

    CGPoint start = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetMinY(self.scanRect));
    CGPoint end = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetMaxY(self.scanRect));
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values = @[[NSValue valueWithCGPoint:start],[NSValue valueWithCGPoint:end],[NSValue valueWithCGPoint:start]];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 5;
    [imageView.layer addAnimation:animation forKey:@"scan.animation"];
    
}

- (void)pauseScanAnimation
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:200];
    
    CFTimeInterval pausedTime = [imageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    imageView.layer.speed = 0.0;
    imageView.layer.timeOffset = pausedTime;
}

- (void)restartScanAnimation
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:200];

    CFTimeInterval pausedTime = imageView.layer.timeOffset;
    imageView.layer.speed = 1.0;
    imageView.layer.timeOffset = 0.0;
    CFTimeInterval timeSincePause = [imageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    imageView.layer.beginTime = timeSincePause;
}
@end
