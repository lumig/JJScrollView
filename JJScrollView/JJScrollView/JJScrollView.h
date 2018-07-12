//
//  JJScrollView.h
//  JJScrollView
//
//  Created by luming on 2018/7/12.
//  Copyright © 2018年 luming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBannerModel;
@interface JJScrollView : UIView

//pageControl圆圈颜色
@property (nonatomic,strong) UIColor *pageIndicator;

@property (nonatomic,strong) UIColor *currentPageIndicator;

//自定义pageCotrol
@property (nonatomic,strong) NSString *pageIndicatorImg;
@property (nonatomic,strong) NSString *currentPageIndicatorImg;

@property (nonatomic,strong) NSArray *imgArray;
#pragma mark - 只有图片滚动
- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)imgArray isAuto:(BOOL)isAuto ;

#pragma mark - 是否自动滚动 和 是否缓存图片
- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)imgArray titleArray:(NSArray *)titleArray isAuto:(BOOL)isAuto isCache:(BOOL)isCache;


@property (nonatomic,copy) void (^selectedImgBlock)(CBannerModel *model);


@end
