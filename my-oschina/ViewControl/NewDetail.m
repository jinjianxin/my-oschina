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

@synthesize m_msgDetail;
@synthesize m_webView;
@synthesize m_newsCategory;
@synthesize m_ids;
@synthesize m_singleNews;

- (void) loadView
{
    [super loadView];

    CGRect rect = self.view.bounds;

    self.m_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width , rect.size.height)];
    
    self.m_webView.delegate =self;

    
    [self.view addSubview:m_webView];
    
}

- (void) viewDidAppear:(BOOL)animated
{
   // [super viewDidAppear:animated];
    
    NSString *str ;
    
    if(m_newsCategory ==1)
    {
        str = [NSString stringWithFormat:@"%@id=%@",new_detail,m_ids];
    }
    else if(m_newsCategory ==2 || m_newsCategory ==3)
    {
        str = [NSString stringWithFormat:@"%@id=%@",blog_detail,m_ids];
    }

    NSURL *url = [NSURL URLWithString:str];
    
    NSLog(@"str = %@",str);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    //[mydelegate setBarTitle:@"咨询详情"];
}

- (void)barButttonClick
{
 //   NSUserDefaults* userData = [NSUserDefaults standardUserDefaults];

    NSString* uid = [Helper getUid] ;//[userData stringForKey:@"uid"];

    if (uid != nil) {
        
       
        NSString* str = nil;

        if(m_singleNews.m_favorite)
        {
            str = [NSString stringWithFormat:@"%@?uid=%@&type=4&objid=%@", api_favorite_delete,uid,m_ids];
        }
        else{
            str = [NSString stringWithFormat:@"%@?uid=%@&type=4&objid=%@", api_favorite_add,uid,m_ids];
        }
        
        ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:str]];
        
        [request setRequestMethod:@"GET"];
        
        [request setCompletionBlock:^{
            NSString *response = [request responseString ];
           
            TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:nil];
            
            if(tbxml !=nil)
            {
                TBXMLElement *root = tbxml.rootXMLElement;
                 NSLog(@"");
                if(root!=nil)
                {
                    TBXMLElement *_result = [TBXML childElementNamed:@"result" parentElement:root];
                    
                    TBXMLElement *_errorCode = [TBXML childElementNamed:@"errorCode" parentElement:_result];
                    
                    int errorcode = [[TBXML textForElement:_errorCode] intValue];
                    if(errorcode ==1)
                    {
                        m_singleNews.m_favorite = !m_singleNews.m_favorite;
                        
                        if(m_singleNews.m_favorite)
                        {
                            [mydelegate setBarTitle:@"资讯详情" andButtonTitle:@"取消收藏" andProtocol:self];
                        }
                        else{
                            [mydelegate setBarTitle:@"资讯详情" andButtonTitle:@"收藏此文" andProtocol:self];
                        }

                    }
                    else{
                        
                    }
                
                }
            }
        }];
        
        [request setFailedBlock:^{
            
            NSLog(@"---");
            
        }];
        
        [request startAsynchronous];
    }
    else{
      //  [self.view makeToast:@"请先登陆"];
        
        [self.view makeToast:@"请先登陆"
                    duration:1.5
                    position:CSToastPositionCenter
                       image:nil];
    }
}

- (void) setMyDelegate:(id<TabBarProtocol>)delegate
{
    mydelegate = delegate;
}

 -(void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    
    NSString *html ;
    
    if(m_newsCategory ==1)
    {
    
    m_singleNews = [XmlParser singleNewParser:responseString];
    
    NSString *author_str = [NSString stringWithFormat:@"<a href='http://my.oschina.net/u/%d'>%@</a> 发布于 %@",m_singleNews.m_authorid,m_singleNews.m_author,m_singleNews.m_pubDate];
    
    
    NSString *software = @"";
    if ([m_singleNews.m_softwarename isEqualToString:@""] == NO) {
        software = [NSString stringWithFormat:@"<div id='oschina_software' style='margin-top:8px;color:#FF0000;font-size:14px;font-weight:bold'>更多关于:&nbsp;<a href='%@'>%@</a>&nbsp;的详细信息</div>",m_singleNews.m_softwarelink, m_singleNews.m_softwarename];
    }
    
    html = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@%@%@</body>",HTML_Style, m_singleNews.m_title,author_str, m_singleNews.m_body,software,[XmlParser generateRelativeNewsString:m_singleNews.m_relativies],HTML_Bottom];
    }
    else if(m_newsCategory ==2 || m_newsCategory ==3)
    {
        BlogDetails *blogDetails = [XmlParser blogDetailParser:responseString];
        
        NSString *author_str = [NSString stringWithFormat:@"<a href='http://my.oschina.net/u/%d'>%@</a>&nbsp;发表于&nbsp;%@",blogDetails.m_authorid, blogDetails.m_author,  [XmlParser intervalSinceNow:blogDetails.m_pubDate]];
        html = [NSString stringWithFormat:@"<body style='background-color:#EBEBF3'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@</body>",HTML_Style, blogDetails.m_title,author_str,blogDetails.m_body,HTML_Bottom];

        
    }
    
    
    [self.m_webView loadHTMLString:html baseURL:nil];
    
    
    if(m_singleNews.m_favorite)
    {
        [mydelegate setBarTitle:@"资讯详情" andButtonTitle:@"取消收藏" andProtocol:self];
    }
    else{
        [mydelegate setBarTitle:@"资讯详情" andButtonTitle:@"收藏此文" andProtocol:self];
    }
    
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    /*
    [Tool analysis:[request.URL absoluteString] andNavController:self.parentViewController.navigationController];*/
    
    [Helper analysisDetail:[request.URL absoluteString] andNav:self.parentViewController.navigationController];
    
    if ([request.URL.absoluteString isEqualToString:@"about:blank"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (void) requestFailed:(ASIHTTPRequest *)request
{
    
}




@end
