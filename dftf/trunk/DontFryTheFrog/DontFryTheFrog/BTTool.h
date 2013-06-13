//
//  BTTool.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/7/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "CCNode.h"

@interface BTTool : CCNode

- (void) consume;
+ (NSString *) name;
+ (NSString *) titleFileString;
+ (NSString *) menuImageSuffix;

@end
