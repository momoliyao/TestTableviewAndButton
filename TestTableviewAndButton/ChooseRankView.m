//
//  ChooseRank.m
//  gegeDeliverIOS
//
//  Created by yinyan on 2017/2/16.
//  Copyright © 2017年 hewaiwai. All rights reserved.
//

#import "ChooseRankView.h"
#import "UIView+Extension.h"

@implementation ChooseRankView

-(instancetype)initWithTitleArr:(NSArray *)titleArr andFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        self.rankArray = [NSArray arrayWithArray:titleArr];
        [self rankView];
    }
    return self;
}


-(void)rankView{
    
    self.packView = [[UIView alloc] initWithFrame:self.frame];
    self.packView.y = 0;

    self.btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 40)];
    [self.packView addSubview:self.btnView];
    
    int count = 0;
    float btnWidth = 0;
    float viewHeight = 0;
    for (int i = 0; i < self.rankArray.count; i++) {
        
        NSString *btnName = self.rankArray[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:btnName forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13.0f] forKey:NSFontAttributeName];
        CGSize btnSize = [btnName sizeWithAttributes:dict];
        
        btn.width = btnSize.width + 15;
        btn.height = btnSize.height + 12;
        
        if (i==0)
        {
            btn.x = 20;
            btnWidth += CGRectGetMaxX(btn.frame);
        }
        else{
            btnWidth += CGRectGetMaxX(btn.frame)+20;
            if (btnWidth > SCREEN_WIDTH) {
                count++;
                btn.x = 20;
                btnWidth = CGRectGetMaxX(btn.frame);
            }
            else{
                
                btn.x += btnWidth - btn.width;
            }
        }
        btn.y += count * (btn.height+10)+10;
        
        viewHeight = CGRectGetMaxY(btn.frame)+10;
        
        [self.btnView addSubview:btn];
        
        btn.tag = 10000+i;
        
        
        //        if ([btnName isEqualToString:self.selectStr])
        //        {
        //            self.selectBtn = btn;
        //            self.selectBtn.selected = YES;
        //            self.selectBtn.backgroundColor = [UIColor greenColor];
        //        }
        
    }
    self.btnView.height = viewHeight;
    self.packView.height = self.btnView.height+CGRectGetMaxY(self.btnView.frame);
    
    self.height = self.packView.height;
    
    [self addSubview:self.packView];
}


-(void)btnClick:(UIButton *)btn{
    btn.selected = !(btn.selected);
    if (btn.selected) {
        btn.layer.borderColor = [UIColor blueColor].CGColor;
    }else{
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }

    self.selectBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(selectBtnTitle:andBtn:)]) {
        
        [self.delegate selectBtnTitle:btn.titleLabel.text andBtn:self.selectBtn];
    }
}

@end
