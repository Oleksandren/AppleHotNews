//
//  RSSItem.h
//  Apple Hot News
//
//  Created by oleksandr on 15.10.14.
//  Copyright (c) 2014 Access Softek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSItem : NSObject
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *detail;
@property (nonatomic, retain) NSString *link;
@end
