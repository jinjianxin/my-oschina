//
//  QuestionCell.h
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionMsg.h"
#import "AsyncImageView.h"

@interface QuestionCell : UITableViewCell

@property (strong,nonatomic) UIImageView *avatorView;
@property (strong ,nonatomic) UILabel *titleLable;
@property (strong,nonatomic) UILabel *authorLabel;
@property (strong ,nonatomic) UILabel *answerTitle;
@property (strong,nonatomic) UILabel *answerCount;

- (void)setContent:(QuestionMsg *)msg;

@end
