//
//  OwnMsg.h
//  my-oschina
//
//  Created by jjx on 14/11/8.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OwnMsg : NSObject

@property (strong,nonatomic) NSString *m_id;
@property (strong,nonatomic) NSString *m_portrait;
@property (strong,nonatomic) NSString *m_author;
@property (strong,nonatomic) NSString *m_authorid;
@property (strong,nonatomic) NSString *m_catalog;
@property (strong,nonatomic) NSString *m_objecttype;
@property (strong,nonatomic) NSString *m_objectcatalog;
@property (strong,nonatomic) NSString *m_objecttitle;
@property (strong,nonatomic) NSString *m_appclient;
@property (strong,nonatomic) NSString *m_url;
@property (strong,nonatomic) NSString *m_objectID;
@property (strong,nonatomic) NSString *m_message;
@property (strong,nonatomic) NSString *m_commentCount;
@property (strong,nonatomic) NSString *m_pubDate;
@property (strong,nonatomic) NSString *m_tweetimage;
@property int m_height;

- (void)calculateHeight;


@end
