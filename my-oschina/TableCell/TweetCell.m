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
    }
}


@end
