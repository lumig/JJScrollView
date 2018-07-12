//
//  JJBannerCell.m
//  JJScrollView
//
//  Created by luming on 2018/7/12.
//  Copyright © 2018年 luming. All rights reserved.
//

#import "JJBannerCell.h"
#import "CBannerModel.h"
#import <UIImageView+WebCache.h>
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width

@interface JJBannerCell()
@property (strong , nonatomic)  UILabel *label;
@property (strong , nonatomic)  UIImageView *imageView;
@end

@implementation JJBannerCell

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.label];
    }
    
    return self;
}



- (void)setModel:(CBannerModel *)model size:(CGSize)size isCache:(BOOL)isCache
{
    NSString *imgURL = model.imageUrl;
    
    if ([imgURL hasPrefix:@"http://"] || [imgURL hasPrefix:@"https://"])
    {
        //网络图片 请使用ego异步图片库
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgURL]  placeholderImage:[UIImage imageNamed:@"img_tc_zw"]];
        
    }
    else
    {
        if (isCache) {
            UIImage *img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imgURL];
            [self.imageView setImage:img];

        }else
        {
        self.imageView.image = [UIImage imageNamed:model.imageUrl];

            
        }
        
    }
    
    _imageView.backgroundColor = [UIColor redColor];
    //    self.label.text = _news.title;
    self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
    //    self.label.frame = CGRectMake(0, 0, screenWidth, 200);
    //    self.label.font = [UIFont systemFontOfSize:30];
    //    self.label.textAlignment = NSTextAlignmentCenter;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}


@end
