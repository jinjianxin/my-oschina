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

@property (weak, nonatomic) IBOutlet UIImageView *m_avator;

@property (weak, nonatomic) IBOutlet UILabel *m_author;

@property (weak, nonatomic) IBOutlet UILabel *m_answerCount;
@property (weak, nonatomic) IBOutlet UILabel *m_title;

@property (strong,nonatomic) TweetMsg *m_msg;
@property (weak, nonatomic) IBOutlet UILabel *m_pullDate;

- (void) setContent:(TweetMsg *)msg;

@end
