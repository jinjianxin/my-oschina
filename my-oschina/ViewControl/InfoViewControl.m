//
//  InfoViewControl.m
//  my-oschina
//
//  Created by jjx on 14/10/29.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "InfoViewControl.h"
#import "XmlParser.h"
#import "MsgCell.h"
#import "MsgDetail.h"
#import "prefix_define.h"

@implementation InfoViewControl

@synthesize m_pullTableView;
@synthesize m_newsArray;
@synthesize m_newsCategory;
@synthesize m_pageIndex;

- (void)loadView
{
    [super loadView];

    m_newsCategory = 1;
    m_pageIndex = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.m_pullTableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.m_pullTableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_pullTableView.pullTextColor = [UIColor blackColor];
    self.m_pullTableView.pullDelegate = self;
    self.m_pullTableView.delegate = self;
    self.m_pullTableView.dataSource = self;

    m_newsArray = [[NSMutableArray alloc] initWithCapacity:10];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    [self loadContent];
}

/**
 *  从网络请求内容
 */
- (void)loadContent
{
    NSString* str;

    m_pageIndex = (int)[m_newsArray count] / 20;

    if (m_newsCategory == 1) {
        NSLog(@"%d", m_pageIndex);

        str = [NSString stringWithFormat:@"%@catalog=%d&pageIndex=%d&pageSize=%d",
                                         new_url, 1, m_pageIndex, 20];
        NSLog(@"pageIndex = %d", m_pageIndex);
    }
    else if (m_newsCategory == 2) {
        str = [NSString stringWithFormat:@"%@type=latest&pageIndex=%d&pageSize=%d",
                                         blog_url, m_pageIndex, 20];
    }
    else if (m_newsCategory == 3) {
        str = [NSString stringWithFormat:@"%@type=recommend&pageIndex=%d&pageSize=%d",
                                         blog_url, m_pageIndex, 20];
    }
    
    

    NSURL* url = [NSURL URLWithString:str];
    
    NSLog(@"%@",url);

    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];

    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (!self.m_pullTableView.pullTableIsRefreshing) {
        self.m_pullTableView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(refreshTable)
                   withObject:nil
                   afterDelay:0.1f];
    }
}

- (void)requestFinished:(ASIHTTPRequest*)request
{
    NSString* responseString = [request responseString];

    if (m_newsCategory == 1) {
        NSMutableArray* array = [XmlParser newsParser:responseString];

        [m_newsArray addObjectsFromArray:array];
    }
    else if (m_newsCategory == 2) {
        NSMutableArray* array = [XmlParser blogParser:responseString];

        [m_newsArray addObjectsFromArray:array];
    }
    else if (m_newsCategory == 3) {

        NSMutableArray* array = [XmlParser blogParser:responseString];

        [m_newsArray addObjectsFromArray:array];
    }

    [m_pullTableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest*)request
{
    
}

- (CGFloat)tableView:(UITableView*)tableView
    heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 55;
}

- (NSInteger)tableView:(UITableView*)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return [m_newsArray count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* tag = @"NewCell";

    MsgCell* cell = [tableView dequeueReusableCellWithIdentifier:tag];

    MsgDetail* news = [m_newsArray objectAtIndex:[indexPath row]];

    cell.m_title.text = news.m_titile;
    cell.m_author.text = news.m_author;

    cell.m_pullData.text = news.m_pullDate;
   
    return cell;
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

- (IBAction)categorySender:(id)sender
{
    UISegmentedControl* segmentedControl = (UISegmentedControl*)sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;

    m_newsCategory = (int)selectedSegment + 1;

    [self clear];
    [self loadContent];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    MsgDetail* msg = [m_newsArray objectAtIndex:[indexPath row]];
    [Helper pushNewsDetail:self.navigationController andMag:msg andCategory:m_newsCategory];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
}

- (void)clear
{
    [m_newsArray removeAllObjects];
    [m_pullTableView reloadData];
}

- (IBAction)searchSender:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    SearchViewController *searchControl =[storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    searchControl.view.backgroundColor = [UIColor whiteColor];
    
    searchControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchControl animated:YES];
    
    /*
    
    SearchViewController *searchControl = [[SearchViewController alloc] init];
    searchControl.view.backgroundColor = [UIColor whiteColor];
    
    searchControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchControl animated:YES];*/
    
}
@end
