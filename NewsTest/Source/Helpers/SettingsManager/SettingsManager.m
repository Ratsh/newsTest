//
//  SettingsManager.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "SettingsManager.h"

static NSString *feedTypeKey = @"feedTypeKey";
static NSString *timeIntervalKey = @"timeIntervalKey";


@interface SettingsManager()

@property (nonatomic, assign) FeedType feedTypeValue;
@property (nonatomic, assign) NSInteger timeIntervalValue;

@end


@implementation SettingsManager

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupInitialValues];
    }
    return self;
}

- (void)setupInitialValues {
    NSNumber *feedType = [[NSUserDefaults standardUserDefaults] valueForKey:feedTypeKey];
    if (feedType) {
        _feedTypeValue = feedType.integerValue;
    } else {
        _feedTypeValue = 0;
    }
    
    NSNumber *refreshInterval = [[NSUserDefaults standardUserDefaults] valueForKey:timeIntervalKey];
    if (refreshInterval) {
        _timeIntervalValue = refreshInterval.integerValue;
    } else {
        _timeIntervalValue = 1;
    }
}

#pragma mark - SettingsManagerProtocol

- (FeedType)getFeedType {
    return self.feedTypeValue;
}

- (void)setFeedType:(FeedType)aNewType {
    if (self.feedTypeValue == aNewType) {
        return;
    }
    self.feedTypeValue = aNewType;
    [[NSUserDefaults standardUserDefaults] setObject:@(aNewType) forKey:feedTypeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)getRefreshTimeInterval {
    return self.timeIntervalValue;
}

- (void)setRefreshInterval:(NSInteger)anInterval {
    if (self.timeIntervalValue == anInterval) {
        return;
    }
    self.timeIntervalValue = anInterval;
    [[NSUserDefaults standardUserDefaults] setObject:@(anInterval) forKey:timeIntervalKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
