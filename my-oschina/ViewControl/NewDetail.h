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
#import "Helper.h"


@interface NewDetail : UIViewController <ASIHTTPRequestDelegate,ViewProtocol,ASIHTTPRequestDelegate,UIWebViewDelegate>
{
  //  MsgDetail *msgDetail;
}


@property (strong,nonatomic) UIWebView *m_webView;

@property (strong, nonatomic) IBOutlet UIView *m_myView;
@property (nonatomic,strong) MsgDetail *m_msgDetail;
@property (copy,nonatomic) NSString *m_ids;
@property int m_newsCategory;
@property (strong,nonatomic) SingleNews *m_singleNews;

- (void) setMyDelegate:(id<TabBarProtocol>) m_delegate;

@end
