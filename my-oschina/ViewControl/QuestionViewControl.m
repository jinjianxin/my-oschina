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

@implementation QuestionViewControl {

    MBProgressHUD* m_progressHUD;
}

@synthesize m_newsCategory;
@synthesize m_newsArray;
@synthesize m_pullTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    self.m_pullTableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.m_pullTableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_pullTableView.pullTextColor = [UIColor blackColor];
    self.m_pullTableView.pullDelegate = self;

    self.m_pullTableView.delegate = self;
    self.m_pullTableView.dataSource = self;

    m_newsArray = [[NSMutableArray alloc] initWithCapacity:2];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self loadContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTable
{
    self.m_pullTableView.pullLastRefreshDate = [NSDate date];
    self.m_pullTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    self.m_pullTableView.pullTableIsLoadingMore = NO;

    [self loadContent];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable)
               withObject:nil
               afterDelay:0.2f];
}

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.2f];
}

- (void)loadContent
{
    int count = (int)[m_newsArray count];

    NSString* str = [NSString stringWithFormat:@"%@catalog=%d&pageIndex=%d&pageSize=20", question_url, m_newsCategory, count / 20];

    NSLog(@"str = %@", str);

    NSURL* url = [NSURL URLWithString:str];

    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];

    [request setDelegate:self];
    [request startAsynchronous];

    m_progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:m_progressHUD];

    m_progressHUD.labelText = @"Loading";

    [m_progressHUD show:YES];
}

- (void)hudWasHidden:(MBProgressHUD*)hud
{
    [m_progressHUD removeFromSuperview];
    m_progressHUD = nil;
}

- (void)requestFinished:(ASIHTTPRequest*)request
{
    NSString* responseString = [request responseString];
    NSArray* array = [XmlParser questionNewParser:responseString];

    [m_newsArray addObjectsFromArray:array];

    [self.m_pullTableView reloadData];

    [m_progressHUD hide:YES];
}

- (void)requestFailed:(ASIHTTPRequest*)request
{

    [m_progressHUD hide:YES];

    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:
                                                      @"警告"
                                                        message:@"网络连接错误"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
}

- (IBAction)questionSelect:(id)sender
{
    UISegmentedControl* segmentedControl = (UISegmentedControl*)sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;

    m_newsCategory = (int)selectedSegment + 1;

    [m_newsArray removeAllObjects];
    [self.m_pullTableView reloadData];

    [self loadContent];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_newsArray count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* tag = @"tag";

    QuestionCell* cell = [tableView dequeueReusableCellWithIdentifier:tag];

    int index = (int)[indexPath row];

    QuestionMsg* msg = [m_newsArray objectAtIndex:index];
    cell.tag = [self m_newsCategory];

    [cell setContent:msg];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    QuestionMsg* msg = [m_newsArray objectAtIndex:[indexPath row]];

    /*
    MyUITabBarControl *newTab = [[MyUITabBarControl alloc] init];
    newTab.title = @"问答详情";
    
    
    PostDetails *postDetail = [[PostDetails alloc] init];
    postDetail.view.backgroundColor = [UIColor whiteColor];
    postDetail.tabBarItem.title = @"详情";
    postDetail.tabBarItem.image = [UIImage imageNamed:@"detail"];
    postDetail.ids = msg.ids ;
    [postDetail setMyDelegate:newTab];
    
    UIStoryboard *stroboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    CommentsDetail *commentDetail = [stroboard instantiateViewControllerWithIdentifier:@"CommentsDetail"];
    commentDetail.view.backgroundColor = [UIColor whiteColor];
    commentDetail.tabBarItem.image = [UIImage imageNamed:@"commentlist"];
    commentDetail.tabBarItem.title = @"评论";
    commentDetail.ids = msg.ids;
    commentDetail.newsCategory = 2;
    [commentDetail setMyDelegate:newTab];

    
    ShareDetail *shareDetail = [stroboard instantiateViewControllerWithIdentifier:@"ShareDetail"];
    shareDetail.tabBarItem.title=@"分享";
    shareDetail.view.backgroundColor = [UIColor whiteColor];
    shareDetail.tabBarItem.image = [UIImage imageNamed:@"share"];
    [shareDetail setMyDelegate:newTab];
    
    ReportViewControl *reportView = [[ReportViewControl alloc] init];
    reportView.tabBarItem.title=@"举报";
    reportView.view.backgroundColor = [UIColor whiteColor];
    reportView.tabBarItem.image = [UIImage imageNamed:@"share"];
    [reportView setMyDelegate:newTab];

    [postDetail viewDidAppear:YES];
    
    newTab.viewControllers = [NSArray arrayWithObjects:postDetail,commentDetail,shareDetail,reportView, nil];
    newTab.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newTab animated:YES]; */

    [Helper pushQuestion:self.navigationController andIds:msg.m_ids andCategory:2];
}

- (IBAction)m_submitSender:(id)sender
{

    UIStoryboard* stroboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SubmitQuestion* submitQuestion = [stroboard instantiateViewControllerWithIdentifier:@"SubmitQuestion"];

    submitQuestion.view.backgroundColor = [UIColor whiteColor];

    submitQuestion.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:submitQuestion animated:YES];
}

@end
