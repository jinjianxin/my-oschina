//
//  CommentsDetail.m
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "CommentsDetail.h"

@implementation CommentsDetail {
    id<TabBarProtocol> mydelegate;
}

@synthesize m_msgDetail;
@synthesize m_pullTabView;
@synthesize m_newsCategory;
@synthesize m_commentArray;
@synthesize m_ids;
@synthesize m_pageIndex;
@synthesize m_isLoadOver;
@synthesize m_parentID;
@synthesize m_body;

- (void)loadView
{
    [super loadView];

    m_isLoadOver = NO;

    m_commentArray = [[NSMutableArray alloc] initWithCapacity:2];

    m_pullTabView.delegate = self;
    m_pullTabView.dataSource = self;

    self.m_pullTabView.pullDelegate = self;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [m_pullTabView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self loadContent];

    [mydelegate setBarTitle:@"评论列表" andButtonTitle:@"发表评论" andProtocol:self];
}

- (void)barButttonClick
{
    NSUserDefaults* userData = [NSUserDefaults standardUserDefaults];
    NSString* uid = [userData stringForKey:@"uid"];

    if (uid != nil) {

        PubComments* pubComments = [[PubComments alloc] init];
        pubComments.view.backgroundColor = [UIColor whiteColor];

        pubComments.m_id = m_ids;
        pubComments.m_catalog = [NSString stringWithFormat:@"%d", m_newsCategory];
        pubComments.m_uid = uid;
        pubComments.m_parent = self;

        [self.navigationController pushViewController:pubComments animated:YES];
    }
    else {
        [self.view makeToast:@"请先登陆"];
    }
}

- (void)setMyDelegate:(id<TabBarProtocol>)delegate
{
    mydelegate = delegate;
}

- (void)loadContent
{

    if (!m_isLoadOver) {

        int count = (int)[m_commentArray count] / 20;
        m_pageIndex = count;

        NSString* str = nil;

        if (m_newsCategory == 5) {
            str = [NSString stringWithFormat:@"%@?id=%d&pageIndex=%d&pageSize=%d", api_blogcomment_list, self.m_parentID, m_pageIndex, 20];
        }
        else {
            str = [NSString stringWithFormat:@"%@catalog=%d&id=%@&pageIndex=%d&pageSize=%d", comments_detail, self.m_newsCategory, m_ids, count, 20];
        }

        NSURL* url = [NSURL URLWithString:str];

        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];

        [request setDelegate:self];
        [request startAsynchronous];

        //[self refreshTable];
    }
}

- (void)refreshTable
{
    self.m_pullTabView.pullLastRefreshDate = [NSDate date];
    self.m_pullTabView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    self.m_pullTabView.pullTableIsLoadingMore = NO;

    if (!m_isLoadOver) {
        [self loadContent];
    }
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

- (void)requestFinished:(ASIHTTPRequest*)request
{
    NSString* respose = [request responseString];

    NSArray* array = [XmlParser commentsDetailParser:respose];

    if (array.count < 20) {
        m_isLoadOver = YES;
    }

    [m_commentArray addObjectsFromArray:array];

    [self.m_pullTabView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest*)request
{
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    CommentMsgDetails* msg = [m_commentArray objectAtIndex:[indexPath row]];

    return msg.m_height;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_commentArray count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* tag = @"cell";
    CommentCell* cell = [tableView dequeueReusableCellWithIdentifier:tag];

    if (cell == nil) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
    }

    CommentMsgDetails* msg = [m_commentArray objectAtIndex:[indexPath row]];
    [cell setContent:msg];

    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    UIStoryboard* stroboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    ReplyViewControl* repleControl = [stroboard instantiateViewControllerWithIdentifier:@"ReplyCiewControl"];
    repleControl.view.backgroundColor = [UIColor whiteColor];

    int index = (int)[indexPath row];
    CommentMsgDetails* msg = [m_commentArray objectAtIndex:index];
    repleControl.m_msg = msg;

    [self.navigationController pushViewController:repleControl animated:YES];
}

@end
