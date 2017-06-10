//
//  Helpers.m
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import "Helpers.h"
#import <UIKit/UIKit.h>

@implementation Helpers
+ (BOOL)isIpad
{
    BOOL isIpad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
    
    return isIpad;
}
@end
