//
//  FeedSimpleCollectionCell.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FeedSimpleCollectionCellConfig;


@interface FeedSimpleCollectionCell : UICollectionViewCell

@property (nonatomic, strong, readonly) FeedSimpleCollectionCellConfig *configuration;

- (void)updateWithConfiguration:(FeedSimpleCollectionCellConfig *)aConfig;

@end


@interface FeedSimpleCollectionCellConfig : NSObject 

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, assign) BOOL isSeen;

@end

NS_ASSUME_NONNULL_END
