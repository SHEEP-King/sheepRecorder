//
//  MRLoginViewController.m
//  BaseProject
//
//  Created by tarena04 on 15/12/30.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "MRLoginViewController.h"
#import "MRUser.h"
#import "MRXMPPTool.h"

@interface MRLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passTextField;


@end

@implementation MRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置登陆框的样式
    [self setloginTextFieldStyle];
}

- (void)setloginTextFieldStyle
{
    // 设置登陆框的样式
    UIImage *imageN = [UIImage imageNamed:@"icon"];
    UIImageView *leftVN = [[UIImageView alloc]initWithImage:imageN];
    leftVN.contentMode = UIViewContentModeCenter;
    leftVN.frame = CGRectMake(0, 0, 55, 20);
    self.nameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.nameTextField.leftView = leftVN;
    UIImage *imageP = [UIImage imageNamed:@"lock"];
    UIImageView *leftVP = [[UIImageView alloc]initWithImage:imageP];
    leftVP.contentMode = UIViewContentModeCenter;
    leftVP.frame = CGRectMake(0, 0, 55, 20);
    self.passTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passTextField.leftView = leftVP;
    
    //设置loginView圆角
    [self.loginView setRoundLayer:2];
    
    //设置圆形头像
    [self.headImageView setRoundLayer];
    
    //设置文本框内容
    if ([MRUser sharedMRUser].userName) {
        self.nameTextField.text = [MRUser sharedMRUser].userName;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)registerButton:(UIButton *)sender {
//跳转到注册界面
}

- (IBAction)loginButton:(UIButton *)sender {
    
    //获取登录信息
    [MRUser  sharedMRUser].userName = self.nameTextField.text;
    [MRUser  sharedMRUser].userPassword = self.passTextField.text;
    [MRUser  sharedMRUser].registType = MRUserRegistTypeOfNone;
    
    __weak typeof(self) weakSelf = self;
    
    [[MRXMPPTool  sharedMRXMPPTool] userLogin:^(MRXMPPResultType type) {
        [weakSelf handleResultType:type];
    }];

    
}

- (IBAction)weChatRegisterbutton:(UIButton *)sender {
    [MRUser sharedMRUser].registType = MRUserRegistTypeOfWeiChat;
}

- (IBAction)sinaRegisterButton:(UIButton *)sender {
    [MRUser sharedMRUser].registType = MRUserRegistTypeOfSina;
}

- (IBAction)renrenRegisterButton:(UIButton *)sender {
    [MRUser sharedMRUser].registType = MRUserRegistTypeOfRenren;
}

- (IBAction)backToMainView:(UIBarButtonItem *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) handleResultType:(MRXMPPResultType) type
{
    switch (type) {
        case MRXMPPResultTypeNetError:
            [self showAlert:@"网路错误"];
            break;
        case MRXMPPResultTypeLoginFailed:
            [self showAlert:@"登录失败"];
            break;
        case MRXMPPResultTypeLoginSuccess:
        {
            [self showAlert:@"登录成功"];
            [MRUser sharedMRUser].isOnline = YES;
            // 切换到主界面
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            break;
        }
        default:
            break;
    }
}


@end
