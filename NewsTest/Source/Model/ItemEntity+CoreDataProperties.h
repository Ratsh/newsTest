//
//  ItemEntity+CoreDataProperties.h
//  
//
//  Created by ratsh on 8/12/19.
//
//

#import "ItemEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ItemEntity (CoreDataProperties)

+ (NSFetchRequest<ItemEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *itemDescription;
@property (nullable, nonatomic, copy) NSString *link;
@property (nullable, nonatomic, copy) NSDate *publishDate;
@property (nonatomic) BOOL isRead;
@property (nonatomic) int16_t source;
@property (nullable, nonatomic, copy) NSString *imageUrl;

@end

NS_ASSUME_NONNULL_END
