//
//  ReplyCiewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/3.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "ReplyViewControl.h"

@implementation ReplyViewControl

@synthesize m_msg;

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.m_author.text = m_msg.m_author;
    self.m_content.text = m_msg.m_content;

    self.m_textView.layer.borderColor = UIColor.grayColor.CGColor;
    self.m_textView.layer.borderWidth = 1;
    self.m_textView.layer.cornerRadius = 6;
    self.m_textView.layer.masksToBounds = YES;

    /*
    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(keyboadWillShow:)
               name:UIKeyboardWillShowNotification
             object:nil];
    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(keyboardWillHide:)
               name:UIKeyboardWillHideNotification
             object:nil]; */

    UITapGestureRecognizer* gesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
}

- (void)hideKeyboard
{
    [self.m_textView resignFirstResponder];
}

- (void)keyboadWillShow:(NSNotification*)note
{
    NSDictionary* info = [note userInfo];
    NSValue* kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];

    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];

    CGRect finalKeyboardFrame = [self.view convertRect:keyboardFrame fromView:self.view.window];

    int kbHeight = finalKeyboardFrame.size.height;

    int height = kbHeight + self.m_bottom.constant;

    self.m_bottom.constant = height;

    [UIView animateWithDuration:animationDuration animations:^{
                 [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification*)note
{
    NSDictionary* info = [note userInfo];

    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    self.m_bottom.constant = 30;

    [UIView animateWithDuration:animationDuration animations:^{
                 [self.view layoutIfNeeded];
    }];
}

/*

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

}*/

@end
