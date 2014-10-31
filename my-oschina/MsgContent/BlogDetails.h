//
//  BlogDetails.h
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogDetails : NSObject

@property int _id;
@property (copy,nonatomic) NSString * title;
@property (copy,nonatomic) NSString * where;
@property (copy,nonatomic) NSString * body;
@property (copy,nonatomic) NSString * author;
@property int authorid;
@property int documentType;
@property (copy,nonatomic) NSString * pubDate;
@property BOOL favorite;
@property (copy,nonatomic) NSString * url;
@property int commentCount;

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
         andCommentCount:(int)ncommentCount;



@end
