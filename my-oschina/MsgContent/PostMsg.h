//
//  PostMsg.h
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostMsg : NSObject

@property(strong, nonatomic) NSString *ids;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *url;
@property(strong, nonatomic) NSString *portrait;
@property(strong, nonatomic) NSString *body;
@property(strong, nonatomic) NSString *author;
@property(strong, nonatomic) NSString *authorid;
@property(strong, nonatomic) NSString *answerCount;
@property(strong, nonatomic) NSString *viewCount;
@property(strong, nonatomic) NSString *pubDate;
@property(strong, nonatomic) NSString *favorite;
@property(strong, nonatomic) NSMutableArray *tagArray;

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
