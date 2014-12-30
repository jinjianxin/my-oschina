//
//  QuestionMsg.h
//  my-oschina
//
//  Created by jjx on 14/11/4.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionMsg : NSObject

@property (strong,nonatomic) NSString *m_ids;
@property (strong,nonatomic) NSString *m_portrait;
@property (strong,nonatomic) NSString *m_author;
@property (strong,nonatomic) NSString *m_authorid ;
@property (strong,nonatomic) NSString *m_title;
@property (strong,nonatomic) NSString *m_answerCount ;
@property (strong,nonatomic) NSString *m_viewCount ;
@property (strong,nonatomic) NSString *m_pubDate ;
@property (strong,nonatomic) NSString *m_name ;

- (id) initWithContent:(NSString*)andIds andPortrait:(NSString *)nPortrait andAuthor:(NSString *)nAuthor andAuthorid:(NSString*)nAuthorid andTitle:(NSString*)nTitle andAnswerCount:(NSString*)nAnswerCount  andViewCount:(NSString*) nViewCount andPubDate:(NSString*)nPubDate andName:(NSString*)nName;

@end
