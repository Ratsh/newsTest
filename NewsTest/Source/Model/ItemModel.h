//
//  ItemModel.h
//  NewsTest
//
//  Created by ratsh on 8/10/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ItemSourceType) {
   ItemSourceTypeLentaRu = 0,
   ItemSourceTypeGazetaRu,
};


@interface ItemModel : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* itemDescription;
@property (nonatomic, strong) NSString* link;
@property (nonatomic, strong) NSString* imageUrl;
@property (nonatomic, strong) NSDate* publishDate;

@property (nonatomic, assign) ItemSourceType source;
@property (nonatomic, assign) BOOL isRead;

@end

NS_ASSUME_NONNULL_END
