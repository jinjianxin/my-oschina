//
//  InfoViewControl.h
//  my-oschina
//
//  Created by jjx on 14/10/29.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "ASIHTTPRequest.h"
#import "NewDetailsControl.h"
#import "NewDetail.h"
#import "CommentsDetail.h"
#import "ShareDetail.h"
#import "TestViewController.h"
#import "SearchViewController.h"

@interface InfoViewControl : UIViewController <PullTableViewDelegate,ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
{
   // PullTableView *pullTableView;
}
- (IBAction)searchSender:(id)sender;

@property (strong,nonatomic) NSMutableArray *newsArray;
@property (weak, nonatomic) IBOutlet PullTableView *pullTableView;
- (IBAction)categorySender:(id)sender;



@property int newsCategory;
@property int pageIndex;

@end
