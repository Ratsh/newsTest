//
//  FeedLentaDataSource.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "FeedLentaDataSource.h"
#import "AppConstants.h"


@interface FeedLentaDataSource() 

@property (nonatomic, strong) NSArray<ItemModel *> *items;

@end


@implementation FeedLentaDataSource

- (instancetype)initWithConfiguration:(FeedLentaDataSourceConfiguration *)aConfig {
    self = [super init];
    if (self) {
        self.configuration = aConfig;
        self.items = [NSArray<ItemModel *> new];
    }
    return self;
}

#pragma mark - FeedRSSDataSourceProtocol

- (nonnull NSArray<ItemModel *> *)getItems { 
    return self.items.copy;
}

- (void)reload { 
    __weak typeof(self) weakSelf = self;
    [self.configuration.apiManager getRssDataFromUrlString:lentaRuUrlString 
                                                 xmlParser:self.configuration.xmlParser 
                                            completion:^(NSArray<ItemModel *> * _Nonnull anItems, 
                                                         NSError * _Nonnull anError) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (anError) {
            if ([strongSelf.delegate respondsToSelector:@selector(dataSource:didFinishWithError:)]) {
                [strongSelf.delegate dataSource:strongSelf didFinishWithError:anError];
            }
        } else {
            strongSelf.items = anItems;
            if ([strongSelf.delegate respondsToSelector:@selector(dataSourceDidReloadData:)]) {
                [strongSelf.delegate dataSourceDidReloadData:strongSelf];
            }
        }
    }]; 
}

@end


@implementation FeedLentaDataSourceConfiguration
@end
