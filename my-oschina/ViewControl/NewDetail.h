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


@interface NewDetail : UIViewController <ASIHTTPRequestDelegate>
{
  //  MsgDetail *msgDetail;
}


@property (strong,nonatomic) UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIView *myView;
@property (nonatomic,strong) MsgDetail *msgDetail;
@property int newsCategory;

@end
