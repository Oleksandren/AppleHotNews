//
//  UIViewController+Alert.m
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import "UIViewController+Alert.h"
#import "Constants.h"

@implementation UIViewController (Alert)

- (void)displayAlertWithTitle:(NSString *)title
                      message:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

- (void)displayErrorMessage:(NSString *)errorMessage
{
    [self displayAlertWithTitle:errorTitle
                        message:errorMessage];
}

@end
