//
//  OwnViewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/7.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "OwnViewControl.h"


@implementation OwnViewControl

@synthesize m_uid;
@synthesize pullTableView;
@synthesize m_category;
@synthesize m_newsArray;
@synthesize m_countPage;

 - (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.pullTableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.pullTableView.pullBackgroundColor = [UIColor whiteColor];
    self.pullTableView.pullTextColor = [UIColor blackColor];
    self.pullTableView.pullDelegate = self;
    
    pullTableView.dataSource = self;
    pullTableView.delegate = self;
    
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    m_newsArray = [[NSMutableArray alloc] initWithCapacity:2];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [userData stringForKey:@"user"];
    NSString *pwd = [userData stringForKey:@"pwd"];
    NSString *uid = [userData stringForKey:@"uid"];
    
    if(userName == nil || pwd == nil || uid == nil)
    {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请登陆后查看信息" delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:nil otherButtonTitles:@"登陆", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [actionSheet showInView:self.view];
    }
    
    if(uid!=nil)
    {
        m_uid = [uid intValue];
    }
    
    [self loadContent];
    
}

- (void) loadContent
{
    int index = (int)[m_newsArray count]/20;
    m_countPage = index;
    
    NSString *str = [NSString stringWithFormat:@"%@?catalog=%d&pageIndex=%d&pageSize=%d&uid=%d",api_active_list,self.m_category,index,20,m_uid];
    
    NSLog(@"%@",str);
    
    NSURL *url = [NSURL URLWithString:str];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    [request startAsynchronous];

}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *respose = [request responseString];
    
    if(m_countPage == [m_newsArray count]/20)
    {
        [m_newsArray removeAllObjects];
    }
    
    NSArray *array = [XmlParser ownNewParser:respose];
    
    
    [m_newsArray addObjectsFromArray:array];
    
    [pullTableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
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




- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==0)
    {
        LoginViewControl *loginViewControl = [[LoginViewControl alloc] init];
        loginViewControl.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:loginViewControl animated:YES];
    }
}

- (IBAction)segSender:(id)sender {
    
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    
    m_category =  (int)seg.selectedSegmentIndex+1;
    
    [m_newsArray removeAllObjects];
    [pullTableView reloadData];
    
    [self loadContent];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index =  (int)[indexPath row];
    
    NSLog(@"index = %d",index);
    
    OwnMsg *msg = [m_newsArray objectAtIndex:[indexPath row]];
    
    if(msg !=nil)
    {
        return msg.m_height;
    }
    else{
        return 63;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_newsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *tag = @"tag";
    
    OwnCell *cell = [tableView dequeueReusableCellWithIdentifier:tag];
    
    if(cell ==nil)
    {
        cell = [[OwnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
    }
    
    OwnMsg *msg = [m_newsArray objectAtIndex:[indexPath row]];
    
    [cell setContent:msg];
    
    return cell;
}

@end
