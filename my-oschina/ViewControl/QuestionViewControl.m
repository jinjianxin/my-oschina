//
//  QuestionViewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/4.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "QuestionViewControl.h"


@implementation QuestionViewControl

@synthesize newsCategory;
@synthesize newsArray;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    
    if (_refreshHeaderView == nil) {
        
        RefreshTableHeaderView *view = [[RefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
    
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
    
    newsArray = [[NSMutableArray alloc] initWithCapacity:2];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadContent];
    
}

- (void) loadContent
{
    //http://www.oschina.net/action/api/post_list?catalog=1&pageIndex=0&pageSize=20
    
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
    
    [self.tableView reloadData];

}

-(void) requestFailed:(ASIHTTPRequest *)request
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(RefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(RefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(RefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _reloading = YES;
    
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
}


- (IBAction)questionSelect:(id)sender {    
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    newsCategory = (int)selectedSegment+1;
    
    [newsArray removeAllObjects];
    [self.tableView reloadData];
    
    [self loadContent];

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newsArray count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tag = @"tag";
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:tag];
    
    if(cell ==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
    }
    
    cell.textLabel.text = @"test";
    
    return cell;
}

@end
