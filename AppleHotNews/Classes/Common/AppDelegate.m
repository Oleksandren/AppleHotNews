//
//  AppDelegate.m
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 07.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConfigurator.h"

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
    
    [AppConfigurator setupRootViewControllerInWindow: _window];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
