//
//  PubComments.m
//  my-oschina
//
//  Created by jjx on 14/11/18.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "PubComments.h"

@implementation PubComments

@synthesize m_title;
@synthesize m_commentView;
@synthesize m_id;
@synthesize m_catalog;
@synthesize m_uid;
@synthesize m_parent;

-(void)loadView
{
    [super loadView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [button setTitle:@"立即发表" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = item;
    
    m_title = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 100, 50)];
    [m_title setText:@"我要评论"];

    
    m_commentView = [[UITextView alloc] initWithFrame:CGRectMake(20, 120, 330, 150)];
    m_commentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    m_commentView.layer.borderWidth =1.0;
    m_commentView.layer.cornerRadius =5.0;
    [m_commentView setFont:[UIFont fontWithName:@"" size:20] ];
    
    
    [self.view addSubview:m_title];
    [self.view addSubview:m_commentView];
    
    UITapGestureRecognizer* gesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)hideKeyboard
{
    [m_commentView resignFirstResponder];
}

- (void) rightClick:(id)sender
{
    NSString *content = m_commentView.text;
    
    NSString *postURL = [NSString stringWithFormat:@"%@", api_comment_pub];
    
    ASIFormDataRequest *request =
    [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:postURL]];
    
    [request addPostValue:m_id forKey:@"id"];
    [request addPostValue:m_catalog forKey:@"catalog"];
    [request addPostValue:m_uid forKey:@"uid"];
    [request addPostValue:content forKey:@"content"];
    [request addPostValue:@"0" forKey:@"isPostToMyZone"];
    
    [request setDelegate:self];
    [request startSynchronous];
}

- (void)requestFinished:(ASIHTTPRequest*)request
{
    NSString* response = request.responseString;

    TBXML* tbxml = [TBXML newTBXMLWithXMLString:response error:nil];

    if (tbxml != nil) {
        TBXMLElement* root = tbxml.rootXMLElement;
        if (root != nil) {
            TBXMLElement* _result = [TBXML childElementNamed:@"result" parentElement:root];
            if (_result != nil) {
                TBXMLElement* _errorCode = [TBXML childElementNamed:@"errorCode" parentElement:_result];
                
                
                TBXMLElement* _comment = [TBXML childElementNamed:@"comment" parentElement:root];
                
                if (_comment != nil) {
                    TBXMLElement* _id = [TBXML childElementNamed:@"id" parentElement:_comment];
                    TBXMLElement* _portrait = [TBXML childElementNamed:@"portrait" parentElement:_comment];
                    TBXMLElement* _author = [TBXML childElementNamed:@"author" parentElement:_comment];
                    TBXMLElement* _authorId = [TBXML childElementNamed:@"authorid" parentElement:_comment];
                    TBXMLElement* _content = [TBXML childElementNamed:@"content" parentElement:_comment];
                    TBXMLElement* _pubDate = [TBXML childElementNamed:@"pubDate" parentElement:_comment];
                    
                    
                    CommentMsgDetails *msg = [[CommentMsgDetails alloc] initWithContent:[TBXML textForElement:_id] andPortrait:[TBXML textForElement:_portrait] andAuthor:[TBXML textForElement:_author] andAuthorid:[TBXML textForElement:_authorId] andContent:[TBXML textForElement:_content] andPubDate:[TBXML textForElement:_pubDate] andAppClent:nil andRefers:nil];
                    
                    CommentsDetail *commentsDetail = (CommentsDetail*)m_parent;
                    [commentsDetail.m_commentArray addObject:msg];
                    
                }

                int errorCode = [[TBXML textForElement:_errorCode] intValue];

                if (errorCode == 1) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
}

@end
