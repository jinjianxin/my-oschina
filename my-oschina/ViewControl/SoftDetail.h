//
//  SoftDetail.h
//  my-oschina
//
//  Created by jjx on 14/11/17.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CustomProtocol.h"
#import "prefix_define.h"
#import "TBXML.h"

@interface SoftDetail : UIViewController <ASIHTTPRequestDelegate, ViewProtocol>

@property (strong, nonatomic) UIWebView* m_webView;

@property (strong, nonatomic) IBOutlet UIView* m_myView;
@property int m_ids;
@property int m_newsCategory;
@property (nonatomic, strong) NSString* m_softwareName;

- (void)setMyDelegate:(id<TabBarProtocol>)delegate;

@end
