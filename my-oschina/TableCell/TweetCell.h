//
//  TweetCell.h
//  my-oschina
//
//  Created by jjx on 14/11/6.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "TweetMsg.h"

@interface TweetCell : UITableViewCell

@property (strong,nonatomic) UIImageView *m_avator;
@property (strong,nonatomic) UILabel *m_author;
@property (strong,nonatomic) UILabel *m_title;
@property (strong,nonatomic) UILabel *m_pullDate;
@property (strong,nonatomic) UIImageView *m_icon;
@property (strong,nonatomic) UILabel *m_count;

@property (strong,nonatomic) TweetMsg *m_msg;

- (void) setContent:(TweetMsg *)msg;

@end
