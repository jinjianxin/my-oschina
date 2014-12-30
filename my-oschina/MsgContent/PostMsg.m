//
//  PostMsg.m
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "PostMsg.h"

@implementation PostMsg


@synthesize m_ids;
@synthesize m_title;
@synthesize m_url;
@synthesize m_portrait;
@synthesize m_body;
@synthesize m_author;
@synthesize m_authorid;
@synthesize m_answerCount;
@synthesize m_viewCount;
@synthesize m_pubDate;
@synthesize m_favorite;
@synthesize m_tagArray;

-(id) initWithContent:(NSString *)newid andTitle:(NSString *)ntitle andUrl:(NSString *)nUrl andPortrait:(NSString *)nportrait andBody:(NSString *)nbody andAuthor:(NSString *)nauthor andAuthorID:(NSString *)nauthorid andAnswer:(NSString *)nanswerCount andView:(NSString *)nviewCount andPubDate:(NSString *)nPubDate andFavorite:(NSString *)nfavorite andTags:(NSMutableArray *)_tags
{
    PostMsg *msg = [[PostMsg alloc] init];
    msg.m_ids = newid;
    msg.m_title = ntitle;
    msg.m_url= nUrl;
    msg.m_portrait = nportrait;
    msg.m_body = nbody;
    msg.m_author =nauthor;
    msg.m_authorid = nauthorid;
    msg.m_answerCount = nanswerCount;
    msg.m_viewCount = nviewCount;
    msg.m_pubDate =nPubDate;
    msg.m_favorite = nfavorite;
    msg.m_tagArray = _tags;
    
    
    return msg;
}

@end
