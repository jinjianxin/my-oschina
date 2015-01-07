//
//  QuestionViewControl.h
//  my-oschina
//
//  Created by jjx on 14/11/10.
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
#import "MyUITabBarControl.h"
#import "SubmitQuestion.h"
#import "Helper.h"
#import "MBProgressHUD.h"

@interface QuestionViewControl : UIViewController <PullTableViewDelegate, ASIHTTPRequestDelegate, UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, UIAlertViewDelegate> {
    BOOL _reloading;
}
- (IBAction)m_submitSender:(id)sender;

@property (weak, nonatomic) IBOutlet PullTableView* m_pullTableView;

- (IBAction)questionSelect:(id)sender;

@property int m_newsCategory;
@property (strong, nonatomic) NSMutableArray* m_newsArray;
@end
