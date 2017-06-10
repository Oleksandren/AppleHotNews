//
//  ListViewController.h
//  Apple Hot News
//
//  Created by oleksandr on 15.10.14.
//  Copyright (c) 2014 Access Softek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsDetailsViewController;
@protocol NewsListViewModelProtocol;


@interface NewsListViewController : UITableViewController
@property (nonatomic, retain) id <NewsListViewModelProtocol> viewModel;
@property (nonatomic, retain) NewsDetailsViewController *newsDetailsViewController;
@end
