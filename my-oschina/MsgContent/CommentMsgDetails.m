//
//  CommentDetails.m
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "CommentMsgDetails.h"

@implementation CommentMsgDetails

@synthesize  m_id;
@synthesize  m_portrait;
@synthesize  m_author;
@synthesize  m_authorid;
@synthesize  m_content;
@synthesize  m_pubDate;
@synthesize  m_appClient;
@synthesize  m_refers;
@synthesize m_refrenceArray;
@synthesize m_height;


- (id) initWithContent:(NSString *)nId andPortrait:(NSString *)nPortrait andAuthor:(NSString *)nAuthor andAuthorid:(NSString *)nauthorId andContent:(NSString *)nContent andPubDate:(NSString *)npubDate andAppClent:(NSString *)nAppClent andRefers:(NSString *)nRefers
{
    CommentMsgDetails *news = [[CommentMsgDetails alloc] init];
    
    news.m_id = nId;
    news.m_portrait = nPortrait;
    news.m_author = nAuthor;
    news.m_authorid = nauthorId;
    news.m_content = nContent;
    news.m_pubDate= npubDate;
    news.m_appClient = nAppClent;
    news.m_refers = nRefers;

    
    
    return news;
}

- (void) calculateHeight
{
    if (self.m_refrenceArray>0) {
        m_height =62+40*[self.m_refrenceArray count];
    }
    else{
        m_height = 62;
    }
}

@end

@implementation ReferenceMsg

@synthesize m_referbody;
@synthesize m_refertitle;

- (id) initWithContent:(NSString *)nreferbody andrefertitle:(NSString *)nrefertitle
{
    ReferenceMsg *news = [[ReferenceMsg alloc] init];
    
    news.m_referbody =  nreferbody;
    news.m_refertitle = nrefertitle;
    
    return  news;
}

@end
