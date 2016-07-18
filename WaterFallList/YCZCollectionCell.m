//
//  YCZCollectionCell.m
//  WaterFallList
//
//  Created by Crystal on 16/6/22.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import "YCZCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface YCZCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *backImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation YCZCollectionCell

- (void)setShop:(YCZShop *)shop {
    
    _shop = shop;
    
    [self.backImg sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:nil];
    [self.titleLabel setText:self.shop.price];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
