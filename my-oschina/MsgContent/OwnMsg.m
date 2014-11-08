//
//  OwnMsg.m
//  my-oschina
//
//  Created by jjx on 14/11/8.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "OwnMsg.h"

@implementation OwnMsg

@synthesize m_id;
@synthesize m_portrait;
@synthesize m_author;
@synthesize m_authorid;
@synthesize m_catalog;
@synthesize m_objecttype;
@synthesize m_objectcatalog;
@synthesize m_objecttitle;
@synthesize m_appclient;
@synthesize m_url;
@synthesize m_objectID;
@synthesize m_message;
@synthesize m_commentCount;
@synthesize m_pubDate;
@synthesize m_tweetimage;
@synthesize m_height;

- (void) calculateHeight
{
    
    NSString *str = [NSString stringWithFormat:@"%@ 回答了问题: %@",@"xjnzy",self.m_objecttitle];
    
    UITextView *txt = [[UITextView alloc] initWithFrame:CGRectMake(157, 178, 236, 331)];
    int height = [self getTextViewHeight:txt andUIFont:[UIFont fontWithName:@"arial" size:14.0f] andText:str]+80;
    
    if(height<62)
    {
        self.m_height = 62;
    }
    else
    {
        self.m_height = height;
    }
    
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
