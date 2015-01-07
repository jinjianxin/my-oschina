//
//  CommentsDetail.h
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgDetail.h"
#import "PullTableView.h"
#import "ASIHTTPRequest.h"
#import "prefix_define.h"
#import "XmlParser.h"
#import "CommentsDetail.h"
#import "CommentCell.h"
#import "ReplyViewControl.h"
#import "CustomProtocol.h"
#import "PubComments.h"
#import "UIView+Toast.h"
#import "MBProgressHUD.h"

@interface CommentsDetail : UIViewController <PullTableViewDelegate, ASIHTTPRequestDelegate, UITableViewDelegate, UITableViewDataSource, ViewProtocol, MBProgressHUDDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) MsgDetail* m_msgDetail;
@property (weak, nonatomic) IBOutlet PullTableView* m_pullTabView;

@property (copy, nonatomic) NSString* m_ids;
@property int m_newsCategory;
@property (nonatomic, strong) NSMutableArray* m_commentArray;
@property int m_pageIndex;
@property BOOL m_isLoadOver;
- (void)setMyDelegate:(id<TabBarProtocol>)m_delegate;
@property int m_parentID;
@property id m_body;

@end
