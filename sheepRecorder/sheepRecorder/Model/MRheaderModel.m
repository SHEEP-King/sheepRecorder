//
//  MRheaderModel.m
//  BaseProject
//
//  Created by tarena04 on 16/1/4.
//  Copyright © 2016年 sheep. All rights reserved.
//

#import "MRheaderModel.h"
#import "MRUser.h"

@implementation MRheaderModel

ZXSingletonM(MRheaderModel)

- (MRheaderModel *)currentUserHeaderView
{
    if ([MRUser sharedMRUser].isOnline) {
        self.userName = [MRUser sharedMRUser].userName;
        self.userSex = [MRUser sharedMRUser].userSex;
        self.userAge = [MRUser sharedMRUser].userAge;
        self.status = [MRUser sharedMRUser].status;
        self.headerImageStr = @"";
        return self;
    }
    return nil;
}

@end
