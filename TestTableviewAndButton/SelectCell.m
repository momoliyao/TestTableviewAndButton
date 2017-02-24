//
//  SelectCell.m
//  gegeDeliverIOS
//
//  Created by yinyan on 2017/2/16.
//  Copyright © 2017年 hewaiwai. All rights reserved.
//

#import "SelectCell.h"

@implementation SelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configWithExpress:(NSArray *)arr{
    self.arr = arr;
    CGFloat maxY = 0;
    CGFloat height = 0;
    if(!_chooseRankView){
        _chooseRankView = [[ChooseRankView alloc] initWithTitleArr:self.arr andFrame:CGRectMake(0, maxY, SCREEN_WIDTH, 40)];
        maxY = CGRectGetMaxY(self.chooseRankView.frame);
//        height += self.chooseRankView.height;
        height += self.chooseRankView.frame.size.height;
        _chooseRankView.delegate = self;
        _chooseRankView.tag = 8000;
        [self.contentView addSubview:_chooseRankView];
    }
}

-(void)selectBtnTitle:(NSString *)title andBtn:(UIButton *)btn{
    ChooseRankView *view = [self.contentView viewWithTag:8000];
    
    for (UIButton *obj in view.btnView.subviews) {
        if(obj.selected){
            for (NSString *title in self.arr) {
                
                if ([view.selectBtn.titleLabel.text isEqualToString:title] && ![self.selectArray containsObject:view.selectBtn.titleLabel.text]) {
                    
                    [self.selectArray addObject:view.selectBtn.titleLabel.text];
                }
            }
            
        }else {
            if ([self.selectArray containsObject:obj.titleLabel.text]) {
                [self.selectArray removeObject:view.selectBtn.titleLabel.text];
            }
        }
    }
    NSLog(@"%@",self.selectArray);
    
    
    
}

-(NSMutableArray *)selectArray{
    
    if (_selectArray == nil) {
        
        _selectArray = [[NSMutableArray alloc] init];
    }
    return _selectArray;
}

@end
