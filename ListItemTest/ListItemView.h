//
//  ListItemView.h
//  ListItemTest
//
//  Created by xiaotei's on 15/11/11.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItemModel.h"

@class ListItemView;

@protocol ListItemViewDelegate <NSObject>

//代理方法，标签view，标签view是否正在抖动
- (void)listItemView:(ListItemView*)itemView longPress:(BOOL)isJittery;

//代理方法，点击了标签删除按钮
- (void)listItemView:(ListItemView *)itemView touchDeleteBtn:(ListItemModel*)model;

@end

@interface ListItemView : UIView

/**
 *  开始与结束动画
 */
-(void)startAnimation;

-(void)stopAnimation;


-(instancetype)initWithItemModel:(ListItemModel*)model;

+(instancetype)itemViewWithModel:(ListItemModel*)model;

@property (nonatomic,weak)id<ListItemViewDelegate> delegate;

@end
