//
//  TweetDetailViewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/10.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "TweetDetailViewControl.h"

@interface TweetDetailViewControl ()

@end

@implementation TweetDetailViewControl {
    id<TabBarProtocol> mydelegate;
}

@synthesize m_uid;
@synthesize m_webView;
@synthesize m_textField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    self.parentViewController.navigationController.title = @"***";

    for (id v in m_webView.subviews) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            [v setBounces:NO];
        }
    }

    m_textField.layer.borderColor = UIColor.grayColor.CGColor;
    m_textField.layer.borderWidth = 1;
    m_textField.layer.cornerRadius = 6;
    m_textField.layer.masksToBounds = YES;

    /*  [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(keyboadWillShow:)
               name:UIKeyboardWillShowNotification
             object:nil];
    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(keyboardWillHide:)
               name:UIKeyboardWillHideNotification
             object:nil];*/

    UITapGestureRecognizer* gesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1; //手势敲击的次数
    [self.view addGestureRecognizer:gesture];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    NSString* str =
        [NSString stringWithFormat:@"%@id=%@", api_tweet_detail, m_uid];

    ASIHTTPRequest* request =
        [ASIHTTPRequest requestWithURL:[NSURL URLWithString:str]];

    [request setDelegate:self];
    [request startAsynchronous];

    //[mydelegate setBarTitle:@"动态详情" andButtonTitle:@"发表" andProtocol:self];
}

- (void)setMyDelegate:(id<TabBarProtocol>)delegate
{
    mydelegate = delegate;
}

- (void)barButttonClick
{
}

- (void)rightButtonClick:(id)sender
{
}

- (void)keyboadWillShow:(NSNotification*)note
{
    NSDictionary* info = [note userInfo];
    NSValue* kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];

    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];

    CGRect finalKeyboardFrame = [self.view convertRect:keyboardFrame fromView:self.view.window];

    int kbHeight = finalKeyboardFrame.size.height;

    int height = kbHeight + 30;

    self.m_bottomConstraint.constant = height;

    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification*)note
{
    NSDictionary* info = [note userInfo];

    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    self.m_bottomConstraint.constant = 30;

    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)hideKeyboard
{
    [m_textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestFinished:(ASIHTTPRequest*)request
{
    NSString* response = [request responseString];
    NSLog(@"%@", response);

    TBXML* xml = [[TBXML alloc] initWithXMLString:response error:nil];
    TBXMLElement* root = xml.rootXMLElement;
    if (root == nil) {
        //[Tool ToastNotification:@"加载出现异常" andView:self.view andLoading:NO
        //andIsBottom:NO];
        return;
    }
    TBXMLElement* t = [TBXML childElementNamed:@"tweet" parentElement:root];
    if (t == nil) {
        //[Tool ToastNotification:@"加载出现异常" andView:self.view andLoading:NO
        //andIsBottom:NO];
        return;
    }
    TBXMLElement* _id = [TBXML childElementNamed:@"id" parentElement:t];
    TBXMLElement* _portrait =
        [TBXML childElementNamed:@"portrait" parentElement:t];
    TBXMLElement* _body = [TBXML childElementNamed:@"body" parentElement:t];
    TBXMLElement* _author = [TBXML childElementNamed:@"author" parentElement:t];
    TBXMLElement* _authorid =
        [TBXML childElementNamed:@"authorid" parentElement:t];
    TBXMLElement* _commentCount =
        [TBXML childElementNamed:@"commentCount" parentElement:t];
    TBXMLElement* _pubDate = [TBXML childElementNamed:@"pubDate" parentElement:t];
    TBXMLElement* _imgSmall =
        [TBXML childElementNamed:@"imgSmall" parentElement:t];
    TBXMLElement* _imgBig = [TBXML childElementNamed:@"imgBig" parentElement:t];
    TBXMLElement* _attach = [TBXML childElementNamed:@"attach" parentElement:t];

    NSString* pullDate =
        [XmlParser intervalSinceNow:[TBXML textForElement:_pubDate]];

    NSString* pubTime =
        [NSString stringWithFormat:@"在%@ 更新了动态 %@", pullDate, @""];

    NSString* imgHtml = @"";
    if ([[TBXML textForElement:_imgBig] isEqualToString:@""] == NO) {
        imgHtml =
            [NSString stringWithFormat:@"<br/><a href='http://wangjuntom'><img "
                                       @"style='max-width:300px;' src='%@'/></a>",
                                       [TBXML textForElement:_imgBig]];
    }

    self.m_webView.backgroundColor = [UIColor colorWithRed:235.0 / 255
                                                     green:235.0 / 255
                                                      blue:243.0 / 255
                                                     alpha:1.0];
    ;

    BOOL is_audio = [[TBXML textForElement:_attach] length] > 0; // singleTweet.attach.length > 0;

    //读取语音动弹相关html、js
    NSString* audio_html = @"";
    NSString* jquery_js = @"";
    if (is_audio) {
        audio_html = [self readResouceFile:@"audio" andExt:@"html"];
        audio_html =
            [NSString stringWithFormat:audio_html, [TBXML textForElement:_attach],
                                       [TBXML textForElement:_attach]];
        jquery_js = [self readResouceFile:@"jquery-1.7.1.min" andExt:@"js"];
    }

    NSString* html = [NSString
        stringWithFormat:@"<!DOCTYPE html><html><head><script "
                         @"type='text/javascript'>%@</script></head>%@<body "
                         @"style='background-color:#EBEBF3'><div "
                         @"id='oschina_title'><a "
                         @"href='http://my.oschina.net/u/%d'>%@</a></div><div "
                         @"id='oschina_outline'>%@</div><br/><div "
                         @"id='oschina_body' "
                         @"style='font-weight:bold;font-size:14px;line-height:"
                         @"21px;'>%@</div>%@%@%@</body></html>",
                         jquery_js, HTML_Style, [TBXML textForElement:_authorid],
                         [TBXML textForElement:_author], pubTime,
                         [TBXML textForElement:_body], imgHtml, HTML_Bottom,
                         audio_html];

    [self.m_webView loadHTMLString:html baseURL:nil];
}

- (NSString*)readResouceFile:(NSString*)filename andExt:(NSString*)ext
{
    NSString* path = [[NSBundle mainBundle] pathForResource:filename ofType:ext];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    return content;
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

@end
