//
//  BlogDetail.h
//  my-oschina
//
//  Created by jjx on 14/11/17.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomProtocol.h"
#import "ASIHTTPRequest.h"
#import "prefix_define.h"
#import "TBXML.h"
#import "XmlParser.h"

@interface BlogDetail : UIViewController <ASIHTTPRequestDelegate,ViewProtocol>

@property (strong,nonatomic) UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIView *myView;
@property int ids;
@property int newsCategory;

- (void) setMyDelegate:(id<TabBarProtocol>)delegate;

@end
