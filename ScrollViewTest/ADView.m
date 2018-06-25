//
//  ADView.m
//  ScrollViewTest
//
//  Created by 梁超 on 2018/6/19.
//  Copyright © 2018年 梁超. All rights reserved.
//

#import "MTConfig.h"
#import <UIKit/UIKit.h>

@interface ADItemView : UIControl

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ADItemView

- (instancetype)initWithFrame:(CGRect)frame withSubViewRect:(CGRect)subViewRect withImg:(UIImage *)img{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithFrame:subViewRect];
        self.imageView.image = img;
        [self addSubview:self.imageView];
        self.clipsToBounds = YES;
    }
    return self;
}

// - 调整子视图位置
- (void)adjustSubViewOffsetX:(CGFloat)offsetX {
    CGRect rect = self.imageView.frame;
    self.imageView.frame = CGRectMake(offsetX, rect.origin.y, rect.size.width, rect.size.height);
}

@end


#import "ADView.h"

@interface ADView() <UIScrollViewDelegate>

/**
 * 滚动视图
 */
@property (nonatomic,strong) UIScrollView *scrollView;


/**
 * 子视图集合
 */
@property (nonatomic,strong) NSMutableArray *subViewArr;

@end

@implementation ADView

- (instancetype)initWithFrame:(CGRect)frame withImgData:(NSArray <UIImage *> *)imgData {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        
        // -- 添加子view
        for (int i = 0; i < imgData.count; i++) {
            CGRect rect;
            CGRect subViewRect;
            if (i == 0) {
                subViewRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            } else {
                subViewRect = CGRectMake(-self.frame.size.width/4, 0, self.frame.size.width, self.frame.size.height);
            }
            rect = CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height);
            ADItemView *itemView = [[ADItemView alloc] initWithFrame:rect withSubViewRect:subViewRect withImg:imgData[i]];
            [self.scrollView addSubview:itemView];
            
            [self.subViewArr addObject:itemView];
        }
        
        // - 无限循环
        ADItemView *itemView = [[ADItemView alloc]
                                initWithFrame:CGRectMake(self.frame.size.width*4, 0, self.frame.size.width, self.frame.size.height)
                                withSubViewRect:CGRectMake(-self.frame.size.width/4, 0, self.frame.size.width, self.frame.size.height)
                                withImg:imgData.firstObject];
        [self.scrollView addSubview:itemView];
        [self.subViewArr addObject:itemView];
        
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width*5, self.frame.size.height);
    }
    return self;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int idx = scrollView.contentOffset.x / self.frame.size.width;
    
    // - 中间item
    ADItemView *itemViewMid = [self.subViewArr objectAtIndex:idx];
    // - 计算偏移量
    CGFloat offsetXMid = (scrollView.contentOffset.x - self.frame.size.width*idx)/4;
    // - 调整子Viewframe
    [itemViewMid adjustSubViewOffsetX:offsetXMid];
    
    // - 后一个item
    if (idx+1 < self.subViewArr.count){
        ADItemView *itemViewLast = [self.subViewArr objectAtIndex:idx+1];
        CGFloat offsetXLast = (scrollView.contentOffset.x - self.frame.size.width*(idx+1))/4;
        [itemViewLast adjustSubViewOffsetX:offsetXLast];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 如果是最后一个View更换scrollview的contentOffetSize
    int x1 = scrollView.contentOffset.x + self.frame.size.width;
    int x2 = scrollView.contentSize.width;
    
    if ( x1 == x2) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 如果是最后一个View更换scrollview的contentOffetSize
    int x1 = scrollView.contentOffset.x + self.frame.size.width;
    int x2 = scrollView.contentSize.width;
    
    if ( x1 == x2) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

#pragma mark - lazy
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

-(NSMutableArray *)subViewArr {
    if (!_subViewArr) {
        _subViewArr = [[NSMutableArray alloc] init];
    }
    return _subViewArr;
}


@end
