//
//  JJTArticle.h
//  JJTree
//
//  Created by guojun on 9/3/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class JJTParagraph, JJTUser;

@interface JJTArticle : NSManagedObject

@property (nonatomic, retain) NSNumber * articleID;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * isPrivate;
@property (nonatomic, retain) NSNumber * rewardGotAmount;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSNumber * usefulValue;
@property (nonatomic, retain) NSNumber * uselessValue;
@property (nonatomic, retain) NSNumber * viewCount;
@property (nonatomic, retain) NSOrderedSet *paragraphs;
@property (nonatomic, retain) JJTUser *author;
@end

@interface JJTArticle (CoreDataGeneratedAccessors)

- (void)insertObject:(JJTParagraph *)value inParagraphsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromParagraphsAtIndex:(NSUInteger)idx;
- (void)insertParagraphs:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeParagraphsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInParagraphsAtIndex:(NSUInteger)idx withObject:(JJTParagraph *)value;
- (void)replaceParagraphsAtIndexes:(NSIndexSet *)indexes withParagraphs:(NSArray *)values;
- (void)addParagraphsObject:(JJTParagraph *)value;
- (void)removeParagraphsObject:(JJTParagraph *)value;
- (void)addParagraphs:(NSOrderedSet *)values;
- (void)removeParagraphs:(NSOrderedSet *)values;
@end
