//
//  InputInfoCell.h
//  gegeDeliverIOS
//
//  Created by yinyan on 2017/2/10.
//  Copyright © 2017年 hewaiwai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *inputTextFiled;
@property (nonatomic, strong) UIButton *editBtn;

- (void)configWithExpress:(NSArray *)arr1 withInput:(NSArray *)arr2 withIndex:(NSInteger)index;

- (void)bindTarget:(id) target openSelector:(SEL)action index:(NSInteger)index;

@end
