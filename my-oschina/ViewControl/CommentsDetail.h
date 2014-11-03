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

@interface CommentsDetail : UIViewController <PullTableViewDelegate,ASIHTTPRequestDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) MsgDetail *msgDetail;
@property (nonatomic ,strong) PullTableView *pullTabView;
@property int newsCategory;
@property (nonatomic,strong) NSArray *commentArray;

@end
