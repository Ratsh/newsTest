//
//  FeedDataRepositoryProtocol.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FeedDataRepositoryProtocol <NSObject>

- (void)reload;
- (NSInteger)itemsCount;
- (void)setItemAsRead:(NSString *)anItemLink;

@end


@protocol FeedDataRepositoryDelegate <NSObject>

- (void)repositoryDidUpdateData:(id<FeedDataRepositoryProtocol>)aRepository;
- (void)repository:(id<FeedDataRepositoryProtocol>)aRepository 
    didFinishWithError:(NSError *)anError;

@end

NS_ASSUME_NONNULL_END
