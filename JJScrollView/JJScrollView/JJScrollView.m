//
//  JJScrollView.m
//  JJScrollView
//
//  Created by luming on 2018/7/12.
//  Copyright © 2018年 luming. All rights reserved.
//

#import "JJScrollView.h"
#import "JJBannerCell.h"
#import "CBannerModel.h"
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width

#define JJBannerCellID @"JJBannerCell"
#define JJMaxSections 100
@interface JJScrollView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) NSTimer *timer;

@property (nonatomic , strong) UIPageControl *pageControl;

@property (nonatomic , strong) NSArray *dataArray;

@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic,assign ) BOOL isAuto;
@property (nonatomic,assign) BOOL isCache;

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;


@end

@implementation JJScrollView

- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)imgArray isAuto:(BOOL)isAuto
{
   return [self initWithFrame:frame imgArray:imgArray titleArray:nil isAuto:isAuto isCache:NO];
}

- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)imgArray titleArray:(NSArray *)titleArray isAuto:(BOOL)isAuto isCache:(BOOL)isCache
{
    self = [super initWithFrame:frame];
    if (self) {
        _width = frame.size.width;
        _height = frame.size.height;
        _dataArray = imgArray;
        _titleArray = titleArray;
        _isAuto = isAuto;
        _isCache = isCache;
        [self initSubview];
    }
    return self;
}


- (void)initSubview{
    

    [self addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, 0, _width, _height);
    
    [self.collectionView registerClass:[JJBannerCell class] forCellWithReuseIdentifier:JJBannerCellID];
    
    [self addSubview:self.pageControl];
    
    _pageControl.center = CGPointMake(_width*0.5,_height-20);
    if (_isAuto) {
        [self addTimer];

    }
    if (self.dataArray.count > 0) {
        [self settingCollection];
    }
    
}

- (void)setImgArray:(NSArray *)imgArray
{
    self.dataArray = [imgArray copy];
    [self settingCollection];
    [self.collectionView reloadData];
}

- (void)setPageIndicator:(UIColor *)pageIndicator
{
    _pageControl.pageIndicatorTintColor = pageIndicator;
}

- (void)setCurrentPageIndicator:(UIColor *)currentPageIndicator
{
    _pageControl.currentPageIndicatorTintColor = currentPageIndicator;
}

- (void)setPageIndicatorImg:(NSString *)pageIndicatorImg
{
        [_pageControl setValue:[UIImage imageNamed:pageIndicatorImg] forKeyPath:@"pageImage"];
}

- (void)setCurrentPageIndicatorImg:(NSString *)currentPageIndicatorImg
{
    [_pageControl setValue:[UIImage imageNamed:currentPageIndicatorImg] forKeyPath:@"currentPageImage"];
}


#pragma mark - 设置collection
- (void)settingCollection{
//        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:JJMaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    _pageControl.numberOfPages = self.dataArray.count;

}

#pragma mark 添加定时器
-(void) addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer ;
    
}

#pragma mark 删除定时器
-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc
{
    if (_isAuto) {
        [self removeTimer];
    }
}

-(void) nextpage{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:JJMaxSections/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item +1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem==self.dataArray.count) {
        nextItem=0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark- UICollectionViewDataSource
// 我们这里设置了最大分区个数100
// 我们可以将第50个分区的一组图片作为用户看到的第一组图片，这样就实现轮播的效果了
//逻辑上传入数组个数其实已经足够了,这里防止过快导致无法滚动的问题
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return JJMaxSections;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JJBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JJBannerCellID forIndexPath:indexPath];
    if(!cell){
        cell = [[JJBannerCell alloc] init];
    }
    id obj = self.dataArray[indexPath.item];
    if ([obj isKindOfClass:[CBannerModel class]]) {
        [cell setModel:obj size:CGSizeMake(_width, _height) isCache:_isCache];
    }
    if ([obj isKindOfClass:[NSString class]]) {
        [cell setImg:obj size:CGSizeMake(_width, _height) isCache:_isCache];
    }
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_width, _height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = self.dataArray[indexPath.item];
    if ([obj isKindOfClass:[CBannerModel class]]) {
        if (self.selectedImgBlock) {
            self.selectedImgBlock(obj);
        }
    }else
    {
        if (self.selectedImgIndexBlock) {
            self.selectedImgIndexBlock(indexPath.item);
        }
    }

}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_isAuto) {
        [self removeTimer];

    }
}

#pragma mark 当用户停止的时候调用
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_isAuto) {
        [self addTimer];

    }
}

#pragma mark 设置页码
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.dataArray.count;
    self.pageControl.currentPage =page;
}

#pragma mark - setter and getter
- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //        _flowLayout.itemSize = CGSizeMake(ScreenWidth, _height);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        
        _pageControl.bounds = CGRectMake(0, 0, 150, 40);
        _pageControl.pageIndicatorTintColor = [UIColor blueColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.enabled = NO;
        
    }
    return _pageControl;
}




@end
