//
//  CommentDetails.m
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "CommentMsgDetails.h"

@implementation CommentMsgDetails

@synthesize  cId;
@synthesize  cPortrait;
@synthesize  cAuthor;
@synthesize  cAuthorid;
@synthesize  cContent;
@synthesize  cPubDate;
@synthesize  cAppClient;
@synthesize  cRefers;
@synthesize refrenceArray;


- (id) initWithContent:(NSString *)nId andPortrait:(NSString *)nPortrait andAuthor:(NSString *)nAuthor andAuthorid:(NSString *)nauthorId andContent:(NSString *)nContent andPubDate:(NSString *)npubDate andAppClent:(NSString *)nAppClent andRefers:(NSString *)nRefers
{
    CommentMsgDetails *news = [[CommentMsgDetails alloc] init];
    
    news.cId = nId;
    news.cPortrait = nPortrait;
    news.cAuthor = nAuthor;
    news.cAuthorid = nauthorId;
    news.cContent = nContent;
    news.cPortrait = npubDate;
    news.cAppClient = nAppClent;
    news.cRefers = nRefers;
    
    
    return news;
}

@end

@implementation ReferenceMsg

@synthesize referbody;
@synthesize refertitle;

- (id) initWithContent:(NSString *)nreferbody andrefertitle:(NSString *)nrefertitle
{
    ReferenceMsg *news = [[ReferenceMsg alloc] init];
    
    news.referbody =  nreferbody;
    news.refertitle = nrefertitle;
    
    return  news;
}

@end
