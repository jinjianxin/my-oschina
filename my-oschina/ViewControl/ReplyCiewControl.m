//
//  ReplyCiewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/3.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "ReplyCiewControl.h"

@implementation ReplyCiewControl

@synthesize author;
@synthesize content;
@synthesize replyTextView;
@synthesize msg;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *_btnPub = [[UIBarButtonItem alloc] initWithTitle:@"回复" style:UIBarButtonItemStyleDone target:self action:@selector(clickReply:)];
    self.navigationItem.rightBarButtonItem = _btnPub;

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    
    
    author = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 360, 50)];
    author.font = [UIFont fontWithName:@"Arial" size:18];
    author.text = msg.cAuthor;
    
    
    content = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 360, 50)];
    content.font = [UIFont fontWithName:@"Arial" size:16];
    content.text = msg.cContent;
    content.numberOfLines = 0;
    [content sizeToFit];
    
    
    replyTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 300, 360, 50)];
    replyTextView.text = @"点此输入内容";
    replyTextView.textColor = [UIColor lightGrayColor];
    
    [replyTextView setDelegate:self];

    
    [self.view addSubview:author];
    [self.view addSubview:content];
    [self.view addSubview:replyTextView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

}

- (IBAction)clickReply:(id)sender
{

}

- (void) dismissKeyboard
{
    [replyTextView resignFirstResponder];
}



-(BOOL)textViewShouldBeginEditing:(UITextView *)textField
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-215, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextField *)textField
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+215, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{

}

@end

