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

@interface CommentsDetail : UIViewController <PullTableViewDelegate,ASIHTTPRequestDelegate,UITableViewDelegate,UITableViewDataSource,ViewProtocol>

@property (nonatomic,weak) MsgDetail *msgDetail;
@property (weak, nonatomic) IBOutlet PullTableView *pullTabView;

@property (copy,nonatomic) NSString *ids;
@property int newsCategory;
@property (nonatomic,strong) NSMutableArray *commentArray;
@property int pageIndex;
@property BOOL isLoadOver;
- (void) setMyDelegate:(id<TabBarProtocol>)delegate;
@property int parentID;
@property id body;



@end
