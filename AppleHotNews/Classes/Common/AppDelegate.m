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


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [AppConfigurator setupRootViewControllerInWindow: self.window];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end
