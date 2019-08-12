//
//  FeedDetailedCollectionViewCell.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FeedDetailedCollectionViewCellConfig;


@interface FeedDetailedCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, readonly) FeedDetailedCollectionViewCellConfig *configuration;

- (void)updateWithConfiguration:(FeedDetailedCollectionViewCellConfig *)aConfig;

@end


@interface FeedDetailedCollectionViewCellConfig : NSObject 

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, assign) BOOL isSeen;
@property (nonatomic, strong) NSDate *publishDate;

@end

NS_ASSUME_NONNULL_END
