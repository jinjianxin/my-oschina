//
//  ResultMsg.m
//  my-oschina
//
//  Created by jjx on 14/11/14.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "ResultMsg.h"

@implementation ResultMsg

@synthesize m_id;
@synthesize m_type;
@synthesize m_title;
@synthesize m_url;
@synthesize m_author;

- (id) initContent:(NSString *)nId andType:(NSString *)nType andTitle:(NSString *)nTitle andUrl:(NSString *)nUrl andAuthor:(NSString *)nAuthor
{
    ResultMsg *msg = [[ResultMsg alloc] init];
    msg.m_id = nId;
    msg.m_type = nType;
    msg.m_title = nTitle;
    msg.m_url = nUrl;
    msg.m_author =nAuthor;
    
    return msg;
}

@end
