//
//  TweetMsg.m
//  my-oschina
//
//  Created by jjx on 14/11/6.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "TweetMsg.h"

@implementation TweetMsg

@synthesize m_id;
@synthesize m_portrait;
@synthesize m_author;
@synthesize m_authorid;
@synthesize m_body;
@synthesize m_appclient;
@synthesize m_commentCount;
@synthesize m_pubDate;
@synthesize m_height;

-(id)initWithContent:(NSString *)andId andPortrait:(NSString *)nPortrait andAuthor:(NSString *)nAuthor andAuthorid:(NSString *)nAuthorid andBody:(NSString *)nBody andAppclient:(NSString *)nAppclient andCommentCount:(NSString *)nCommentCount andPullDate:(NSString *)npubDate
{
    TweetMsg *msg = [[TweetMsg alloc] init];
    
    msg.m_id = andId;
    msg.m_portrait =nPortrait;
    msg.m_author = nAuthor;
    msg.m_authorid =nAuthorid;
    msg.m_body = nBody;
    msg.m_appclient =nAppclient;
    msg.m_commentCount = nCommentCount;
    msg.m_pubDate = npubDate;
    
    UITextView *txt = [[UITextView alloc] initWithFrame:CGRectMake(157, 178, 236, 331)];
    int height = [self getTextViewHeight:txt andUIFont:[UIFont fontWithName:@"arial" size:14.0f] andText:msg.m_body]+40;
    
    if(height<62)
    {
        msg.m_height = 62;
    }
    else
    {
        msg.m_height = height;
    }
    
    return msg;
}


- (int)getTextViewHeight:(UITextView *)txtView andUIFont:(UIFont *)font andText:(NSString *)txt
{
    float fPadding = 16.0;
    CGSize constraint = CGSizeMake(txtView.contentSize.width - 10 - fPadding, CGFLOAT_MAX);
    CGSize size = [txt sizeWithFont:font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    float fHeight = size.height + 16.0;
    return fHeight;
}
@end
