//
//  OwnViewControl.h
//  my-oschina
//
//  Created by jjx on 14/11/7.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewControl.h"
#import "PullTableView.h"
#import "ASIHTTPRequest.h"
#import "prefix_define.h"
#import "XmlParser.h"
#import "OwnMsg.h"
#import "OwnCell.h"
#import "OwnCellImg.h"

@interface OwnViewControl : UIViewController <UIActionSheetDelegate,PullTableViewDelegate,UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>

@property int m_uid;
@property (weak, nonatomic) IBOutlet PullTableView *pullTableView;
- (IBAction)segSender:(id)sender;

@property int m_category;
@property (strong,nonatomic) NSMutableArray *m_newsArray;
@property int m_countPage;
@property BOOL m_isLoadOver;


@end
