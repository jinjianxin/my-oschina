//
//  SingleNews.m
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "SingleNews.h"

@implementation SingleNews

@synthesize m_id;
@synthesize m_title;
@synthesize m_url;
@synthesize m_body;
@synthesize m_author;
@synthesize m_authorid;
@synthesize m_pubDate;
@synthesize m_commentCount;
@synthesize m_relativies;
@synthesize m_softwarelink;
@synthesize m_softwarename;
@synthesize m_favorite;

- (id) initWithContent:(int)nid andtitle:(NSString *)ntitle andurl:(NSString *)nurl andbody:(NSString *)nbody andauthor:(NSString *)nauthor andauthorid:(int)nauthorid andpubDate:(NSString *)npubDate andcommentCount:(int)ncommentCount andfavorite:(BOOL)nfavorite
{
    SingleNews *news = [[SingleNews alloc] init];
    
    news.m_id = nid;
    news.m_title = ntitle;
    news.m_url = nurl;
    news.m_body = nbody;
    news.m_author = nauthor;
    news.m_authorid = nauthorid;
    news.m_pubDate = npubDate;
    news.m_commentCount = ncommentCount;
    news.m_favorite = nfavorite;
    return news;

}

@end


@implementation RelativeNews

@synthesize m_title;
@synthesize m_url;

- (id) initWithContent:(NSString *)ntitle andUrl:(NSString *)nurl
{
    RelativeNews *msg = [[RelativeNews alloc] init];
    
    msg.m_title = ntitle;
    msg.m_url = nurl;
    
    return msg;
}


@end