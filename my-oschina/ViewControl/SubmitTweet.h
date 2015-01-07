//
//  SubmitTweet.h
//  my-oschina
//
//  Created by jjx on 14/11/24.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "prefix_define.h"
#import "ASIFormDataRequest.h"
#import "Helper.h"
#import "TBXML.h"
#import "MyThread.h"

@interface SubmitTweet : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ASIHTTPRequestDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView* m_imageView;
@property (weak, nonatomic) IBOutlet UITextView* m_contentView;
@end
