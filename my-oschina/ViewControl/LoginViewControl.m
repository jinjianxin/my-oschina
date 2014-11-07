//
//  LoginViewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/7.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "LoginViewControl.h"

@implementation LoginViewControl


@synthesize m_userName;
@synthesize m_userTextView;
@synthesize m_passwd;
@synthesize m_passwdText;
@synthesize m_tip;
@synthesize m_switch;
@synthesize m_webView;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"登录"  style:UIBarButtonItemStyleDone target:self action:@selector(selectRightAction:)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    m_userName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    m_userName.text = @"用户名";
    m_userName.font = [UIFont fontWithName:@"" size:12];
    
    m_userTextView = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, 300, 30)];
    m_userTextView.layer.borderWidth =1.0;
    m_userTextView.layer.cornerRadius =5.0;
    
    
    m_passwd =[[UILabel alloc] initWithFrame:CGRectMake(10, 90, 300, 30)];
    m_passwd.text = @"密码";
    m_passwd.font = [UIFont fontWithName:@"" size:12];
    
    
    m_passwdText = [[UITextField alloc] initWithFrame:CGRectMake(10, 130, 300, 30)];
    m_passwdText.layer.borderWidth =1.0;
    m_passwdText.layer.cornerRadius =5.0;
    m_passwdText.secureTextEntry = YES;
    
    m_tip = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 300, 30)];
    m_tip.text = @"记住密码";
    m_tip.font = [UIFont fontWithName:@"" size:12];

    
    m_switch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 170, 300, 30)];
    [m_switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    NSString *html = @"<body style='background-color:#EBEBF3'>1, 您可以在 <a href='http://www.oschina.net'>http://www.oschina.net</a> 上免费注册一个账号用来登陆<p />2, 如果您的账号是使用OpenID的方式注册的，那么建议您在网页上为账号设置密码<p />3, 您可以点击 <a href='http://www.oschina.net/question/12_52232'>这里</a> 了解更多关于手机客户端登录的问题</body>";

    m_webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 250, 350, 200)];
    [m_webView loadHTMLString:html baseURL:nil];


    
    
    
    [self.view addSubview:m_userName];
    [self.view addSubview:m_userTextView];
    [self.view addSubview:m_passwd];
    [self.view addSubview:m_passwdText];
    [self.view addSubview:m_tip];
    [self.view addSubview:m_switch];
    [self.view addSubview:m_webView];
    
    
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
 
    [self.view addGestureRecognizer:tap];
    

}

-(void)selectRightAction:(id)sender
{
    NSString *name = self.m_userTextView.text;
    NSString *pwd = self.m_passwdText.text;
    
  /*  request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:api_login_validate]];
    [request setUseCookiePersistence:YES];
    [request setPostValue:name forKey:@"username"];
    [request setPostValue:pwd forKey:@"pwd"];
    [request setPostValue:@"1" forKey:@"keep_login"];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setDidFinishSelector:@selector(requestLogin:)];
    [request startAsynchronous];
    
    request.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [Tool showHUD:@"正在登录" andView:self.view andHUD:request.hud]; */
    
    
    NSString *postURL = [NSString stringWithFormat:@"%@",api_login_validate];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:postURL]];
    
    [request addPostValue:name forKey:@"username"];
    [request addPostValue:pwd  forKey:@"pwd"];
    [request addPostValue:@"1" forKey:@"keep_login"];
    
    [request setDelegate:self];
    [request startSynchronous];
    
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    
    NSLog(@"%@",responseString);
    
    TBXMLElement *errorEle = nil;
    
    
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:responseString error:nil];
    
    if(tbxml!=nil)
    {
        TBXMLElement *root = tbxml.rootXMLElement;
        
        if(root!=nil)
        {
            TBXMLElement *childElement = [TBXML childElementNamed:@"result" parentElement:root];
            
            if(childElement!=nil)
            {
                
                errorEle= [TBXML childElementNamed:@"errorCode" parentElement:childElement];
            }
            
        }
    }
    
    if(errorEle!=nil)
    {
        int errorCode = [[TBXML textForElement:errorEle] intValue];
        
        if(errorCode ==1)
        {
            NSLog(@"login success");
        }
        else
        {
            [self popupErrorDialog];
        }
    }
    else{
        [self popupErrorDialog];
    }
    
}


- (void) popupErrorDialog
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码或者用户名错误"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void) requestFailed:(ASIHTTPRequest *)request
{
    
}


-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        
    }else {
        
    }
}


- (void) dismissKeyboard
{
    [m_userTextView resignFirstResponder];
    [m_passwdText resignFirstResponder];
}

@end
