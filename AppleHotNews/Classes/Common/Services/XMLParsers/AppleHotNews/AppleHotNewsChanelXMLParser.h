//
//  NewsXMLParser.h
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSChannel;

@interface AppleHotNewsChanelXMLParser : NSObject <NSXMLParserDelegate>
@property (nonatomic, assign) id _Nonnull parentParserDelegate;
@property (nonatomic, readonly, retain) RSSChannel * _Nonnull channel;
@end
