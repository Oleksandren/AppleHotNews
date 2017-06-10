//
//  WebViewController.h
//  Apple Hot News
//
//  Created by oleksandr on 15.10.14.
//  Copyright (c) 2014 Access Softek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSSItem;

@interface NewsDetailsViewController : UIViewController <UISplitViewControllerDelegate, UIWebViewDelegate>

@property (nonatomic, readonly) UIWebView *webView;
@property (nonatomic, retain) RSSItem *item;
@end
