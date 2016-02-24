//
//  MRLeftViewController.m
//  BaseProject
//
//  Created by tarena04 on 15/12/24.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "MRLeftViewController.h"
#import "MRLeftMenu.h"
#import "MRHeadView.h"
#import "MRheaderModel.h"

@interface MRLeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)MRHeadView *headView;
@property(nonatomic,strong)NSArray *menuArray;

@end

@implementation MRLeftViewController

#pragma mark - 懒加载模式

- (UIView *)headView {
    if(_headView == nil) {
        _headView = [[MRHeadView alloc] init];
        //_headView.backgroundColor = [UIColor yellowColor];
        
        [self.view addSubview:_headView];
        
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.left.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(200, 120));
        }];
    }
    return _headView;
}

//懒加载模式 创建 tableView对象
- (UITableView *)leftTableView {
    if(_leftTableView == nil) {
        _leftTableView = [[UITableView alloc] init];
        
        [self.view addSubview:_leftTableView];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headView.mas_bottom).mas_equalTo(0);
            make.left.mas_equalTo(20);
            make.bottom.right.mas_equalTo(-100);
        }];
        
    }
    return _leftTableView;
}

- (NSArray *)menuArray {
    if(_menuArray == nil) {
        _menuArray = [[MRLeftMenu sharedMRLeftMenu] menuList];
    }
    return _menuArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.leftTableView.hidden = NO;
    
    //判断是否为登录状态,登录状态-更新headerView,非登录状态清空headerView
    self.headView.headerModel = [MRheaderModel sharedMRheaderModel].currentUserHeaderView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }
    //cell.textLabel.text = self.menuArray[indexPath.row];
    NSLog(@"cellforIndex");
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell.textLabel.text = self.menuArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    NSLog(@"cell will display");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //展示对应ViewController
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


@end
