//
//  MsgDetail.m
//  my-oschina
//
//  Created by jjx on 14/10/29.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "MsgDetail.h"

@implementation MsgDetail

@synthesize titile;
@synthesize author;
@synthesize ids;
@synthesize pullDate;
@synthesize url;

- (id) initwithContent:(NSString *)_titile author:(NSString *)_author ids:(NSString *)_ids pullDate:(NSString *)_pullDate
{
    MsgDetail *msg = [[MsgDetail alloc] init];
    
    msg.titile =_titile;
    msg.author = _author;
    msg.ids = _ids;
    msg.pullDate = _pullDate;
    
    return msg;
}

- (id) initwithBlog:(NSString *)_titile author:(NSString *)_author ids:(NSString *)_ids pullDate:(NSString *)_pullDate url:(NSString *)_url
{
    MsgDetail *msg = [[MsgDetail alloc] init];
    
    msg.titile = _titile;
    msg.author = _author;
    msg.ids = _ids;
    msg.pullDate = _pullDate;
    msg.url = _url;
    
    return msg;
}


@end
