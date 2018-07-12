//
//  JJBannerCell.h
//  JJScrollView
//
//  Created by luming on 2018/7/12.
//  Copyright © 2018年 luming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBannerModel;
@interface JJBannerCell : UICollectionViewCell

- (void)setModel:(CBannerModel *)model size:(CGSize)size isCache:(BOOL)isCache;

- (void)setImg:(NSString *)img size:(CGSize)size isCache:(BOOL)isCache;

@end
