//
//  BlogDetails.h
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogDetails : NSObject

@property int m_id;
@property (copy,nonatomic) NSString *m_title;
@property (copy,nonatomic) NSString *m_where;
@property (copy,nonatomic) NSString *m_body;
@property (copy,nonatomic) NSString *m_author;
@property int m_authorid;
@property int m_documentType;
@property (copy,nonatomic) NSString *m_pubDate;
@property BOOL m_favorite;
@property (copy,nonatomic) NSString *m_url;
@property int m_commentCount;

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
