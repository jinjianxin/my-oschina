//
//  SubmitQuestion.m
//  my-oschina
//
//  Created by jjx on 14/11/24.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "SubmitQuestion.h"

@interface SubmitQuestion ()

@end

@implementation SubmitQuestion

//@synthesize m_contentView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_contentView.layer.borderColor = UIColor.grayColor.CGColor;
    self.m_contentView.layer.borderWidth = 1;
    self.m_contentView.layer.cornerRadius = 6;
    self.m_contentView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)m_segSender:(id)sender {
}
- (IBAction)m_switchSender:(id)sender {
}
@end
