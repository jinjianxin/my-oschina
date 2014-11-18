//
//  NewDetail.h
//  my-oschina
//
//  Created by jjx on 14/10/30.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgDetail.h"
#import "ASIHTTPRequest.h"
#import "SingleNews.h"
#import "prefix_define.h"
#import "XmlParser.h"
#import "CustomProtocol.h"
#import "ASIFormDataRequest.h"
#import "prefix_define.h"


@interface NewDetail : UIViewController <ASIHTTPRequestDelegate,ViewProtocol,ASIHTTPRequestDelegate>
{
  //  MsgDetail *msgDetail;
}


@property (strong,nonatomic) UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIView *myView;
@property (nonatomic,strong) MsgDetail *msgDetail;
@property (copy,nonatomic) NSString *ids;
@property int newsCategory;
@property (strong,nonatomic) SingleNews *singleNews;

- (void) setMyDelegate:(id<TabBarProtocol>)delegate;

@end
