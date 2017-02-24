//
//  YYGroup.h
//  gegeDeliverIOS
//
//  Created by yinyan on 2017/2/16.
//  Copyright © 2017年 hewaiwai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYGroup : NSObject

//选项数据
@property (nonatomic, strong) NSMutableArray *items;
//cell的选项行数
@property (nonatomic, readonly) NSInteger size;
//是否折叠
@property (nonatomic, assign, getter=isFolded) BOOL folded;

//初始化方法
- (instancetype) initWithItem:(NSMutableArray *)item;

@end
