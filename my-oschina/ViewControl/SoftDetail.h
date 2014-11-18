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

@interface SoftDetail : UIViewController<ASIHTTPRequestDelegate,ViewProtocol>

@property (strong,nonatomic) UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIView *myView;
@property int ids;
@property int newsCategory;
@property (nonatomic,strong) NSString *softwareName;

- (void) setMyDelegate:(id<TabBarProtocol>)delegate;


@end
