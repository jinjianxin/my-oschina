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

@interface PostDetails : UIViewController <ASIHTTPRequestDelegate, ViewProtocol>

@property (strong, nonatomic) UIWebView* m_webView;

@property (strong, nonatomic) IBOutlet UIView* m_myView;
@property (copy, nonatomic) NSString* m_ids;
@property int m_newsCategory;

- (void)setMyDelegate:(id<TabBarProtocol>)delegate;

@end
