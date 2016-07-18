//
//  ViewController.m
//  WaterFallList
//
//  Created by Crystal on 16/6/22.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import "ViewController.h"
#import "YCZCollectionViewLayout.h"
#import "YCZCollectionCell.h"
#import "YCZShop.h"

NSString *const ItemIdentifier = @"itemIdentifier";

@interface ViewController ()<UICollectionViewDataSource, YCZCollectionViewLayoutDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ViewController

#pragma mark lifecycle method

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadDataSource];
    [self setupLayout];
}

#pragma mark private method

- (void)setupLayout {
    
    YCZCollectionViewLayout *layout = [[YCZCollectionViewLayout alloc] init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YCZCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:ItemIdentifier];
    
    self.collectionView = collectionView;
}

- (void)loadDataSource {
    
    _dataSource = [[NSMutableArray alloc] init];
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"plist"];
    NSArray *shops = [NSMutableArray arrayWithContentsOfFile:fileName];
    for (NSDictionary *shopDic in shops) {
        
        YCZShop *shop = [[YCZShop alloc] init];
        shop.w = [[shopDic objectForKey:@"w"] floatValue];
        shop.h = [[shopDic objectForKey:@"h"] floatValue];
        shop.img = [shopDic objectForKey:@"img"];
        shop.price = [shopDic objectForKey:@"price"];
        [_dataSource addObject:shop];
    }
}

#pragma mark datasource method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return  [_dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YCZCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];
    cell.shop = self.dataSource[indexPath.item];
    
    return cell;
}

#pragma mark YCZCollectionViewLayoutDelegate method

- (CGFloat)WaterFallListViewLayout:(YCZCollectionViewLayout *)WaterFallListViewLayout heightForItemWithIndex:(NSIndexPath *)index itemWidth:(CGFloat)itemWidth {
    
    YCZShop *shop = _dataSource[index.item];
    
    return itemWidth * shop.h / shop.w;
}

- (CGFloat)columnCountInWaterFallListViewLayout:(YCZCollectionViewLayout *)WaterFallListViewLayout {
    
    return 3;
}

- (CGFloat)columnMarginInWaterFallListViewLayout:(YCZCollectionViewLayout *)WaterFallListViewLayout {
    
    return 10;
}

- (UIEdgeInsets)edgeInsetsInWaterFallListViewLayout:(YCZCollectionViewLayout *)WaterFallListViewLayout {
    
    return UIEdgeInsetsMake(10, 20, 30, 10);
}

@end
