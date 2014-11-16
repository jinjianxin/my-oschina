//
//  TweetViewControl.h
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "prefix_define.h"
#import "ASIHTTPRequest.h"
#import "XmlParser.h"
#import "TweetCell.h"
#import "TweetDetailViewControl.h"
#import "CommentsDetail.h"
#import "CustomProtocol.h"
#import "MyUITabBarControl.h"


@interface TweetViewControl : UIViewController <PullTableViewDelegate,UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate>

@property (weak, nonatomic) IBOutlet PullTableView *pullTableView;

- (IBAction)segSender:(id)sender;
@property int m_uid;
@property NSMutableArray *m_newsArray;
@property int m_countPage;


@end
