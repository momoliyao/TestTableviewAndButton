//
//  InputInfoCell.m
//  gegeDeliverIOS
//
//  Created by yinyan on 2017/2/10.
//  Copyright © 2017年 hewaiwai. All rights reserved.
//

#import "InputInfoCell.h"

@implementation InputInfoCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:_titleLabel];
        
        _inputTextFiled = [[UITextField alloc] init];
        _inputTextFiled.textColor = [UIColor blackColor];
        _inputTextFiled.font = [UIFont systemFontOfSize:16.0f];
        _inputTextFiled.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_inputTextFiled];
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setImage:[UIImage imageNamed:@"import"] forState:UIControlStateNormal];
        [_editBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
        [self.contentView addSubview:_editBtn];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 20));
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
        }];
        
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(35, 20));
            make.right.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
        }];
        
        [_inputTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.centerY.equalTo(_editBtn);
            make.right.equalTo(_editBtn.mas_left);
            make.left.equalTo(_titleLabel.mas_right);
        }];
        
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)configWithExpress:(NSArray *)arr1 withInput:(NSArray *)arr2 withIndex:(NSInteger)index{
    self.titleLabel.text = arr1[index];
    self.inputTextFiled.placeholder = arr2[index];
}

- (void)bindTarget:(id) target openSelector:(SEL)action index:(NSInteger)index{
    [self.editBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.editBtn.tag = 333 + index;
    self.inputTextFiled.tag = 666 + index;
}

@end
