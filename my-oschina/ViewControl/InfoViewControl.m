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

@synthesize pullTableView;
@synthesize newsArray;
@synthesize newsCategory;
@synthesize pageIndex;

- (void)loadView
{
    [super loadView];

    newsCategory = 1;
    pageIndex = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.pullTableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.pullTableView.pullBackgroundColor = [UIColor whiteColor];
    self.pullTableView.pullTextColor = [UIColor blackColor];
    self.pullTableView.pullDelegate = self;
    self.pullTableView.delegate = self;
    self.pullTableView.dataSource = self;

    newsArray = [[NSMutableArray alloc] initWithCapacity:10];

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

    pageIndex = (int)[newsArray count] / 20;

    if (newsCategory == 1) {
        NSLog(@"%d", pageIndex);

        str = [NSString stringWithFormat:@"%@catalog=%d&pageIndex=%d&pageSize=%d",
                                         new_url, 1, pageIndex, 20];
        NSLog(@"pageIndex = %d", pageIndex);
    }
    else if (newsCategory == 2) {
        str = [NSString stringWithFormat:@"%@type=latest&pageIndex=%d&pageSize=%d",
                                         blog_url, pageIndex, 20];
    }
    else if (newsCategory == 3) {
        str = [NSString stringWithFormat:@"%@type=recommend&pageIndex=%d&pageSize=%d",
                                         blog_url, pageIndex, 20];
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

    if (!self.pullTableView.pullTableIsRefreshing) {
        self.pullTableView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(refreshTable)
                   withObject:nil
                   afterDelay:0.1f];
    }
}

- (void)requestFinished:(ASIHTTPRequest*)request
{
    NSString* responseString = [request responseString];

    if (newsCategory == 1) {
        NSMutableArray* array = [XmlParser newsParser:responseString];

        [newsArray addObjectsFromArray:array];
    }
    else if (newsCategory == 2) {
        NSMutableArray* array = [XmlParser blogParser:responseString];

        [newsArray addObjectsFromArray:array];
    }
    else if (newsCategory == 3) {

        NSMutableArray* array = [XmlParser blogParser:responseString];

        [newsArray addObjectsFromArray:array];
    }

    [pullTableView reloadData];
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
    return [newsArray count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* tag = @"NewCell";

    MsgCell* cell = [tableView dequeueReusableCellWithIdentifier:tag];

    MsgDetail* news = [newsArray objectAtIndex:[indexPath row]];

    cell.title.text = news.titile;
    cell.author.text = news.author;

    cell.pullData.text = news.pullDate;
   
    return cell;
}

- (void)refreshTable
{
    self.pullTableView.pullLastRefreshDate = [NSDate date];
    self.pullTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    self.pullTableView.pullTableIsLoadingMore = NO;

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

    newsCategory = (int)selectedSegment + 1;

    [self clear];
    [self loadContent];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    MsgDetail* msg = [newsArray objectAtIndex:[indexPath row]];
    [Helper pushNewsDetail:self.navigationController andMag:msg andCategory:newsCategory];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
}

- (void)clear
{
    [newsArray removeAllObjects];
    [pullTableView reloadData];
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
