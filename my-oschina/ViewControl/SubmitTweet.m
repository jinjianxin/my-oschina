//
//  SubmitTweet.m
//  my-oschina
//
//  Created by jjx on 14/11/24.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "SubmitTweet.h"

@interface SubmitTweet ()

@end

@implementation SubmitTweet

@synthesize m_imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *picture = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [picture setTitle:@"动态一下" forState:UIControlStateNormal];
    [picture setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [picture setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [picture addTarget:self action:@selector(tweetSender:) forControlEvents:UIControlEventTouchDown];

    
    UIBarButtonItem *itemPicture = [[UIBarButtonItem alloc] initWithCustomView:picture];
    
    UIButton *send = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
    [send setTitle:@"+图片" forState:UIControlStateNormal];
    [send setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [send setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [send addTarget:self action:@selector(pictureSender:) forControlEvents:UIControlEventTouchDown];

    UIBarButtonItem *itemSend = [[UIBarButtonItem alloc] initWithCustomView:send];
    
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:itemPicture,itemSend, nil];
    
    self.m_contentView.layer.borderColor = UIColor.grayColor.CGColor;
    self.m_contentView.layer.borderWidth = 1;
    self.m_contentView.layer.cornerRadius = 6;
    self.m_contentView.layer.masksToBounds = YES;

}

- (void)pictureSender:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"返回" otherButtonTitles:@"图库",@"拍照", nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //获取点击按钮的标题
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"拍照"])
    {
        UIImagePickerController *imgPicker = [UIImagePickerController new];
        imgPicker.delegate = self;
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:imgPicker animated:YES];
    }
    else if([buttonTitle isEqualToString:@"图库"])
    {
        UIImagePickerController *imgPicker = [UIImagePickerController new];
        imgPicker.delegate = self;
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:imgPicker animated:YES];
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self dismissModalViewControllerAnimated:YES];
    //添加到集合中
    UIImage * imgData = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.m_imageView.image = imgData;
    
    /*self.img.image = [Tool scale:imgData toSize:[Tool scaleSize:imgData.size]];
    [Config Instance].tweetCachePic = [Tool scale:imgData toSize:[Tool scaleSize:imgData.size]];
    [self clickBackground:nil];*/
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
     [self dismissModalViewControllerAnimated:YES];
}

-(void)tweetSender:(id)sender
{
    if(self.m_imageView.image !=nil)
    {
        //MyThread *thread = [[MyThread getInstance] pushTweet:self.m_contentView.text andImage:self.m_imageView.image];
        
       [[MyThread getInstance] pushTweet:self.m_contentView.text andImage:UIImageJPEGRepresentation(self.m_imageView.image, 0.7f)];
        
        [self popoverPresentationController];
        
    }
    else
    {
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:api_tweet_pub]];
        
        [request setPostValue:[Helper getUid] forKey:@"uid"];
        [request setPostValue:self.m_contentView.text forKey:@"msg"];
        
        [request setDelegate:self];
        [request startAsynchronous];
        
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *response = request.responseString;
    
    TBXML *tbxml  = [TBXML newTBXMLWithXMLString:response error:nil];
    
    assert(tbxml!=nil);
    
    TBXMLElement *root= tbxml.rootXMLElement;
    
    assert(root!=nil);

    TBXMLElement *_result = [TBXML childElementNamed:@"result" parentElement:root];
    assert(_result!=nil);
    
    TBXMLElement *_errorCode = [TBXML childElementNamed:@"" parentElement:_result];
    assert(_errorCode);
    
    int errorCode = [[TBXML textForElement:_errorCode] intValue];
    
    if(errorCode ==1)
    {
        [self popoverPresentationController];
    }
    else{
        
    }

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
