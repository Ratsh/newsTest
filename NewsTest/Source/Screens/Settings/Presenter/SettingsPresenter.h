//
//  SettingsPresenter.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsViewProtocol.h"
#import "SettingsDataSourceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class SettingsPresenterConfiguration;


@interface SettingsPresenter : NSObject<SettingsViewDelegate, SettingsDataSourceDelegate>

@property (nonatomic, strong, readonly) SettingsPresenterConfiguration *configuration;

- (void)configureWith:(SettingsPresenterConfiguration *)aConfig;

@end


@interface SettingsPresenterConfiguration : NSObject

@property (nonatomic, weak) id<SettingsViewProtocol> view;
@property (nonatomic, strong) id<SettingsDataSourceProtocol> dataSource;

@end

NS_ASSUME_NONNULL_END
