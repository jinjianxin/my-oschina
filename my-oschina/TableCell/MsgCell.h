//
//  MsgCell.h
//  my-oschina
//
//  Created by jjx on 14/10/29.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;


@property (weak, nonatomic) IBOutlet UILabel *author;

@property (weak, nonatomic) IBOutlet UILabel *pullData;

@end

