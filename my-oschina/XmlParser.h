//
//  XmlParser.h
//  my-oschina
//
//  Created by jjx on 14/10/29.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "SingleNews.h"
#import "BlogDetails.h"
#import "CommentMsgDetails.h"
#import "QuestionMsg.h"
#import "PostMsg.h"
#import "TweetMsg.h"
#import "UserData.h"
#import "OwnMsg.h"
#import "ResultMsg.h"

@interface XmlParser : NSObject

+ (NSMutableArray *) newsParser:(NSString *) response;
+ (NSMutableArray *)blogParser:(NSString *) response;
+ (SingleNews *) singleNewParser:(NSString *)response;

+ (NSString *)intervalSinceNow: (NSString *) theDate;

+ (NSString *)generateRelativeNewsString:(NSArray *)array;

+ (BlogDetails*) blogDetailParser:(NSString *)response;

+ (NSMutableArray*) commentsDetailParser:(NSString *)response;

+ (NSMutableArray*) questionNewParser:(NSString *)response;

+ (PostMsg *) postNewParser:(NSString *)response;

+ (NSMutableArray *)tweetNewParser:(NSString *)response;

+ (UserData *) loginParser:(NSString *)response;

+ (NSMutableArray *) ownNewParser:(NSString*)response;

+ (NSMutableArray *) searchResultParser:(NSString*)response;

@end
