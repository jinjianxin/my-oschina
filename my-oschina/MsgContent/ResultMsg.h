//
//  ResultMsg.h
//  my-oschina
//
//  Created by jjx on 14/11/14.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultMsg : NSObject

@property (strong,nonatomic) NSString *m_id;
@property (strong,nonatomic) NSString *m_type;
@property (strong,nonatomic) NSString *m_title;
@property (strong,nonatomic) NSString *m_url;
@property (strong,nonatomic) NSString *m_author;

- (id) initContent:(NSString*)nId andType:(NSString*)nType andTitle:(NSString*)nTitle andUrl:(NSString*)nUrl andAuthor:(NSString*)nAuthor;

@end
