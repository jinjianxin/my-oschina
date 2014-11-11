//
//  TweetDetailViewControl.h
//  my-oschina
//
//  Created by jjx on 14/11/10.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "prefix_define.h"
#import "TBXML.h"
#import "XmlParser.h"

@interface TweetDetailViewControl : UIViewController <ASIHTTPRequestDelegate>

@property (strong,nonatomic) NSString *m_uid;
@property (strong,nonatomic) UIWebView *m_webView;
@property (strong,nonatomic) UITextView *m_textField;

@end
