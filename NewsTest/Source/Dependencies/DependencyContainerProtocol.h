//
//  DependencyContainerProtocol.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FeedViewProtocol, BrowserProtocol, SettingsViewProtocol;

@protocol DependencyContainerProtocol <NSObject>

- (UIViewController<FeedViewProtocol> *)createFeedModule;
- (UIViewController<BrowserProtocol> *)createBrowserModuleWithUrl:(NSString *)aUrl;
- (UIViewController<SettingsViewProtocol> *)createSettingsModule;

@end

NS_ASSUME_NONNULL_END
