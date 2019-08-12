//
//  SettingsDataSourceProtocol.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SettingsDataSourceProtocol <NSObject>

- (void)setFeedStyle:(NSInteger)aFeedStyle;
- (void)setRefreshInterval:(NSInteger)anInterval;

@end


@protocol SettingsDataSourceDelegate <NSObject>
@end

NS_ASSUME_NONNULL_END
