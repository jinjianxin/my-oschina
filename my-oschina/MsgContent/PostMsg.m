//
//  PostMsg.m
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "PostMsg.h"

@implementation PostMsg


@synthesize ids;
@synthesize title;
@synthesize url;
@synthesize portrait;
@synthesize body;
@synthesize author;
@synthesize authorid;
@synthesize answerCount;
@synthesize viewCount;
@synthesize pubDate;
@synthesize favorite;
@synthesize tagArray;

-(id) initWithContent:(NSString *)newid andTitle:(NSString *)ntitle andUrl:(NSString *)nUrl andPortrait:(NSString *)nportrait andBody:(NSString *)nbody andAuthor:(NSString *)nauthor andAuthorID:(NSString *)nauthorid andAnswer:(NSString *)nanswerCount andView:(NSString *)nviewCount andPubDate:(NSString *)nPubDate andFavorite:(NSString *)nfavorite andTags:(NSMutableArray *)_tags
{
    PostMsg *msg = [[PostMsg alloc] init];
    msg.ids = newid;
    msg.title = ntitle;
    msg.url= nUrl;
    msg.portrait = nportrait;
    msg.body = nbody;
    msg.author =nauthor;
    msg.authorid = nauthorid;
    msg.answerCount = nanswerCount;
    msg.viewCount = nviewCount;
    msg.pubDate =nPubDate;
    msg.favorite = nfavorite;
    msg.tagArray = _tags;
    
    
    return msg;
}

@end
