//
//  FeedStorageDataSourceProtocol.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ItemModel;

@protocol FeedStorageDataSourceProtocol <NSObject>

- (void)addItems:(NSArray<ItemModel *> *)anItems;
- (NSArray<ItemModel *> *)getItems;
- (void)setItemAsRead:(NSString *)anItemLink;

@end

NS_ASSUME_NONNULL_END
