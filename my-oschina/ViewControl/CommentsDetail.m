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
@synthesize ids;
@synthesize pageIndex;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = self.view.bounds;
    
    pullTabView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width , rect.size.height)];
    
    [self.view addSubview:pullTabView];
    
    commentArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    pullTabView.delegate = self;
    pullTabView.dataSource = self;
    
    self.pullTabView.pullDelegate = self;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadContent];

}

- (void) loadContent
{
    int count = (int)[commentArray count];
    pageIndex = count;
    
    NSString *str = [NSString stringWithFormat:@"%@catalog=%d&id=%@&pageIndex=%d&pageSize=%d",comments_detail,self.newsCategory,ids,count/20,20];
    
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (void)refreshTable {
    self.pullTabView.pullLastRefreshDate = [NSDate date];
    self.pullTabView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable {
    self.pullTabView.pullTableIsLoadingMore = NO;
    
    [self loadContent];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView {
    [self performSelector:@selector(loadMoreDataToTable)
               withObject:nil
               afterDelay:0.2f];
}

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView {
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.2f];
}


- (void) requestFinished:(ASIHTTPRequest *)request
{
    NSString *respose = [request responseString];
    
    NSArray *array =  [XmlParser commentsDetailParser:respose];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:1];

    [tempArray addObjectsFromArray:commentArray];
    [tempArray addObjectsFromArray:array];
    
    if(pageIndex == [tempArray count]/20 )
    {
        [commentArray removeAllObjects];
    }
    
    [commentArray addObjectsFromArray:array];
    
    [self.pullTabView reloadData];
}


- (void) requestFailed:(ASIHTTPRequest *)request
{
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentMsgDetails *msg  = [commentArray objectAtIndex:[indexPath row]];
    
    return msg.height;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [commentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tag = @"cell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:tag];
    
    if(cell ==nil)
    {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
    }
    
    CommentMsgDetails *msg = [commentArray objectAtIndex:[indexPath row]];
    [cell setContent:msg];

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReplyCiewControl *repleControl = [[ReplyCiewControl alloc] init];
    repleControl.view.backgroundColor = [UIColor whiteColor];
   
    int index = (int)[indexPath row];
    CommentMsgDetails *msg  = [commentArray objectAtIndex:index];
    repleControl.msg = msg;
    
    [self.navigationController pushViewController:repleControl animated:YES];
}

@end
