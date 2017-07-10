//
//  AppDelegate.m
//  AppleHotNews
//
//  Created by oleksandr on 15.10.14.
//  Copyright (c) 2014 Access Softek. All rights reserved.
//

#import "AppDelegate.h"
#import "ListViewController.h"
#import "WebViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Life cycle

-(void)dealloc
{
    [_window release];
    _window = nil;
    [super dealloc];
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    ListViewController *lvc = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:lvc];
    
    WebViewController *wvc = [[WebViewController alloc] init];
    [lvc setWebViewController:wvc];
    
    if (isIPAD)
    {
        UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:wvc];
        NSArray *vcs = [NSArray arrayWithObjects:masterNav, detailNav, nil];
        UISplitViewController *svc = [[UISplitViewController alloc] init];
        [svc setDelegate:wvc];
        [svc setViewControllers:vcs];
        
        [[self window] setRootViewController:svc];
        
        [detailNav release];
        [svc release];
    }
    else
        [[self window] setRootViewController:masterNav];
    
    [lvc release];
    [masterNav release];
    [wvc release];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
