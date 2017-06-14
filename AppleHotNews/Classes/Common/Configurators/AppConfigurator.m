//
//  AppConfigurator.m
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 07.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import "AppConfigurator.h"
#import "NewsDetailsViewController.h"
#import "NewsListViewController.h"
#import "Helpers.h"

@implementation AppConfigurator
+ (void)setupRootViewControllerInWindow:(UIWindow *)window
{
    NewsListViewController *lvc = [[NewsListViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:lvc];
    
    NewsDetailsViewController *wvc = [[NewsDetailsViewController alloc] init];
    [lvc setNewsDetailsViewController:wvc];
    
    if ([Helpers isIpad])
    {
        UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:wvc];
        NSArray *vcs = [NSArray arrayWithObjects:masterNav, detailNav, nil];
        UISplitViewController *svc = [[UISplitViewController alloc] init];
        [svc setDelegate:wvc];
        [svc setViewControllers:vcs];
        
        [window setRootViewController:svc];
        
        [detailNav release];
        [svc release];
    }
    else
        [window setRootViewController:masterNav];
    
    [lvc release];
    [masterNav release];
    [wvc release];
}
@end
