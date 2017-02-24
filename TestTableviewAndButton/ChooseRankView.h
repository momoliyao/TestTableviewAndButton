//
//  ChooseRank.h
//  gegeDeliverIOS
//
//  Created by yinyan on 2017/2/16.
//  Copyright © 2017年 hewaiwai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseRankDelegate <NSObject>
@required
-(void)selectBtnTitle:(NSString *)title andBtn:(UIButton *)btn;

@end

@interface ChooseRankView : UIView

@property(nonatomic,strong)NSArray *rankArray;

@property(nonatomic,strong)UIButton *selectBtn;

@property(nonatomic,strong)UIView *packView;
@property(nonatomic,strong)UIView *btnView;

@property(nonatomic,assign)id<ChooseRankDelegate> delegate;



-(instancetype)initWithTitleArr:(NSArray *)titleArr andFrame:(CGRect)frame;


@end
