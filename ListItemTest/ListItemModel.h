//
//  ListItemModel.h
//  ListItemTest
//
//  Created by xiaotei's on 15/11/11.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListItemModel : NSObject

@property (nonatomic,copy)NSString* itemTitle;

@property (nonatomic,copy)NSString* itemID;

/**
 *  初始化模型
 */
-(instancetype)initWithTitle:(NSString*)title itemID:(NSString*)itemID;

/**
 *  类方法初始化
 */
+(instancetype)listItemWith:(NSString*)title itemID:(NSString*)itemID;

@end
