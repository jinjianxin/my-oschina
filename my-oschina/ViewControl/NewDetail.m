//
//  NewDetail.m
//  my-oschina
//
//  Created by jjx on 14/10/30.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "NewDetail.h"


//http://www.oschina.net/action/api/news_detail?id=10002487

@implementation NewDetail
{
    id<TabBarProtocol> mydelegate;
}

@synthesize msgDetail;
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

- (void) viewDidAppear:(BOOL)animated
{
   // [super viewDidAppear:animated];
    
    NSString *str ;
    
    if(newsCategory ==1)
    {
        str = [NSString stringWithFormat:@"%@id=%@",new_detail,ids];
    }
    else if(newsCategory ==2 || newsCategory ==3)
    {
        str = [NSString stringWithFormat:@"%@id=%@",blog_detail,ids];
    }

    NSURL *url = [NSURL URLWithString:str];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    //[mydelegate setBarTitle:@"咨询详情"];
    [mydelegate setBarTitle:@"资讯详情" andButtonTitle:@"收藏此文" andProtocol:self];
    
}

- (void)barButttonClick
{
    NSUserDefaults* userData = [NSUserDefaults standardUserDefaults];

    NSString* uid = [userData stringForKey:@"uid"];

    if (uid != nil) {

        NSString* str = [NSString stringWithFormat:@"%@?uid=%@&?type=4?&objid=%@", api_favorite_add,uid,ids];
        
        ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:str]];
        
        [request setCompletionBlock:^{
            NSString *responseString = [request responseString ];
            
            NSLog(@"result = %@",responseString);
            
        }];
        
        [request setFailedBlock:^{
            
        }];
        
        [request startAsynchronous];
    
    }
}

- (void) setMyDelegate:(id<TabBarProtocol>)delegate
{
    mydelegate = delegate;
    
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    
    NSString *html ;
    
    if(newsCategory ==1)
    {
    
    SingleNews *singleNews = [XmlParser singleNewParser:responseString];
    
    NSString *author_str = [NSString stringWithFormat:@"<a href='http://my.oschina.net/u/%d'>%@</a> 发布于 %@",singleNews.authorid,singleNews.author,singleNews.pubDate];
    
    
    NSString *software = @"";
    if ([singleNews.softwarename isEqualToString:@""] == NO) {
        software = [NSString stringWithFormat:@"<div id='oschina_software' style='margin-top:8px;color:#FF0000;font-size:14px;font-weight:bold'>更多关于:&nbsp;<a href='%@'>%@</a>&nbsp;的详细信息</div>",singleNews.softwarelink, singleNews.softwarename];
    }
    
    html = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@%@%@</body>",HTML_Style, singleNews.title,author_str, singleNews.body,software,[XmlParser generateRelativeNewsString:singleNews.relativies],HTML_Bottom];
    }
    else if(newsCategory ==2 || newsCategory ==3)
    {
        BlogDetails *blogDetails = [XmlParser blogDetailParser:responseString];
        
        NSString *author_str = [NSString stringWithFormat:@"<a href='http://my.oschina.net/u/%d'>%@</a>&nbsp;发表于&nbsp;%@",blogDetails.authorid, blogDetails.author,  [XmlParser intervalSinceNow:blogDetails.pubDate]];
        html = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@</body>",HTML_Style, blogDetails.title,author_str,blogDetails.body,HTML_Bottom];

        
    }
    
    
    [self.webView loadHTMLString:html baseURL:nil];
    
}


- (void) requestFailed:(ASIHTTPRequest *)request
{
    
}




@end
