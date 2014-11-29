//
//  TweetCellImag.m
//  my-oschina
//
//  Created by jjx on 14/11/25.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "TweetCellImag.h"

@implementation TweetCellImag

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
        [AsyncImageView cancelPreviousPerformRequestsWithTarget:self.m_imageView];
        self.m_avator.imageURL = [NSURL URLWithString:msg.m_portrait];
        
        self.m_author.text = msg.m_author;
        self.m_answerCount.text = msg.m_commentCount;
        self.m_title.text = msg.m_body;
        self.m_pullDate.text = msg.m_pubDate;
        self.m_imageView.imageURL = [NSURL URLWithString:msg.m_imgSmall];
    }
}


@end

