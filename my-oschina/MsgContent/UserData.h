//
//  UserData.h
//  my-oschina
//
//  Created by jjx on 14/11/8.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

@property(strong, nonatomic) NSString *m_errorCode;
@property(strong, nonatomic) NSString *m_uid;
@property(strong, nonatomic) NSString *m_location;
@property(strong, nonatomic) NSString *m_name;
@property(strong, nonatomic) NSString *m_followers;
@property(strong, nonatomic) NSString *m_fans;
@property(strong, nonatomic) NSString *m_score;
@property(strong, nonatomic) NSString *m_portrait;

- (id)initWithContent:(NSString *)nerrorCode
               andUid:(NSString *)nUid
          andLocation:(NSString *)nLocation
              andName:(NSString *)nName
         andFollowers:(NSString *)nFollowers
              andFans:(NSString *)nFans
             andScore:(NSString *)nScore
          andPortrait:(NSString *)nPortrait;
@end
