//
//  MRheaderModel.h
//  BaseProject
//
//  Created by tarena04 on 16/1/4.
//  Copyright © 2016年 sheep. All rights reserved.
//

#import "BaseModel.h"

@interface MRheaderModel : BaseModel

ZXSingletonH(MRheaderModel)

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,assign)NSUInteger userSex;
@property(nonatomic,strong)NSNumber *userAge;
@property(nonatomic,assign)NSString *status;
@property(nonatomic,assign)NSString *headerImageStr;

- (MRheaderModel *)currentUserHeaderView;

@end
