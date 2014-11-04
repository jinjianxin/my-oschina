//
//  QuestionMsg.h
//  my-oschina
//
//  Created by jjx on 14/11/4.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionMsg : NSObject

@property (strong,nonatomic) NSString *ids;
@property (strong,nonatomic) NSString *portrait;
@property (strong,nonatomic) NSString *author;
@property (strong,nonatomic) NSString *authorid ;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *answerCount ;
@property (strong,nonatomic) NSString *viewCount ;
@property (strong,nonatomic) NSString *pubDate ;
@property (strong,nonatomic) NSString *name ;

- (id) initWithContent:(NSString*)andIds andPortrait:(NSString *)nPortrait andAuthor:(NSString *)nAuthor andAuthorid:(NSString*)nAuthorid andTitle:(NSString*)nTitle andAnswerCount:(NSString*)nAnswerCount  andViewCount:(NSString*) nViewCount andPubDate:(NSString*)nPubDate andName:(NSString*)nName;

@end
