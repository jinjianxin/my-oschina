//
//  BlogDetails.m
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "BlogDetails.h"

@implementation BlogDetails

@synthesize m_id;
@synthesize m_title;
@synthesize m_where;
@synthesize m_body;
@synthesize m_author;
@synthesize m_authorid;
@synthesize m_documentType;
@synthesize m_pubDate;
@synthesize m_favorite;
@synthesize m_url;
@synthesize m_commentCount;

- (id)initWithParameters:(int)nid
                andTitle:(NSString *)ntitle
                andWhere:(NSString *)nwhere
                 andBody:(NSString *)nbody
               andAuthor:(NSString *)nauthor
             andAuthorid:(int)nauthorid
         andDocumentType:(int)nDocumentType
              andPubDate:(NSString *)nPubDate
             andFavorite:(BOOL)nfavorite
                  andUrl:(NSString *)nurl
         andCommentCount:(int)ncommentCount
{
    BlogDetails * b = [[BlogDetails alloc] init];
    b.m_id = nid;
    b.m_title = ntitle;
    b.m_where = nwhere;
    b.m_body = nbody;
    b.m_author = nauthor;
    b.m_authorid = nauthorid;
    b.m_documentType = nDocumentType;
    b.m_pubDate = nPubDate;
    b.m_favorite = nfavorite;
    b.m_url = nurl;
    b.m_commentCount = ncommentCount;
    return b;
}


@end
