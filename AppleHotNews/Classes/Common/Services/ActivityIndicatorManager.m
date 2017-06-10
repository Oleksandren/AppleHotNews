//
//  ActivityIndicatorManager.m
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 07.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import "ActivityIndicatorManager.h"
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@implementation ActivityIndicatorManager

+ (void)showHUD
{
    [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
}

+ (void)hideHUD
{
    [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
}

@end
