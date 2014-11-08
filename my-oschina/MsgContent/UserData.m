//
//  UserData.m
//  my-oschina
//
//  Created by jjx on 14/11/8.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "UserData.h"

@implementation UserData

@synthesize m_errorCode;
@synthesize m_uid;
@synthesize m_location;
@synthesize m_name;
@synthesize m_followers;
@synthesize m_fans;
@synthesize m_score;
@synthesize m_portrait;

- (id) initWithContent:(NSString *)nerrorCode andUid:(NSString *)nUid andLocation:(NSString *)nLocation andName:(NSString *)nName andFollowers:(NSString *)nFollowers andFans:(NSString *)nFans andScore:(NSString *)nScore andPortrait:(NSString *)nPortrait
{
    UserData *data = [[UserData alloc] init];
    data.m_errorCode = nerrorCode;
    data.m_uid = nUid;
    data.m_location = nLocation;
    data.m_name = nName;
    data.m_followers = nFollowers;
    data.m_fans = nFans;
    data.m_score = nScore;
    data.m_portrait = nPortrait;
    
    
    return data;
}

@end
