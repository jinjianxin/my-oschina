//
//  MsgDetail.m
//  my-oschina
//
//  Created by jjx on 14/10/29.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "MsgDetail.h"

@implementation MsgDetail

@synthesize m_titile;
@synthesize m_author;
@synthesize m_ids;
@synthesize m_pullDate;
@synthesize m_url;
/*
@synthesize m_favorite;
@synthesize m_newType;
@synthesize m_attachMent;*/

- (id)initwithContent:(NSString*)_titile author:(NSString*)_author ids:(NSString*)_ids pullDate:(NSString*)_pullDate
{
    MsgDetail* msg = [[MsgDetail alloc] init];

    msg.m_titile = _titile;
    msg.m_author = _author;
    msg.m_ids = _ids;
    msg.m_pullDate = _pullDate;
  

    return msg;
}

- (id) initwithBlog:(NSString *)_titile author:(NSString *)_author ids:(NSString *)_ids pullDate:(NSString *)_pullDate url:(NSString *)_url
{
    MsgDetail *msg = [[MsgDetail alloc] init];
    
    msg.m_titile = _titile;
    msg.m_author = _author;
    msg.m_ids = _ids;
    msg.m_pullDate = _pullDate;
    msg.m_url = _url;
    
    return msg;
}


@end
