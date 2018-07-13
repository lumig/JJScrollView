# JJScrollView

一个用UICollectionView实现的图片轮播图

代码实现案例:
传入图片数组
```
//   简单传入图片数据，返回点击索引
JJScrollView *scroll = [[JJScrollView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 200) imgArray:nil isAuto:YES];
[self.view addSubview:scroll];

scroll.imgArray = @[@"http://m.creditcat.cn/images/banner_dkdq.png",@"http://m.creditcat.cn/images/banner_dkdq.png"];
scroll.pageIndicatorImg = @"Carousel";
scroll.currentPageIndicatorImg = @"Carousel_on";
[scroll setSelectedImgIndexBlock:^(NSInteger index) {
NSLog(@"我选中了 %ld",index);
}];
```
传入对象数组
```
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

```
