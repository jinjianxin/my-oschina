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
#import "ReportViewControl.h"
#import "PostDetails.h"
#import "SoftDetail.h"

@interface Helper : NSObject

+ (void)pushNewsDetail:(UINavigationController *)navigationController andMag:(MsgDetail *)msg andCategory:(int) category;

+ (void)analysisDetail:(NSString *)url andNav:(UINavigationController *)navigationController;

+ (void)pushNews:(UINavigationController *)navigationController andIds:(NSString *)ids andCategory:(int)category;

+ (void)pushQuestion:(UINavigationController *)navigationController andIds:(NSString*)ids andCategory:(int)category;

+ (void)pushSoft:(UINavigationController *)navigationController andIds:(NSString*)ids andCategory:(int)category;

+ (NSString *)getUid;
@end
