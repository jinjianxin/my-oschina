//
//  TestViewControl.h
//  my-oschina
//
//  Created by jjx on 14/11/21.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestCell.h"

@interface TestViewControl : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
