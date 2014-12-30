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
@synthesize m_content;

- (void) calculateHeight
{
    [self setText];
    
    NSString *str = nil;
    int height = 0;
    /*
    if([m_objecttype isEqualToString:@"32"])
    {
        str = [NSString stringWithFormat:@"%@ 回答了问题: %@",@"xjnzy",self.m_objecttitle];
        
        UITextView *txt = [[UITextView alloc] initWithFrame:CGRectMake(157, 178, 236, 331)];
        height = [self getTextViewHeight:txt andUIFont:[UIFont fontWithName:@"arial" size:14.0f] andText:str]+40;
    }
    else{
        str = [NSString stringWithFormat:@"%@ 加入了开源中国",@"xjnzy"];
        
        UITextView *txt = [[UITextView alloc] initWithFrame:CGRectMake(157, 178, 236, 331)];
        height = [self getTextViewHeight:txt andUIFont:[UIFont fontWithName:@"arial" size:14.0f] andText:str]+80;
    }
    */
    
    RTLabel *_author = [[RTLabel alloc] initWithFrame:CGRectMake(10, 10, 300, 50)];
    [_author setText:m_content];
    
    CGSize optimumSize = [_author optimumSize];
    
    if([m_tweetimage length] !=0)
    {
        m_height = (int)optimumSize.height+165;
    }
    else
    {
        m_height = (int)optimumSize.height+50;
    }
    
    
    if(m_height<62)
    {
        self.m_height = 62;
    }

}

- (void)setText
{
    NSString *_author = @"";
    if (m_author != nil) {
        _author = [NSString stringWithFormat:@"<font size=14 color='#0D6DA8'>%@</font>",m_author];
    }
    NSString *_message = @"";
    NSString *_pubDate = @"";
    if (m_pubDate != nil) {
        _pubDate = [NSString stringWithFormat:@"<font size=12 color='#999999'>\n%@</font>",m_pubDate];
    }
    NSString *_reply = @"";
    switch ([m_objecttype intValue]) {
        case 6:
        {
            _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 发布了一个职位 </font><font size=14 color='#0D6DA8'>%@</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
        }
            break;
        case 20:
        {
            _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 在职位 </font><font size=14 color='#0D6DA8'>%@</font><font size=14 color='#999999'> 发表评论:</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
        }
            break;
        case 32:
        {
            if ([m_objectcatalog intValue] == 0) {
                _message = @"<font size=14 color='#999999'> 加入了开源中国</font>";
            }
        }
            break;
        case 1:
        {
            if ([m_objectcatalog intValue] == 0) {
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 添加了开源项目 </font><font size=14 color='#0D6DA8'>%@</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
            }
        }
            break;
        case 2:
        {
            if ([m_objectcatalog intValue] == 1) {
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 在讨论区提问 </font>:<font size=14 color='#0D6DA8'>%@</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
            }
            else if([m_objectcatalog intValue] == 2){
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 发表了新话题:</font><font size=14 color='#0D6DA8'>%@</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
            }
        }
            break;
        case 3:
        {
            if ([m_objectcatalog intValue] == 0) {
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 发表了博客 </font><font size=14 color='#0D6DA8'>%@</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
            }
        }
            break;
        case 4:
        {
            if ([m_objectcatalog intValue] == 0) {
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 发表一篇新闻 </font><font size=14 color='#0D6DA8'>%@</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
            }
        }
            break;
        case 5:
        {
            if ([m_objectcatalog intValue] == 0) {
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 分享了一段代码 </font><font size=14 color='#0D6DA8'>%@</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
            }
        }
            break;
        case 16:
        {
            if ([m_objectcatalog intValue] == 0) {
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 在新闻 </font><font size=14 color='#0D6DA8'>%@</font><font size=14 color='#999999'> 发表评论</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
            }
        }
            break;
            //锁定 objectCataog = 1
        case 17:
        {
            if ([m_objectcatalog intValue] == 1) {
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 回答了问题:</font> <font size=14 color='#0D6DA8'>%@</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
            }
            else if([m_objectcatalog intValue] == 2){
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 回复了话题:</font> <font size=14 color='#0D6DA8'>%@</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
            }
            else if([m_objectcatalog intValue] == 3){
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 在 </font><font size=14 color='#0D6DA8'>%@</font><font size=14 color='#999999'> 对回帖发表评论</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
            }
        }
            break;
        case 18:
        {
            if ([m_objectcatalog intValue] == 0) {
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 在博客 </font><font size=14 color='#0D6DA8'>%@</font><font size=14 color='#999999'> 发表评论</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
            }
        }
            break;
        case 19:
        {
            if ([m_objectcatalog intValue] == 0) {
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 在代码 </font><font size=14 color='#0D6DA8'>%@</font><font size=14 color='#999999'> 发表评论</font>\n<font size=14><b>%@</b></font>",m_objecttitle,m_message];
            }
        }
            break;
        case 100:
        {
            if ([m_objectcatalog intValue] == 0) {
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 更新了动态</font>\n<font size=14><b>%@</b></font>", m_message];
            }
        }
            break;
        case 101:
        {
            if ([m_objectcatalog intValue] == 0) {
                _message = [NSString stringWithFormat:@"<font size=14 color='#999999'> 回复了动态</font>\n<font size=5>\n</font><font size=14><b>%@</b></font>",m_message];
            }
        }
            break;
    }
    
    /*
    //计算reply
    if (reply) {
        _reply = [NSString stringWithFormat:@"<font size=6>\n\n</font><font size=13 color='#FF4600'>@%@: %@</font>", reply.objectname, reply.objectbody];
    }
    */
    m_content= [NSString stringWithFormat:@"%@%@%@%@",_author,_message,_reply,_pubDate];

}
+ (NSString *)getAppClientString:(int)appClient
{
    switch (appClient) {
        case 1:
            return @"";
        case 2:
            return @"来自手机";
        case 3:
            return @"来自Android";
        case 4:
            return @"来自iPhone";
        case 5:
            return @"来自Windows Phone";
        case 6:
            return @"来自微信";
        default:
            return @"";
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
