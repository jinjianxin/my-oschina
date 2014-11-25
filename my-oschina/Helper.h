//
//  Helper.h
//  my-oschina
//
//  Created by jjx on 14/11/17.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MsgDetail.h"
#import "MyUITabBarControl.h"
#import "NewDetail.h"
#import "CommentsDetail.h"
#import "ShareDetail.h"
#import "BlogDetail.h"
#import "SoftDetail.h"
#import "TweetViewControl.h"

@interface Helper : NSObject

+ (void)pushNewsDetail:(UINavigationController *)navigationController andMag:(MsgDetail *)msg andCategory:(int) category;

+ (NSString *)getUid;
@end
