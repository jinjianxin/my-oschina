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
@synthesize m_newCategory;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [button setTitle:@"发表问题" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightChick:) forControlEvents:UIControlEventTouchDown];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = item;
    self.title = @"我要提问";
    
    self.m_contentView.layer.borderColor = UIColor.grayColor.CGColor;
    self.m_contentView.layer.borderWidth = 1;
    self.m_contentView.layer.cornerRadius = 6;
    self.m_contentView.layer.masksToBounds = YES;
}

- (void)rightChick:(id) sender
{
    NSString *title = self.m_title.text;
    NSString *content = self.m_contentView.text;
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:api_post_pub]];
    
    [request setPostValue:title forKey:@"title"];
    [request setPostValue:0 forKey:@"isNoticeMe"];
    [request setPostValue:[NSString stringWithFormat:@"%d",m_newCategory] forKey:@"catalog"];
    [request setPostValue:[Helper getUid] forKey:@"uid"];
    [request setPostValue:content forKey:@"content"];
    
    [request setDelegate:self];
    [request startAsynchronous];
  
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *response = request.responseString;
    
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:nil];
    
    assert(tbxml!=nil);
    TBXMLElement *root = tbxml.rootXMLElement;
    assert(root!=nil);
    TBXMLElement *_result = [TBXML childElementNamed:@"result" parentElement:root];
    assert(_result);
    
    TBXMLElement *_errorCode = [TBXML childElementNamed:@"errorCode" parentElement:_result];
    
    int errorCode = [[TBXML textForElement:_errorCode] intValue];
    
    if(errorCode ==1)
    {
        [self popoverPresentationController];
    }
    else{
        
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)m_segSender:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    m_newCategory = (int)seg.selectedSegmentIndex;
    
}


- (IBAction)m_switchSender:(id)sender {
}
@end
