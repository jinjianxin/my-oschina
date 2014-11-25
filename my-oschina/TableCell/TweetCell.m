//
//  TweetCell.m
//  my-oschina
//
//  Created by jjx on 14/11/6.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

/*
@synthesize m_avator;
@synthesize m_author;
@synthesize m_title;
@synthesize m_pullDate;
@synthesize m_icon;
@synthesize m_count;
@synthesize m_msg;
*/

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    return self;
    
}

- (void) setContent:(TweetMsg *)msg
{
    if(self)
    {
        [AsyncImageView cancelPreviousPerformRequestsWithTarget:self.m_avator];
        self.m_avator.imageURL = [NSURL URLWithString:msg.m_portrait];
        
        self.m_author.text = msg.m_author;
        self.m_answerCount.text = msg.m_commentCount;
        self.m_title.text = msg.m_body;
        self.m_pullDate.text = msg.m_pubDate;
       // self.m_pullDate.text = msg.m_pubDate;
        //self.m_title.numberOfLines = 0;
        
    }
}

/*

- (void) initView:(TweetMsg *)msg
{
    if(self.m_avator)
    {
        [AsyncImageView cancelPreviousPerformRequestsWithTarget:self.m_avator];
        [self.m_avator removeFromSuperview];
    }
    
    if(self.m_author)
    {
        [self.m_author removeFromSuperview];
    }
    
    if(self.m_title)
    {
        [self.m_title removeFromSuperview];
    }
    
    if(self.m_icon)
    {
        [self.m_icon removeFromSuperview];
    }
    
    if(self.m_count)
    {
        [self.m_count removeFromSuperview];
    }
    
    m_avator = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    m_avator.image = [UIImage imageNamed:@"account"];
    m_avator.imageURL = [NSURL URLWithString:msg.m_portrait];
    
    m_author = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 20)];
    m_author.textColor = [UIColor blueColor];
    m_author.font = [UIFont fontWithName:@"" size:12];
    m_author.text = msg.m_author;

    m_title = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 270, msg.m_height-40)];
    m_title.text = msg.m_body;
    m_title.font = [UIFont fontWithName:@"" size:14];
    m_title.numberOfLines = 0;
    
    m_icon = [[UIImageView alloc] initWithFrame:CGRectMake(340, 10, 20, 20)];
    m_icon.image = [UIImage imageNamed:@"comment"];
    
    m_count = [[UILabel alloc] initWithFrame:CGRectMake(345, 40, 20, 20)];
    m_count.textColor = [UIColor blueColor];
    m_count.font = [UIFont fontWithName:@"" size:12];
    m_count.text = msg.m_commentCount;

    
    
    [self addSubview:m_avator];
    [self addSubview:m_author];
    [self addSubview:m_title];
    [self addSubview:m_icon];
    [self addSubview:m_count];
    
    
}*/

@end
