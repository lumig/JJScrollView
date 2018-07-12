//
//  ViewController.m
//  JJScrollView
//
//  Created by luming on 2018/7/12.
//  Copyright © 2018年 luming. All rights reserved.
//

#import "ViewController.h"
#import "JJScrollView.h"
#import "CBannerModel.h"
#import "JJBannerCell.h"
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()


@property (nonatomic,strong) JJScrollView *bannerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CBannerModel *banner = [[CBannerModel alloc] init];
    banner.imageUrl = @"960";
//
    
        JJScrollView *scroll = [[JJScrollView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 200) imgArray:nil isAuto:YES];
        [self.view addSubview:scroll];
    
    scroll.imgArray = @[banner,banner,banner];
    scroll.pageIndicator = [UIColor redColor];
    scroll.currentPageIndicator = [UIColor blackColor];
    [scroll setSelectedImgBlock:^(CBannerModel *model) {
        NSLog(@"我被点击了！");
    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
