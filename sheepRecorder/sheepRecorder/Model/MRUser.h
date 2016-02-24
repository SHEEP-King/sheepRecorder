//
//  MRUser.h
//  BaseProject
//
//  Created by tarena04 on 15/12/30.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "BaseModel.h"

typedef enum{
    
    MRUserRegistTypeOfNone,//不是注册类型
    
    MRUserRegistTypeOfLocal,//本地注册
    
    MRUserRegistTypeOfSina,//新浪注册
    
    MRUserRegistTypeOfWeiChat,//微信注册
    
    MRUserRegistTypeOfQQ, //QQ注册
    
    MRUserRegistTypeOfRenren
    
} MRUserRegistType;


@interface MRUser : BaseModel

ZXSingletonH(MRUser)

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userPassword;
@property(nonatomic,strong)NSString *jid;
@property(nonatomic,assign)NSUInteger userSex;
@property(nonatomic,strong)NSString *userAddress;
@property(nonatomic,strong)NSNumber *userAge;

@property(nonatomic,assign)BOOL isRegist;
@property(nonatomic,assign)MRUserRegistType registType;

//是否是在线状态
@property(nonatomic,assign)BOOL isOnline;

@property(nonatomic,assign)NSString *status;

/* 用户数据的沙盒读写 */
- (void) saveKRUserInfoToSandBox;
- (void) loadKRUserInfoFromSandBox;

@end
