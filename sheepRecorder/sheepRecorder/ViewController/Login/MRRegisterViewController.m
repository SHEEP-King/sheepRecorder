//
//  MRRegisterViewController.m
//  BaseProject
//
//  Created by tarena04 on 15/12/30.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "MRRegisterViewController.h"
#import "MRUser.h"
#import "MRXMPPTool.h"
#import "MRAFNetTool.h"

@interface MRRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIView *registView;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;


@end

@implementation MRRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setRegistTextFieldStyle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRegistTextFieldStyle
{
    // 设置登陆框的样式
    UIImage *imageN = [UIImage imageNamed:@"icon"];
    UIImageView *leftVN = [[UIImageView alloc]initWithImage:imageN];
    leftVN.contentMode = UIViewContentModeCenter;
    leftVN.frame = CGRectMake(0, 0, 55, 20);
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.userNameTextField.leftView = leftVN;
    UIImage *imageP = [UIImage imageNamed:@"lock"];
    UIImageView *leftVP = [[UIImageView alloc]initWithImage:imageP];
    leftVP.contentMode = UIViewContentModeCenter;
    leftVP.frame = CGRectMake(0, 0, 55, 20);
    self.passwordTextFeild.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextFeild.leftView = leftVP;
    
    //设置loginView圆角
    [self.registView setRoundLayer:2];

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
    //获取登录信息
    [MRUser  sharedMRUser].userName = self.userNameTextField.text;
    [MRUser  sharedMRUser].userPassword = self.userNameTextField.text;
    [MRUser  sharedMRUser].registType = MRUserRegistTypeOfLocal;
    
    __weak typeof(self) weakSelf = self;
    
    [[MRXMPPTool  sharedMRXMPPTool] userRegister:^(MRXMPPResultType type) {
        [weakSelf handleXMPPResultType:type];
    }];
    
}


- (void) handleXMPPResultType:(MRXMPPResultType) type
{
    switch (type) {
            
        case MRXMPPResultTypeNetError:
            [self  showAlert:@"网路错误"];
            break;
        case MRXMPPResultTypeRegisterSuccess:
            [self showAlert:@"注册成功"];
            [self registerUserForWebServer];
            //回到登录界面
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case MRXMPPResultTypeRegisterFailure:
            [self showAlert:@"注册失败"];
            //回到登录界面
             [self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}

- (void)registerUserForWebServer
{
    NSMutableDictionary *parameters = [ NSMutableDictionary dictionary];

    MRUser * user = [MRUser sharedMRUser];
    parameters[@"username"] = user.userName;
    parameters[@"md5password"] = user.userPassword;
    parameters[@"nickname"] = user.userName;
    parameters[@"gender"] = @"1";
    parameters[@"mobile"] = @"15811001234";

    [MRAFNetTool POSTWithParameters:parameters withimageName:@"HeadPlaceHolder" completionHandle:^(id task, id operation, NSError *error) {
        if (error) {
            NSLog(@"web register failed:%@",error);
        }else
        {
            NSLog(@"web register success:%@",error);
        }
        
        
    }];
}

@end
