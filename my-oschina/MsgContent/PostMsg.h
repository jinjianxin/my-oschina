//
//  PostMsg.h
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostMsg : NSObject

@property(strong, nonatomic) NSString *m_ids;
@property(strong, nonatomic) NSString *m_title;
@property(strong, nonatomic) NSString *m_url;
@property(strong, nonatomic) NSString *m_portrait;
@property(strong, nonatomic) NSString *m_body;
@property(strong, nonatomic) NSString *m_author;
@property(strong, nonatomic) NSString *m_authorid;
@property(strong, nonatomic) NSString *m_answerCount;
@property(strong, nonatomic) NSString *m_viewCount;
@property(strong, nonatomic) NSString *m_pubDate;
@property(strong, nonatomic) NSString *m_favorite;
@property(strong, nonatomic) NSMutableArray *m_tagArray;

- (id)initWithContent:(NSString *)newid
             andTitle:(NSString *)ntitle
               andUrl:(NSString *)nUrl
          andPortrait:(NSString *)nportrait
              andBody:(NSString *)nbody
            andAuthor:(NSString *)nauthor
          andAuthorID:(NSString *)nauthorid
            andAnswer:(NSString *)nanswerCount
              andView:(NSString *)nviewCount
           andPubDate:(NSString *)nPubDate
          andFavorite:(NSString *)nfavorite
              andTags:(NSMutableArray *)_tags;

@end
