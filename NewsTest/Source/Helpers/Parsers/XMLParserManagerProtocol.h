//
//  XMLParserManagerProtocol.h
//  NewsTest
//
//  Created by ratsh on 8/10/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ItemModel;

@protocol XMLParserManagerProtocol <NSObject>

- (NSArray<ItemModel *> *)getItemsFromXmlData:(NSData *)aData;

@end

NS_ASSUME_NONNULL_END
