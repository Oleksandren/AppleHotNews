//
//  AppleHotNewsItemXMLParser.h
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RSSItem;

@interface AppleHotNewsItemXMLParser : NSObject <NSXMLParserDelegate>
@property (nonatomic, assign) id _Nonnull parentParserDelegate;
@property (nonatomic, readonly, retain) RSSItem * _Nonnull item;
@end
