//
//  UIViewController+Alert.h
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

- (void)displayAlertWithTitle:(NSString *)title
                      message:(NSString *)message;
- (void)displayErrorMessage: (NSString *)errorMessage;

@end
