//
//  APIManagerProtocol.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ItemModel;
@protocol XMLParserManagerProtocol;

@protocol APIManagerProtocol <NSObject>

- (void)getRssDataFromUrlString:(NSString *)aUrlString 
                      xmlParser:(id<XMLParserManagerProtocol>)aParser
                 completion:(void(^)(NSArray<ItemModel *> *anItems, NSError *anError))aCompletion;

@end

NS_ASSUME_NONNULL_END
