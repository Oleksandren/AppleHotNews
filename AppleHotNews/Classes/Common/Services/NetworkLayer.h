//
//  NSURLSessionNetworkLayer.h
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ _Nullable CompletionHandler)(NSData *__nullable receivedData, NSString *__nullable errorMessage);

@protocol NetworkLayerProtocol <NSObject>
- (void)fetchDataByUrlString: (NSString *_Nonnull)urlString completion:(CompletionHandler)completionHandler;
@end

@interface NetworkLayer : NSObject <NetworkLayerProtocol>
+ (instancetype _Nonnull) shared;

@end
