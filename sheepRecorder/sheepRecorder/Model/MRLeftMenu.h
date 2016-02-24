//
//  MRLeftMenu.h
//  BaseProject
//
//  Created by tarena04 on 15/12/28.
//  Copyright © 2015年 sheep. All rights reserved.
//

#import "BaseModel.h"

@interface MRLeftMenu : BaseModel

ZXSingletonH(MRLeftMenu)

- (NSArray *)menuList;

@end
