//
//  PostDetails.h
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgDetail.h"
#import "ASIHTTPRequest.h"
#import "SingleNews.h"
#import "prefix_define.h"
#import "XmlParser.h"
#import "CustomProtocol.h"

@interface PostDetails : UIViewController <ASIHTTPRequestDelegate,ViewProtocol>

@property (strong,nonatomic) UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIView *myView;
@property (copy,nonatomic) NSString *ids;
@property int newsCategory;

- (void) setMyDelegate:(id<TabBarProtocol>)delegate;

@end
