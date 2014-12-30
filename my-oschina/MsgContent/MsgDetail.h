//
//  MsgDetail.h
//  my-oschina
//
//  Created by jjx on 14/10/29.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgDetail : NSObject

@property (nonatomic,copy) NSString *m_titile;
@property (nonatomic,copy) NSString *m_author;
@property (nonatomic,copy) NSString *m_ids;
@property (nonatomic,copy) NSString *m_pullDate;
@property (nonatomic,copy) NSString *m_url;
@property int newType;
@property (nonatomic,copy) NSString *attachMent;
@property BOOL favorite;

- (id) initwithContent:(NSString *)_titile author:(NSString *)_author ids:(NSString *)_ids pullDate:(NSString *)_pullDate ;

- (id) initwithBlog:(NSString *)_titile author:(NSString *)_author ids:(NSString *)_ids pullDate:(NSString *)_pullDate url:(NSString *)_url;

@end
