//
//  Constants.h
//  BaseProject
//
//  Created by tarena04 on 15/12/16.
//  Copyright © 2015年 sheep. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kAppDocumentsDomain NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]

#define kMediaFolderName       @"/mediaFile"
#define kMediaFileDirectory    [kAppDocumentsDomain stringByAppendingPathComponent:kMediaFolderName]

#define kThumbnailFolderName   @"/thumbnail" //sandbox
#define kThumbnailDirectory    [kAppDocumentsDomain stringByAppendingPathComponent:kThumbnailFolderName]

#define kTempFolderName   @"/temp"
#define kTempDirectory    [kAppDocumentsDomain stringByAppendingPathComponent:kTempFolderName]


#endif /* Constants_h */
