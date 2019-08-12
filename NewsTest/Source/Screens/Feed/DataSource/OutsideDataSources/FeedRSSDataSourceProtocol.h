//
//  FeedRSSDataSourceProtocol.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FeedRSSDataSourceDelegate;
@class ItemModel; 


@protocol FeedRSSDataSourceProtocol <NSObject>

@property (nonatomic, weak) id<FeedRSSDataSourceDelegate> delegate;

- (void)reload;
- (NSArray<ItemModel *> *)getItems;

@end


@protocol FeedRSSDataSourceDelegate <NSObject>

- (void)dataSourceDidReloadData:(id<FeedRSSDataSourceProtocol>)aDataSource;
- (void)dataSource:(id<FeedRSSDataSourceProtocol>)aDataSource didFinishWithError:(NSError *)anError;

@end

NS_ASSUME_NONNULL_END
