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
#import "XmlParser.h"

@interface QuestionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *m_avatorView;
@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_answerTitle;
@property (weak, nonatomic) IBOutlet UILabel *m_answerCount;
@property (weak, nonatomic) IBOutlet UILabel *m_author;

/*
@property (strong,nonatomic) UIImageView *avatorView;
@property (strong ,nonatomic) UILabel *titleLable;
@property (strong,nonatomic) UILabel *authorLabel;
@property (strong ,nonatomic) UILabel *answerTitle;
@property (strong,nonatomic) UILabel *answerCount;
//分类*/

@property int tag;
- (void)setContent:(QuestionMsg *)msg;

@end
