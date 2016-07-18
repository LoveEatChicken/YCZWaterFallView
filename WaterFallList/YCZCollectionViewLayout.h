//
//  YCZCollectionViewLayout.h
//  WaterFallList
//
//  Created by Crystal on 16/6/22.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCZCollectionViewLayoutDelegate;

@interface YCZCollectionViewLayout : UICollectionViewLayout

@property (weak, nonatomic) id<YCZCollectionViewLayoutDelegate> delegate;

@end

@protocol YCZCollectionViewLayoutDelegate <NSObject>

@required

- (CGFloat)WaterFallListViewLayout:(YCZCollectionViewLayout *)WaterFallListViewLayout heightForItemWithIndex:(NSIndexPath *)index itemWidth:(CGFloat)itemWidth;

@optional
//- (NSInteger)cellCountInWaterFallListViewLayout:(YCZCollectionViewLayout *)WaterFallListViewLayout;
- (CGFloat)columnCountInWaterFallListViewLayout:(YCZCollectionViewLayout *)WaterFallListViewLayout;
- (CGFloat)columnMarginInWaterFallListViewLayout:(YCZCollectionViewLayout *)WaterFallListViewLayout;
- (CGFloat)lineMarginInWaterFallListViewLayout:(YCZCollectionViewLayout *)WaterFallListViewLayout;
- (UIEdgeInsets)edgeInsetsInWaterFallListViewLayout:(YCZCollectionViewLayout *)WaterFallListViewLayout;

@end