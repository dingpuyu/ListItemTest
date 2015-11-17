//
//  ListView.h
//  ListItemTest
//
//  Created by xiaotei's on 15/11/17.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItemView.h"

#define ItemHeight 80
#define ItemColumn 4
#define ItemMarginX 10
#define ItemMarginY 10

//占满数目
#define FullItemCount 8

@interface ListView : UIView

//模型数组
@property (nonatomic,strong)NSMutableArray* listItemModelArray;

- (instancetype)initWithModels:(NSArray*)models;

+ (instancetype)listViewWithModels:(NSArray*)models;

//开始抖动，抖动
- (void)startJitter;
//关闭抖动
- (void)stopJitter;
@end
