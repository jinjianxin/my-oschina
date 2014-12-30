//
//  PostDetails.m
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "PostDetails.h"

@implementation PostDetails
{
     id<TabBarProtocol> mydelegate;
}

@synthesize webView;
@synthesize newsCategory;
@synthesize ids;

- (void) loadView
{
    [super loadView];
    
    
    CGRect rect = self.view.bounds;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width , rect.size.height)];
    
    [self.view addSubview:webView];
    
}

-(void)setMyDelegate:(id<TabBarProtocol>)delegate
{
    mydelegate = delegate;
}

- (void) viewDidAppear:(BOOL)animated
{
    NSString *str ;
    
    str = [NSString stringWithFormat:@"http://www.oschina.net/action/api/post_detail?id=%@",ids];
    
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    [mydelegate setBarTitle:@"问答详情" andButtonTitle:@"收藏此贴" andProtocol:self];
    
}

- (void)barButttonClick
{
    
    
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];

    PostMsg *msg = [XmlParser postNewParser:responseString];
    
    NSString *author_str = [NSString stringWithFormat:@"<a href='http://my.oschina.net/u/%@'>%@</a> 发布于 %@",msg.m_authorid, msg.m_author, msg.m_pubDate];
    
    NSString *result ;
    
    if (msg.m_tagArray == nil || msg.m_tagArray.count == 0) {
        result = @"";
    }
    else
    {
        result = @"";
        for (NSString *t in msg.m_tagArray) {
            result = [NSString stringWithFormat:@"%@<a style='background-color: #BBD6F3;border-bottom: 1px solid #3E6D8E;border-right: 1px solid #7F9FB6;color: #284A7B;font-size: 12pt;-webkit-text-size-adjust: none;line-height: 2.4;margin: 2px 2px 2px 0;padding: 2px 4px;text-decoration: none;white-space: nowrap;' href='http://www.oschina.net/question/tag/%@' >&nbsp;%@&nbsp;</a>&nbsp;&nbsp;",result,t,t];
        }
    }

    
    NSString *html = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3;'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@%@</body>",HTML_Style, msg.m_title,author_str,msg.m_body,result,HTML_Bottom];
    
    [self.webView loadHTMLString:html baseURL:nil];

}


- (void) requestFailed:(ASIHTTPRequest *)request
{
    
}


@end
