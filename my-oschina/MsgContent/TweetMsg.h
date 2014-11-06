//
//  TweetMsg.h
//  my-oschina
//
//  Created by jjx on 14/11/6.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TweetMsg : NSObject

@property (copy,nonatomic) NSString *m_id;
@property (copy,nonatomic) NSString *m_portrait;
@property (copy,nonatomic) NSString *m_author;
@property (copy,nonatomic) NSString *m_authorid;
@property (copy,nonatomic) NSString *m_body;
@property (copy,nonatomic) NSString *m_appclient;
@property (copy,nonatomic) NSString *m_commentCount;
@property (copy,nonatomic) NSString *m_pubDate;
@property int m_height;

- (id)initWithContent:(NSString *)andId andPortrait:(NSString *)nPortrait andAuthor:(NSString *)nAuthor andAuthorid:(NSString *)nAuthorid andBody:(NSString *)nBody andAppclient:(NSString*)nAppclient andCommentCount:(NSString*)nCommentCount andPullDate:(NSString *) npubDate;


@end
