//
//  ViewController.m
//  YXScan
//
//  Created by zdy on 15/10/24.
//  Copyright © 2015年 xinyunlian. All rights reserved.
//

#import "ViewController.h"
#import "YXScanViewController.h"

@interface ViewController ()
<YXScanDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"扫描";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanPressed:(id)sender {
    YXScanViewController *vc = [[YXScanViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scanViewController:(YXScanViewController *)scanController result:(NSString *)result
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = result;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
