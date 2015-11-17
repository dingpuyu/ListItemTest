//
//  ListItemModel.m
//  ListItemTest
//
//  Created by xiaotei's on 15/11/11.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import "ListItemModel.h"

@implementation ListItemModel
+(instancetype)listItemWith:(NSString *)title itemID:(NSString *)itemID{
    return [[self alloc]initWithTitle:title itemID:itemID];
}

-(instancetype)initWithTitle:(NSString *)title itemID:(NSString *)itemID{
    if (self = [super init]) {
        _itemTitle = title;
        _itemID = itemID;
    }
    return self;
}


-(NSString *)description{
    return [NSString stringWithFormat:@"title:%@,id:%@",_itemTitle,_itemID];
}

@end
