//
//  QuestionViewControl.h
//  my-oschina
//
//  Created by jjx on 14/11/4.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableHeaderView.h"
#import "ASIHTTPRequest.h"
#import "prefix_define.h"
#import "XmlParser.h"
#import "QuestionCell.h"
#import "PullTableView.h"
#import "NewDetail.h"
#import "CommentsDetail.h"
#import "ShareDetail.h"
#import "PostDetails.h"
#import "ReportViewControl.h"


@interface QuestionViewControl : UITableViewController <PullTableViewDelegate,ASIHTTPRequestDelegate>
{
    BOOL _reloading;
}

@property (strong, nonatomic) IBOutlet PullTableView *pullTableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *questionSeg;
- (IBAction)questionSelect:(id)sender;

@property int newsCategory;
@property (strong,nonatomic) NSMutableArray *newsArray;

@end
