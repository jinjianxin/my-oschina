//
//  QuestionViewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/10.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "QuestionViewControl.h"

@interface QuestionViewControl ()

@end

@implementation QuestionViewControl

@synthesize newsCategory;
@synthesize newsArray;
@synthesize pullTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.pullTableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.pullTableView.pullBackgroundColor = [UIColor whiteColor];
    self.pullTableView.pullTextColor = [UIColor blackColor];
    self.pullTableView.pullDelegate = self;
    
    self.pullTableView.delegate = self;
    self.pullTableView.dataSource = self;
    
    newsArray = [[NSMutableArray alloc] initWithCapacity:2];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadContent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTable {
    self.pullTableView.pullLastRefreshDate = [NSDate date];
    self.pullTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable {
    self.pullTableView.pullTableIsLoadingMore = NO;
    
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

- (void) loadContent
{
    int count = (int)[newsArray count];
    
    NSString *str = [NSString stringWithFormat:@"%@catalog=%d&pageIndex=%d&pageSize=20",question_url,newsCategory,count/20];
    
    
    NSLog(@"str = %@",str);
    
    NSURL *url = [NSURL URLWithString:str];
    
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSArray *array= [XmlParser questionNewParser:responseString];
    
    [newsArray addObjectsFromArray:array];
    
    [self.pullTableView reloadData];
    
}

-(void) requestFailed:(ASIHTTPRequest *)request
{
    
}

- (IBAction)questionSelect:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    newsCategory = (int)selectedSegment+1;
    
    [newsArray removeAllObjects];
    [self.pullTableView reloadData];
    
    [self loadContent];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newsArray count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tag = @"tag";
    
    QuestionCell *cell  = [tableView dequeueReusableCellWithIdentifier:tag];
    
    if(cell ==nil)
    {
        cell = [[QuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
    }
    
    int index = (int)[indexPath row];
    QuestionMsg *msg = [newsArray objectAtIndex:index];
    cell.tag = [self newsCategory];
    
    [cell setContent:msg];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionMsg *msg  = [newsArray objectAtIndex:[indexPath row]];
    
    UITabBarController *newTab = [[UITabBarController alloc] init];
    
    
    PostDetails *postDetail = [[PostDetails alloc] init];
    postDetail.view.backgroundColor = [UIColor whiteColor];
    postDetail.tabBarItem.title = @"详情";
    postDetail.tabBarItem.image = [UIImage imageNamed:@"detail"];
    postDetail.ids = msg.ids ;
    
    CommentsDetail *commentDetail = [[CommentsDetail alloc] init];
    commentDetail.tabBarItem.title = @"评论";
    commentDetail.view.backgroundColor = [UIColor whiteColor];
    commentDetail.tabBarItem.image = [UIImage imageNamed:@"commentlist"];
    commentDetail.ids = msg.ids;
    commentDetail.newsCategory = 2;

    
    ShareDetail *shareDetail = [[ShareDetail alloc] init];
    shareDetail.tabBarItem.title=@"分享";
    shareDetail.view.backgroundColor = [UIColor whiteColor];
    shareDetail.tabBarItem.image = [UIImage imageNamed:@"share"];
    
    ReportViewControl *reportView = [[ReportViewControl alloc] init];
    reportView.tabBarItem.title=@"举报";
    reportView.view.backgroundColor = [UIColor whiteColor];
    reportView.tabBarItem.image = [UIImage imageNamed:@"share"];

    
    newTab.viewControllers = [NSArray arrayWithObjects:postDetail,commentDetail,shareDetail,reportView, nil];
    newTab.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newTab animated:YES];
}

@end
