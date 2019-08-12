//
//  SettingsViewProtocol.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SettingsViewProtocol <NSObject>

- (void)update;

@end


@protocol SettingsViewDelegate <NSObject>

- (void)feedStyleChangedTo:(NSInteger)aNewStyle;
- (void)refreshIntervalChangedTo:(NSInteger)aNewInterval;

@end


@protocol SettingsViewDataSourceProtocol <NSObject>

- (NSInteger)getFeedStyle;
- (NSInteger)getRefreshInterval;

@end

NS_ASSUME_NONNULL_END
