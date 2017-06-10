//
//  XMLParser.h
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSChannel;

typedef void (^ _Nonnull XMLParserCompletionHandler)(RSSChannel *__nonnull chanel);

@interface XMLParser : NSObject <NSXMLParserDelegate>
- (instancetype _Nonnull )initWithData:(NSData *_Nonnull)data
                            completion:(XMLParserCompletionHandler)completionHandler;
@end
