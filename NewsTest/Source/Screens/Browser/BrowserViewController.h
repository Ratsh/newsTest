//
//  BrowserViewController.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrowserProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BrowserViewController : UIViewController<BrowserProtocol>

@property (nonatomic, strong, readonly) NSString *urlString;

- (instancetype)initWithUrlString:(NSString *)aUrlString;

@end

NS_ASSUME_NONNULL_END
