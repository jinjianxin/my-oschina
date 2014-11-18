//
//  CommentsDetail.m
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "CommentsDetail.h"

@implementation CommentsDetail
{
    id<TabBarProtocol> mydelegate;
}

@synthesize msgDetail;
@synthesize pullTabView;
@synthesize newsCategory;
@synthesize commentArray;
@synthesize ids;
@synthesize pageIndex;
@synthesize isLoadOver;
@synthesize parentID;
@synthesize body;


-(void)loadView
{
    [super loadView];
    
    isLoadOver = NO;
    
    CGRect rect = self.view.bounds;
    
    pullTabView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 65, rect.size.width , rect.size.height-65)];
    
    pullTabView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:pullTabView];
    
    commentArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    pullTabView.delegate = self;
    pullTabView.dataSource = self;
    
    self.pullTabView.pullDelegate = self;
    
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self loadContent];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [mydelegate setBarTitle:@"评论列表" andButtonTitle:@"发表评论" andProtocol:self];
}

-(void)barButttonClick
{
    PubComments *pubComments = [[PubComments alloc] init];
    pubComments.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:pubComments animated:YES];
    

}

-(void)setMyDelegate:(id<TabBarProtocol>)delegate
{
    mydelegate = delegate;
}

- (void) loadContent
{
    int count = (int)[commentArray count]/20;
    pageIndex = count;
    
    NSString *str= nil;
    
    if(newsCategory ==5)
    {
        str = [NSString stringWithFormat:@"%@?id=%d&pageIndex=%d&pageSize=%d", api_blogcomment_list, self.parentID, pageIndex, 20];
    }
    else{
        str = [NSString stringWithFormat:@"%@catalog=%d&id=%@&pageIndex=%d&pageSize=%d",comments_detail,self.newsCategory,ids,count,20];
    }

    
    NSLog(@"url = %@",str);
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    [self refreshTable];
    
}

- (void)refreshTable {
    self.pullTabView.pullLastRefreshDate = [NSDate date];
    self.pullTabView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable {
    self.pullTabView.pullTableIsLoadingMore = NO;
    
    if(!isLoadOver)
    {
        [self loadContent];
    }
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
    
    if(array.count <20)
    {
        isLoadOver = YES;
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
