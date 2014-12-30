//
//  CommentDetails.h
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CommentMsgDetails : NSObject

@property (nonatomic,copy) NSString *m_id;
@property (nonatomic,copy) NSString *m_portrait;
@property (nonatomic,copy) NSString *m_author;
@property (nonatomic,copy) NSString *m_authorid;
@property (nonatomic,copy) NSString *m_content;
@property (nonatomic,copy) NSString *m_pubDate;
@property (nonatomic,copy) NSString *m_appClient;
@property (nonatomic,copy) NSString *m_refers;
@property (nonatomic,strong) NSArray *m_refrenceArray;
@property float m_height;


- (id) initWithContent:(NSString *) nId andPortrait:(NSString *)nPortrait andAuthor:(NSString *)nAuthor andAuthorid:(NSString *)nauthorId andContent:(NSString *)nContent andPubDate:(NSString *)npubDate andAppClent:(NSString *)nAppClent andRefers:(NSString*)nRefers;

/**
 *  根据回复的内容计算高度
 */
- (void) calculateHeight;


@end


@interface ReferenceMsg : NSObject

@property (nonatomic,copy) NSString *m_referbody;
@property (nonatomic,copy) NSString *m_refertitle;

- (id) initWithContent:(NSString*) nreferbody andrefertitle:(NSString *)nrefertitle;


@end