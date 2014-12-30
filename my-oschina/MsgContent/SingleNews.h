//
//  SingleNews.h
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleNews : NSObject

@property int m_id;
@property (copy,nonatomic) NSString *m_title;
@property (copy,nonatomic) NSString *m_url;
@property (copy,nonatomic) NSString *m_body;
@property (copy,nonatomic) NSString *m_author;
@property int m_authorid;
@property (copy,nonatomic) NSString *m_pubDate;
@property int m_commentCount;
@property (retain,nonatomic) NSArray *m_relativies;
@property (copy,nonatomic) NSString *m_softwarelink;
@property (copy,nonatomic) NSString *m_softwarename;
@property BOOL m_favorite;

- (id) initWithContent:(int)nid andtitle:(NSString *)ntitle andurl:(NSString *)nurl andbody:(NSString *)nbody andauthor:(NSString *)nauthor andauthorid:(int) nauthorid  andpubDate:(NSString*)npubDate andcommentCount:(int) ncommentCount andfavorite:(BOOL) nfavorite;

@end


@interface RelativeNews : NSObject

@property (copy,nonatomic) NSString *m_title;
@property (copy,nonatomic) NSString *m_url;

- (id) initWithContent:(NSString *)ntitle andUrl:(NSString *)nurl;

@end