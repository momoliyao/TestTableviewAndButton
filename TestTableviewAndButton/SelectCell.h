//
//  SelectCell.h
//  gegeDeliverIOS
//
//  Created by yinyan on 2017/2/16.
//  Copyright © 2017年 hewaiwai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseRankView.h"

@interface SelectCell : UITableViewCell<ChooseRankDelegate>

@property(nonatomic,strong)ChooseRankView *chooseRankView; //

@property(nonatomic,strong)NSMutableArray *selectArray;  //被选中的btn的title

@property(nonatomic,strong)NSArray *arr;  //假数据，待选择的btn的title

- (void)configWithExpress:(NSArray *)arr;

@end
