//
//  CBannerModel.h
//  JJScrollView
//
//  Created by luming on 2018/7/12.
//  Copyright © 2018年 luming. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CBannerModel : NSObject
/**
 imageUrl     string     图片网址
 pageUrl     string     详情页网址
 */

@property (nonatomic,copy) NSString *imageUrl;

@property (nonatomic,copy) NSString *pageUrl;
@end
