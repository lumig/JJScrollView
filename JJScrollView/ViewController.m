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
  
//   简单传入图片数据，返回点击索引
    JJScrollView *scroll = [[JJScrollView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 200) imgArray:nil isAuto:YES];
        [self.view addSubview:scroll];
    
    scroll.imgArray = @[@"http://m.creditcat.cn/images/banner_dkdq.png",@"http://m.creditcat.cn/images/banner_dkdq.png"];
    scroll.pageIndicatorImg = @"Carousel";
    scroll.currentPageIndicatorImg = @"Carousel_on";
    [scroll setSelectedImgIndexBlock:^(NSInteger index) {
        NSLog(@"我选中了 %ld",index);
    }];
    
//    传入model对象数组，返回点击的对象
    CBannerModel *banner = [[CBannerModel alloc] init];
    banner.imageUrl = @"960";
    
    JJScrollView *scroll1 = [[JJScrollView alloc] initWithFrame:CGRectMake(0, 400, ScreenWidth, 200) imgArray:nil isAuto:YES];
    [self.view addSubview:scroll1];
    
    scroll1.imgArray = @[banner,banner,banner];
    scroll1.pageIndicator = [UIColor redColor];
    scroll1.currentPageIndicator = [UIColor blackColor];
    
    
    [scroll1 setSelectedImgBlock:^(CBannerModel *model) {
        NSLog(@"我被点击了！");
    }];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
