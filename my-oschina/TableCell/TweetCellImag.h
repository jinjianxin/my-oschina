//
//  TweetCellImag.h
//  my-oschina
//
//  Created by jjx on 14/11/25.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "TweetMsg.h"


@interface TweetCellImag : UITableViewCell
- (void) setContent:(TweetMsg *)msg;

@property (weak, nonatomic) IBOutlet UIImageView *m_avator;
@property (weak, nonatomic) IBOutlet UILabel *m_author;
@property (weak, nonatomic) IBOutlet UILabel *m_answerCount;

@property (weak, nonatomic) IBOutlet UILabel *m_title;
@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;
@property (weak, nonatomic) IBOutlet UILabel *m_pullDate;


@end
