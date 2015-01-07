//
//  BlogDetail.m
//  my-oschina
//
//  Created by jjx on 14/11/17.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "BlogDetail.h"

@implementation BlogDetail {
    id<TabBarProtocol> mydelegate;
}

@synthesize m_webView;

- (void)loadView
{
    [super loadView];

    CGRect rect = self.view.bounds;

    self.m_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];

    [self.view addSubview:m_webView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    http://www.oschina.net/action/api/blog_detail?id=345392

    NSString* str = [NSString stringWithFormat:@"%@?id=%d", api_blog_detail, self.m_ids];

    NSLog(@"%@", str);

    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:str]];

    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest*)request
{
    NSString* response = request.responseString;

    TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:nil];

    TBXMLElement* _id = nil;
    TBXMLElement* _title = nil;
    TBXMLElement* _url = nil;
    TBXMLElement* _where = nil;
    TBXMLElement* _body = nil;
    TBXMLElement* _author = nil;
    TBXMLElement* _authorid = nil;
    TBXMLElement* _documentType = nil;
    TBXMLElement* _pubDate = nil;
    TBXMLElement* _fav = nil;
    TBXMLElement* _commentCount = nil;

    if (tbxml != nil) {
        TBXMLElement* root = tbxml.rootXMLElement;
        if (root != nil) {
            TBXMLElement* blog = [TBXML childElementNamed:@"blog" parentElement:root];

            _id = [TBXML childElementNamed:@"id" parentElement:blog];
            _title = [TBXML childElementNamed:@"title" parentElement:blog];
            _url = [TBXML childElementNamed:@"url" parentElement:blog];
            _where = [TBXML childElementNamed:@"where" parentElement:blog];
            _body = [TBXML childElementNamed:@"body" parentElement:blog];
            _author = [TBXML childElementNamed:@"author" parentElement:blog];
            _authorid = [TBXML childElementNamed:@"authorid" parentElement:blog];
            _documentType = [TBXML childElementNamed:@"documentType" parentElement:blog];
            _pubDate = [TBXML childElementNamed:@"pubDate" parentElement:blog];
            _fav = [TBXML childElementNamed:@"favorite" parentElement:blog];
            _commentCount = [TBXML childElementNamed:@"commentCount" parentElement:blog];
        }
    }

    NSString* author_str = [NSString stringWithFormat:@"<a href='http://my.oschina.net/u/%d'>%@</a>&nbsp;发表于&nbsp;%@", [TBXML textForElement:_authorid], [TBXML textForElement:_author], [XmlParser intervalSinceNow:[TBXML textForElement:_pubDate]]];

    NSString* html = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@</body>", HTML_Style, [TBXML textForElement:_title], author_str, [TBXML textForElement:_body], HTML_Bottom];
    [self.m_webView loadHTMLString:html baseURL:nil];

    [mydelegate setBarTitle:@"博客详情" andButtonTitle:@"收藏此博客" andProtocol:self];
}

- (void)requestFailed:(ASIHTTPRequest*)request
{

    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:
                                                      @"警告"
                                                        message:@"网络连接错误"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
}

- (void)barButttonClick
{
}

- (void)setMyDelegate:(id<TabBarProtocol>)delegate
{
    mydelegate = delegate;
}

@end
