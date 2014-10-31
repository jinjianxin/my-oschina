//
//  CommentsDetail.m
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "CommentsDetail.h"

@implementation CommentsDetail

@synthesize msgDetail;
@synthesize pullTabView;
@synthesize newsCategory;
@synthesize commentArray;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = self.view.bounds;
    
    pullTabView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width , rect.size.height)];
    
    [self.view addSubview:pullTabView];
    
    commentArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    pullTabView.delegate = self;
    pullTabView.dataSource = self;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    //    http://www.oschina.net/action/api/comment_list?catalog=1&id=56627&pageIndex=0&pageSize=20
    /*NSString *str = [NSString stringWithFormat:@"%@catalog=%d&id=%@&pageIndex=%d&pageSize=%d",comments_detail,self.newsCategory,msgDetail.ids,0,20];*/
    
    NSString *str = @"http://www.oschina.net/action/api/comment_list?catalog=1&id=56627&pageIndex=0&pageSize=20";
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    [request startAsynchronous];
    

    
}


- (void) pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    
}

- (void) pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
    NSString *respose = [request responseString];
    
    commentArray =  [XmlParser commentsDetailParser:respose];
    
    [self.pullTabView reloadData];
}


- (void) requestFailed:(ASIHTTPRequest *)request
{
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [commentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *tag = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tag];
    
    if(cell ==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
    }
    
    CommentMsgDetails *msg = [commentArray objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = msg.cContent;
    
    return cell;
}

@end
