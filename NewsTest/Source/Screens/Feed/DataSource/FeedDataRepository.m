//
//  FeedDataRepository.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "FeedDataRepository.h"

#import "FeedRSSDataSourceProtocol.h"
#import "FeedStorageDataSourceProtocol.h"
#import "ItemModel.h"


@interface FeedDataRepository() <FeedRSSDataSourceDelegate>

@property (nonatomic, strong) NSArray<ItemModel *> *items;
@property (nonatomic, strong) FeedDataRepositoryConfiguration *configuration;

@end


@implementation FeedDataRepository 

- (instancetype)initWithConfiguration:(FeedDataRepositoryConfiguration *)aConfig {
    self = [super init];
    if (self) {
        self.configuration = aConfig;
        
        for (id<FeedRSSDataSourceProtocol> rssDataSource in self.configuration.rssDataSources) {
            rssDataSource.delegate = self;
        }
    }
    return self;
}

#pragma mark - Private

- (void)updateItems {
    self.items = [[self.configuration.storageDataSource getItems] sortedArrayUsingComparator:
        ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {

        return [((ItemModel *)obj2).publishDate compare:((ItemModel *)obj1).publishDate];
    }];
    
    if ([self.delegate respondsToSelector:@selector(repositoryDidUpdateData:)]) {
        [self.delegate repositoryDidUpdateData:self];
    }
}

- (void)updateStorage {
    NSMutableArray *items = [NSMutableArray new];
    for (id<FeedRSSDataSourceProtocol> dataSource in self.configuration.rssDataSources) {
        [items addObjectsFromArray:[dataSource getItems]];
    }
    [self.configuration.storageDataSource addItems:items];
    [self updateItems];
}

#pragma mark - FeedDataRepositoryProtocol

- (NSInteger)itemsCount { 
    return self.items.count;
}

- (void)reload { 
    [self updateItems];
    
    for (id<FeedRSSDataSourceProtocol> dataSource in self.configuration.rssDataSources) {
        [dataSource reload];
    }
}

- (void)setItemAsRead:(NSString *)anItemLink {
    [self.configuration.storageDataSource setItemAsRead:anItemLink];
    [self updateItems];
}

#pragma mark - FeedRSSDataSourceDelegate

- (void)dataSourceDidReloadData:(nonnull id<FeedRSSDataSourceProtocol>)aDataSource { 
    [self updateStorage];
}

- (void)dataSource:(nonnull id<FeedRSSDataSourceProtocol>)aDataSource 
    didFinishWithError:(nonnull NSError *)anError { 
    
    if ([self.delegate respondsToSelector:@selector(repository:didFinishWithError:)]) {
        [self.delegate repository:self didFinishWithError:anError];
    }    
}

#pragma mark - FeedViewDataSourceProtocol

- (NSArray<ItemModel *> *)getItems {
    return self.items.copy;
}

- (ItemModel *)getItemAtIndex:(NSInteger)anIndex {
    if (anIndex >= 0 && anIndex < self.items.count) {
        return self.items[anIndex];
    }
    return nil;
}

@end


@implementation FeedDataRepositoryConfiguration
@end
