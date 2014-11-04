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


@interface QuestionViewControl : UITableViewController <RefreshTableHeaderDelegate,ASIHTTPRequestDelegate>
{
    RefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *questionSeg;
- (IBAction)questionSelect:(id)sender;

@property int newsCategory;
@property (strong,nonatomic) NSMutableArray *newsArray;

@end
