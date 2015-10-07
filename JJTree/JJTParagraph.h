//
//  JJTParagraph.h
//  JJTree
//
//  Created by guojun on 7/26/15.
//  Copyright (c) 2015 guojunxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define JJTParagraphPreface @"preface"
#define JJTParagraphPlainText @"plain_text"
#define JJTParagraphBlock @"block"
#define JJTParagraphPicture @"picture"
#define JJTParagraphLink @"link"
#define JJTParagraphQuotation @"quotation"
#define JJTParagraphReference @"reference"
#define JJTParagraphConclude @"conclude"
#define JJTParagraphSeeAlso @"see_also"

@class JJTArticle;

@interface JJTParagraph : NSManagedObject

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * paragraphID;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) JJTArticle *whichArticle;

@end
