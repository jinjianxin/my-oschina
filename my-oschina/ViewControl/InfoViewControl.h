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

@interface InfoViewControl : UITableViewController <PullTableViewDelegate,ASIHTTPRequestDelegate>
{
   // PullTableView *pullTableView;
}


@property (strong,nonatomic) IBOutlet PullTableView *pullTableView;
@property (strong,nonatomic) NSMutableArray *newsArray;

- (IBAction)categorySender:(id)sender;

@property int newsCategory;
@property int pageIndex;

@end
