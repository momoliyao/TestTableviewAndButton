//
//  YYGroup.m
//  gegeDeliverIOS
//
//  Created by yinyan on 2017/2/16.
//  Copyright © 2017年 hewaiwai. All rights reserved.
//

#import "YYGroup.h"

@implementation YYGroup

//初始化方法
- (instancetype) initWithItem:(NSMutableArray *)item{
    if (self = [super init]) {
        self.folded=YES;
        _items = item;
    }
    return self;
}

//每个组内有多少联系人
- (NSInteger) size {
    return _items.count;
}

@end
