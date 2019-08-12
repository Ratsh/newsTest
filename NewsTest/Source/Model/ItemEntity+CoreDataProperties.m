//
//  ItemEntity+CoreDataProperties.m
//  
//
//  Created by ratsh on 8/12/19.
//
//

#import "ItemEntity+CoreDataProperties.h"

@implementation ItemEntity (CoreDataProperties)

+ (NSFetchRequest<ItemEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ItemEntity"];
}

@dynamic title;
@dynamic itemDescription;
@dynamic link;
@dynamic publishDate;
@dynamic isRead;
@dynamic source;
@dynamic imageUrl;

@end
