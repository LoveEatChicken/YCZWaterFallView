//
//  YCZCollectionViewLayout.m
//  WaterFallList
//
//  Created by Crystal on 16/6/22.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import "YCZCollectionViewLayout.h"

#pragma mark defaultParameters List

static const NSInteger waterFallLayoutColumnCount = 3;
static const CGFloat waterFallLayoutColumnMargin = 10;
static const CGFloat waterFallLayoutLineMargin = 10;
static const UIEdgeInsets waterFallLayoutEdgInsets = {10, 10, 10, 10};

@interface YCZCollectionViewLayout ()

@property (assign, nonatomic) CGFloat cellCount;
@property (assign, nonatomic) CGFloat contentHeight;
@property (strong, nonatomic) NSMutableArray *columnHeights;
@property (strong, nonatomic) NSMutableArray *arrtibutesArray;

//不需要外部set赋值
- (NSInteger)columnCount;
- (CGFloat)columnMargin;
- (CGFloat)lineMargin;
- (UIEdgeInsets)edgeInsets;

@end

@implementation YCZCollectionViewLayout

#pragma mark lifecycle method

- (void)prepareLayout {
    
    [super prepareLayout];
    self.contentHeight = 0;
    
    [self.columnHeights removeAllObjects];
    for (int i = 0; i < self.columnCount; i++) {
        
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    [self.arrtibutesArray removeAllObjects];
    for (int i = 0; i < self.cellCount; i++) {
      
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *arrtibutes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.arrtibutesArray addObject:arrtibutes];
    }
}

- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.arrtibutesArray;
}

#pragma mark private method

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = (self.collectionView.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    
    CGFloat height = [self.delegate WaterFallListViewLayout:self heightForItemWithIndex:indexPath itemWidth:width];
    
  
    
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    NSInteger destColumn = 0;
    for (int i = 0; i < self.columnCount; i++) {
        
        if (minColumnHeight > [self.columnHeights[i] doubleValue]) {
            
            minColumnHeight = [self.columnHeights[i] doubleValue];
            destColumn = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + destColumn * (self.columnMargin + width);
    
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        
        y += self.lineMargin;
    }
    
    attribute.frame = CGRectMake(x, y, width, height);
    
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attribute.frame));
    
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        
        self.contentHeight = columnHeight;
    }
    
    return attribute;
}

#pragma mark property method

- (CGFloat)cellCount {
    
    return [self.collectionView numberOfItemsInSection:0];
}

- (NSInteger)columnCount {
    
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterFallListViewLayout:)]) {
        
        return [self.delegate columnCountInWaterFallListViewLayout:self];
    } else {
        
        return waterFallLayoutColumnCount;
    }
}

- (CGFloat)columnMargin {
    
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFallListViewLayout:)]) {
        
        return [self.delegate columnMarginInWaterFallListViewLayout:self];
    } else {
        
        return waterFallLayoutColumnMargin;
    }
}

- (CGFloat)lineMargin {
    
    if ([self.delegate respondsToSelector:@selector(lineMarginInWaterFallListViewLayout:)]) {
        
        return [self.delegate lineMarginInWaterFallListViewLayout:self];
    } else {
        
        return waterFallLayoutLineMargin;
    }
}

- (UIEdgeInsets)edgeInsets {
    
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterFallListViewLayout:)]) {
        
        return [self.delegate edgeInsetsInWaterFallListViewLayout:self];
    } else {
        
        return waterFallLayoutEdgInsets;
    }
}

- (NSMutableArray *)columnHeights {
    
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)arrtibutesArray {
    
    if (!_arrtibutesArray) {
        _arrtibutesArray = [NSMutableArray array];
    }
    return _arrtibutesArray;
}

@end
