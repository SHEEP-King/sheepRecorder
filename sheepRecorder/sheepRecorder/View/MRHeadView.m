//
//  MRHeadView.m
//  BaseProject
//
//  Created by tarena04 on 15/12/29.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "MRHeadView.h"
#import <CoreText/CoreText.h>
#import "UIImageView+KRRound.h"
#import "MRUser.h"
#import <RESideMenu.h>

#define kMRPadding 10
#define kMRHeaderImageWidth 60
#define kMRSexImageWidth 30
#define kMRSexImageHeight 15

@interface MRHeadView ()

@property(nonatomic,strong)UIImageView *headerImageView;
@property(nonatomic,strong)UILabel *nickNameLabel;
@property(nonatomic,strong)UIImageView *sexImageView;
@property(nonatomic,strong)UILabel *statuesLabel;

@end

@implementation MRHeadView

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        self.headerImageView.hidden = NO;
        self.nickNameLabel.hidden = NO;
        self.sexImageView.hidden = NO;
        self.statuesLabel.hidden = NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeaderView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}



#pragma mark - 懒加载模式创建view视图

- (UIImageView *)headerImageView {
	if(_headerImageView == nil) {
		_headerImageView = [[UIImageView alloc] init];
        _headerImageView.image = [UIImage imageNamed:@"HeadPlaceHolder"];
        //圆形头像
        [_headerImageView setRoundLayer:0.5 * kMRHeaderImageWidth];
        [self addSubview:_headerImageView];
        [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(kMRPadding);
            make.size.mas_equalTo(CGSizeMake(kMRHeaderImageWidth, kMRHeaderImageWidth));
        }];
        
	}
	return _headerImageView;
}

- (UILabel *)nickNameLabel {
	if(_nickNameLabel == nil) {
		_nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.text = @"未登录";
       // _nickNameLabel.textColor = [UIColor grayColor];
        
        [self addSubview:_nickNameLabel];
        
        [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerImageView.mas_right).mas_equalTo(kMRPadding);
            make.top.mas_equalTo(2 * kMRPadding);
            make.right.mas_equalTo(self.sexImageView.mas_left).mas_equalTo(kMRPadding);
        }];
        
	}
	return _nickNameLabel;
}

- (UIImageView *)sexImageView {
	if(_sexImageView == nil) {
		_sexImageView = [[UIImageView alloc] init];
        _sexImageView.image = [UIImage imageNamed:@"icon_boy"];
        [self addSubview:_sexImageView];
        [_sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kMRSexImageWidth, kMRSexImageHeight));
            make.top.mas_equalTo(2 * kMRPadding);
            make.right.mas_equalTo(-kMRPadding);
        }];
        
	}
	return _sexImageView;
}

- (UILabel *)statuesLabel {
	if(_statuesLabel == nil) {
		_statuesLabel = [[UILabel alloc] init];
        _statuesLabel.text = @"我的状态";
        _statuesLabel.textColor = [UIColor grayColor];
        _statuesLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_statuesLabel];
        
        [_statuesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerImageView.mas_bottom).mas_equalTo(kMRPadding);
            make.left.mas_equalTo(kMRPadding);
            make.right.mas_equalTo(kMRPadding);
            //make.bottom.mas_greaterThanOrEqualTo(kMRPadding);
        }];
	}
	return _statuesLabel;
}

- (void)tapHeaderView
{
    if ([MRUser sharedMRUser].isOnline) {
        //进入个人状态主页;
        NSLog(@"进入个人状态主页%s",__func__);
    }else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"login" bundle:nil];
        
       RESideMenu *menuController = (RESideMenu *)[UIApplication sharedApplication].keyWindow.rootViewController;
        
        [menuController.leftMenuViewController presentViewController:storyboard.instantiateInitialViewController animated:YES completion:nil];
    }
}


#pragma mark - 外部赋值
- (void)setHeaderModel:(MRheaderModel *)headerModel
{
    _headerModel = headerModel;
    self.nickNameLabel.text = _headerModel == nil ? @"未登录" : _headerModel.userName;
    self.statuesLabel.text = _headerModel == nil ? @"今日心情" : _headerModel.status;
    self.sexImageView.image = [UIImage imageNamed:_headerModel.userSex == 0?@"icon_girl":@"icon_boy"];
    self.headerImageView.image = [UIImage imageNamed:_headerModel == nil ?@"HeadPlaceHolder":_headerModel.headerImageStr];
    
}

@end
