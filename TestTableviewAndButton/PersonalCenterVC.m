//
//  PersonalCenterVC.m
//  gegeDeliverIOS
//
//  Created by 殷艳 on 16/1/14.
//  Copyright © 2016年 hewaiwai. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "InputInfoCell.h"
#import "SelectCell.h"
#import "YYGroup.h"

@interface PersonalCenterVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *avatarsView;  //用户头像
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *detailArr1;
@property (nonatomic, strong) NSMutableArray *dataBtnTitleArr; //多选按钮的title
@property (nonatomic, strong) NSArray *selectedArr; //被选中按钮的title

@end

@implementation PersonalCenterVC
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

#pragma mark - config UI and Data
- (void)configUI{
    [super configUI];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableview.tableHeaderView = self.headerView;
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)configData{
    [super configData];
    self.titleArr = @[@"手机号", @"会内职务", @"姓名"];
    self.detailArr1 = @[@"18888888888", @"会长", @"李四"];
    
    //填充的假数据 初始化分组模型
    if (!_dataBtnTitleArr) {
        _dataBtnTitleArr = [NSMutableArray array];
    }
    
    
//    YYGroup *group1 = [[YYGroup alloc] initWithItem:@[@"紫色",@"灰灰灰灰灰",@"蓝蓝蓝",@"黄黄",@"红红红红红红红红"]];
//    YYGroup *group2 = [[YYGroup alloc] initWithItem:@[@"紫色",@"灰灰灰灰灰",@"蓝蓝蓝",@"黄黄",@"红红红红红红红红"]];
//    YYGroup *group3 = [[YYGroup alloc] initWithItem:@[@"紫色",@"灰灰灰灰灰",@"蓝蓝蓝",@"黄黄",@"红红红红红红红红"]];
//    [self.dataBtnTitleArr addObject:group1];
//    [self.dataBtnTitleArr addObject:group2];
//    [self.dataBtnTitleArr addObject:group3];
    
    
    // Todo: 加载数据模型(后台请求的数据)
    NSArray *groupNames = @[@[@"紫色",@"灰灰灰灰灰",@"蓝蓝蓝",@"黄黄",@"红红红红红红红红"],@[@"紫色",@"灰灰灰灰灰",@"蓝蓝蓝",@"黄黄",@"红红红红红红红红"],@[@"紫色",@"灰灰灰灰灰",@"蓝蓝蓝",@"黄黄",@"红红红红红红红红"]];
    //这是一个分组的模型类
    for (NSMutableArray *name in groupNames) {
        YYGroup *group1 = [[YYGroup alloc] initWithItem:name];
        [self.dataBtnTitleArr addObject:group1];
    }  
}

#pragma mark - UITableViewDataSource
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 3;
    }else{
        YYGroup *group = self.dataBtnTitleArr[section - 2];
        return group.isFolded ? 0 : 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        static NSString *CellIdentifier = @"Cell1";
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];;
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.text = self.detailArr1[row];
            cell.textLabel.text = self.titleArr[row];
        }
        return cell;
        
    }else if (section == 1) {
        NSString  * cellID = @"InputInfoCell";
        [tableView registerClass:[InputInfoCell class] forCellReuseIdentifier:cellID];
        InputInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID] ;
        
        if (!cell) {
            cell = [[InputInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell configWithExpress:@[@"单位名称", @"籍贯", @"单位地址"] withInput:@[@"请输入单位名称", @"请输入籍贯", @"请输入单位地址"] withIndex:row];
        [cell bindTarget:self openSelector:@selector(editPressWithTag:) index:row];
        return cell;
        
    }else{
        NSString  * cellID = @"SelectCell";
        SelectCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID] ;
        
        if (cell == nil) {
            cell = [[SelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        YYGroup *group = self.dataBtnTitleArr[section - 2];
        NSArray *arr=group.items;
        [cell configWithExpress:arr];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return 45;
    }else{
        return 100;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2 || section == 3 || section == 4) {
        return 45;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2 || section == 3 || section == 4) {
        UIView *sectionView=[[UIView alloc]init];
        sectionView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [sectionView addSubview:titleLabel];
        
        UILabel *selectLabel = [[UILabel alloc] init];
        selectLabel.tag = 10086 + section;
        selectLabel.textColor = [UIColor blackColor];
        selectLabel.font = [UIFont systemFontOfSize:16.0f];
        selectLabel.textAlignment = NSTextAlignmentRight;
        [sectionView addSubview:selectLabel];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [sectionView addSubview:imgView];
        
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.tag = 1200 + section;
        [selectBtn addTarget:self action:@selector(openDetailRow:) forControlEvents:UIControlEventTouchUpInside];
        [sectionView addSubview:selectBtn];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 20));
            make.left.equalTo(sectionView).offset(15);
            make.centerY.equalTo(sectionView);
        }];
        
        [selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.equalTo(titleLabel.mas_right);
            make.right.equalTo(sectionView).offset(-35);
            make.centerY.equalTo(sectionView);
        }];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.equalTo(sectionView).offset(-15);
            make.centerY.equalTo(sectionView);
        }];
        
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.left.equalTo(titleLabel);
            make.right.equalTo(sectionView);
            make.centerY.equalTo(sectionView);
        }];
        
        NSArray *titleArr=@[@"兴趣爱好", @"我的资源", @"所属行业"];
        titleLabel.text=titleArr[section-2];
        
        //根据模型里面的展开还是收起变换图片
        YYGroup *group = self.dataBtnTitleArr[section-2];
        if (group.isFolded==YES) {
            imgView.image=[UIImage imageNamed:@"import"];
        }else{
            imgView.image=[UIImage imageNamed:@""];
        }
        
        return sectionView;
        
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)changeaAatars{
    NSLog(@"oooo  touchupinside");
}

- (void)editPressWithTag:(UIButton *)sender{
    UITextField *inputTextField = [self.view viewWithTag:sender.tag + 333];
    [inputTextField becomeFirstResponder];
}

- (void)openDetailRow:(UIButton *)sender{
    YYGroup *group2 = self.dataBtnTitleArr[sender.tag - 1200 - 2];
    group2.folded = !group2.isFolded;
    [self.tableview reloadData];
}

#pragma mark - setter && getter
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
        _tableview.backgroundColor = [UIColor clearColor];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.delaysContentTouches = NO;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableview;
}

- (UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc] init];
        CGFloat width = SCREEN_WIDTH;
        CGFloat height = 100*width/275;
        _headerView.frame = CGRectMake(0, 0, width, height);
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:@"background_image"]];
        [_headerView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_headerView);
        }];
        
        [_headerView addSubview:self.avatarsView];
        [_avatarsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 84));
            make.center.equalTo(_headerView);
        }];
    }
    return _headerView;
}

- (UIView *)avatarsView{
    if (!_avatarsView) {
        _avatarsView = [[UIView alloc] init];
        
        UIImageView *avatarsImgView = [[UIImageView alloc] init];
        [avatarsImgView setImage:[UIImage imageNamed:@"head_portrait"]];
        [_avatarsView addSubview:avatarsImgView];
        [avatarsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.top.left.equalTo(_avatarsView);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"上传头像";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12.0f];
        [_avatarsView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(avatarsImgView.mas_bottom).offset(8);
            make.centerX.with.equalTo(avatarsImgView);
            make.height.equalTo(@16);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(changeaAatars) forControlEvents:UIControlEventTouchUpInside];
        [_avatarsView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 84));
            make.top.left.equalTo(avatarsImgView);
        }];
        
    }
    return _avatarsView;
}

@end
