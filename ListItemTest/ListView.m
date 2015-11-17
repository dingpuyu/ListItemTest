//
//  ListView.m
//  ListItemTest
//
//  Created by xiaotei's on 15/11/17.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import "ListView.h"



@interface ListView()<ListItemViewDelegate>
//标签数组
@property (nonatomic,strong)NSMutableDictionary* itemViewDict;

//备用数组
@property (nonatomic,strong)NSMutableArray* spareItemArray;

@property (nonatomic,strong)UIButton* moreItemButton;

@end

@implementation ListView
- (instancetype)initWithModels:(NSArray *)models{
    if (self = [super init]) {
        self.listItemModelArray = [[NSMutableArray alloc]initWithArray:models];
        self.userInteractionEnabled = YES;
    }
    return self;
}

+ (instancetype)listViewWithModels:(NSArray *)models {
    return [[self alloc]initWithModels:models];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self reloadView];
}


#pragma mark - setter
- (void)setListItemModelArray:(NSMutableArray *)listItemModelArray{

    _listItemModelArray = listItemModelArray;
}


- (void)reloadView{
//    移除所有子视图
    for (UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - (ItemColumn + 1) * ItemMarginX)/ItemColumn;
    CGFloat itemX = ItemMarginX;
    CGFloat itemY = ItemMarginY;
    
    for (int i = 0; i < _listItemModelArray.count; i++) {
        ListItemModel* model = _listItemModelArray[i];
        ListItemView* itemView = self.itemViewDict[model.itemID];
        if (!itemView) {
            itemView = [ListItemView itemViewWithModel:model];
            [self.itemViewDict setValue:itemView forKey:model.itemID];
        }
        itemView.delegate = self;
        itemX = i % ItemColumn * itemW + (i % ItemColumn + 1)*ItemMarginX;
        itemY = i / ItemColumn * ItemHeight + (i / ItemColumn + 1)* ItemMarginY;
        itemView.frame = CGRectMake(itemX, itemY, itemW, ItemHeight);

        [self addSubview:itemView];
    }
    if (_listItemModelArray.count < 8) {
        UIButton* moreBtn = [self moreItemButton];
        NSInteger i = _listItemModelArray.count;
        itemX = i % ItemColumn * itemW + (i % ItemColumn + 1)*ItemMarginX;
        itemY = i / ItemColumn * ItemHeight + (i / ItemColumn + 1)* ItemMarginY;
        moreBtn.frame = CGRectMake(itemX, itemY, itemW, ItemHeight);
        [self addSubview:moreBtn];
    }
}

#pragma mark - getter

- (NSMutableDictionary *)itemViewDict{
    if (!_itemViewDict) {
        _itemViewDict = [[NSMutableDictionary alloc]initWithCapacity:_listItemModelArray.count];
    }
    return _itemViewDict;
}

- (UIButton *)moreItemButton{
    if (!_moreItemButton) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"更多" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor purpleColor]];
        _moreItemButton = button;
    }
    return _moreItemButton;
}

- (NSMutableArray *)spareItemArray{
    if (!_spareItemArray) {
        _spareItemArray = [[NSMutableArray alloc]initWithCapacity:FullItemCount];
    }
    return _spareItemArray;
}

#pragma mark - listItemDelegate
-(void)listItemView:(ListItemView *)itemView longPress:(BOOL)isJittery{
    if (isJittery) return;
    [self startJitter];
}

-(void)listItemView:(ListItemView *)itemView touchDeleteBtn:(ListItemModel *)model{
    [_listItemModelArray removeObject:model];
    [_itemViewDict removeObjectForKey:model.itemID];
    
    [self.spareItemArray addObject:model];
    
    [self reloadView];
}

- (void)startJitter{
    for (ListItemView* itemView in [_itemViewDict allValues]) {
        [itemView startAnimation];
    }
}

- (void)stopJitter{
    for (ListItemView* itemView in [_itemViewDict allValues]) {
        [itemView stopAnimation];
    }
}

@end
