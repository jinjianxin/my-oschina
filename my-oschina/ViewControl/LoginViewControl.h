//
//  LoginViewControl.h
//  my-oschina
//
//  Created by jjx on 14/11/7.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "prefix_define.h"
#import "ASIFormDataRequest.h"
#import "TBXML.h"
#import "XmlParser.h"


@interface LoginViewControl : UIViewController <ASIHTTPRequestDelegate,UIAlertViewDelegate>

@property (strong,nonatomic) UILabel *m_userName;
@property (strong,nonatomic) UITextField *m_userTextView;
@property (strong,nonatomic) UILabel *m_passwd;
@property (strong,nonatomic) UITextField  *m_passwdText;
@property (strong,nonatomic) UILabel *m_tip;
@property (strong,nonatomic) UISwitch *m_switch;
@property (strong,nonatomic) UIWebView  *m_webView;

@end
