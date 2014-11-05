//
//  QuestionCell.m
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "QuestionCell.h"

@implementation QuestionCell

@synthesize avatorView;
@synthesize titleLable;
@synthesize authorLabel;
@synthesize answerTitle;
@synthesize answerCount;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    return self;
    
}

- (void) setContent:(QuestionMsg *)msg
{
    if(self)
    {
        [self initView:msg];
    }
}

- (void) initView:(QuestionMsg *)msg
{
    
    if(self.avatorView)
    {
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:avatorView];
        [self.avatorView removeFromSuperview];
    }
    
    if(self.titleLable)
    {
        [self.titleLable removeFromSuperview];
    }
    
    if(self.authorLabel)
    {
        [self.authorLabel removeFromSuperview];
    }
    
    if(self.answerCount)
    {
        [self.answerCount removeFromSuperview];
    }
    
    if(self.answerTitle)
    {
        [self.answerTitle removeFromSuperview];
    }
    
    avatorView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    avatorView.image = [UIImage imageNamed:@"big_avatar_loading"];
    
    avatorView.imageURL = [NSURL URLWithString:msg.portrait];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 240, 30)];
    titleLable.text = msg.title;
    titleLable.font = [UIFont fontWithName:@"" size:14];
    
    authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 240, 30)];
    authorLabel.text = msg.author;
    authorLabel.font = [UIFont fontWithName:@"" size:10];
    authorLabel.textColor = [UIColor blueColor];
    
    answerCount = [[UILabel alloc] initWithFrame:CGRectMake(320, 10, 40, 30)];
    answerCount.text = msg.answerCount;
    authorLabel.font = [UIFont fontWithName:@"" size:10];

    answerTitle = [[UILabel alloc] initWithFrame:CGRectMake(310, 30, 40, 30)];
    answerTitle.text = @"回答";
    authorLabel.font = [UIFont fontWithName:@"" size:10];
    
    [self addSubview:avatorView];
    [self addSubview:titleLable];
    [self addSubview:authorLabel];
    [self addSubview:answerCount];
    [self addSubview:answerTitle];
}


@end
