//
//  FeedViewProtocol.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ItemModel;

@protocol FeedViewProtocol <NSObject>

- (void)refresh;
- (void)pushViewController:(UIViewController *)aController;

@end


@protocol FeedViewDelegate <NSObject>

- (void)viewDidLoad;
- (void)viewWillAppear;
- (void)didSelectItem:(ItemModel *)anItem;
- (void)settingsPressed;

@end


@protocol FeedViewDataSourceProtocol <NSObject>

- (NSArray<ItemModel *> *)getItems;
- (ItemModel *)getItemAtIndex:(NSInteger)anIndex;

@end

NS_ASSUME_NONNULL_END
