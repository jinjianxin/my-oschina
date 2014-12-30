//
//  QuestionMsg.m
//  my-oschina
//
//  Created by jjx on 14/11/4.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "QuestionMsg.h"

@implementation QuestionMsg

@synthesize m_ids;
@synthesize m_portrait;
@synthesize m_author;
@synthesize m_authorid ;
@synthesize m_title;
@synthesize m_answerCount ;
@synthesize m_viewCount ;
@synthesize m_pubDate ;
@synthesize m_name ;

- (id) initWithContent:(NSString *)andIds andPortrait:(NSString *)nPortrait andAuthor:(NSString *)nAuthor andAuthorid:(NSString *)nAuthorid andTitle:(NSString *)nTitle andAnswerCount:(NSString *)nAnswerCount andViewCount:(NSString *)nViewCount andPubDate:(NSString *)nPubDate andName:(NSString *)nName
{
    QuestionMsg *msg = [[QuestionMsg alloc] init];
    
    msg.m_ids = andIds;
    msg.m_portrait = nPortrait;
    msg.m_author = nAuthor;
    msg.m_authorid = nAuthorid;
    msg.m_title = nTitle;
    msg.m_answerCount = nAnswerCount;
    msg.m_viewCount=nViewCount;
    msg.m_pubDate = nPubDate;
    msg.m_name = nName;
    
    return msg;
}

@end
