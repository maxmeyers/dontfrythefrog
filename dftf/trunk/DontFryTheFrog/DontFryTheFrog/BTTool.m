//
//  BTTool.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/7/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTTool.h"
#import "BTIncludes.h"

@implementation BTTool

- (void) consume {
    [[BTHopshopManager sharedHopshopManager] consumeConsumable:[self class]];
}

+ (NSString *) name {
    return @"Misc. Tools";
}

+ (NSString *) titleFileString {
    return @"mission-shuffle-title.png";
}

+ (NSString *) menuImageSuffix {
    return @"";
}

@end
