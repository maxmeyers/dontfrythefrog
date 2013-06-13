//
//  BTAtLeastGameLengthLeap.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTAtLeastGameLengthLeap.h"

@implementation BTAtLeastGameLengthLeap

//- (void) resetProgress {
//    [super resetProgress];
//    failed = NO;
//}

//- (bool) achieved {
//    if (failed){
//        return NO;
//    }
//    
//    return [super achieved];
//}

- (void) bugFriedOfClass:(Class)c {
    [super bugFriedOfClass:c];
    if (![self achieved] && [c isSubclassOfClass:NSClassFromString(bugClass)] && [otherClass isEqualToString:@"Fries"]){
        [self resetProgress];
    }
}

- (void) bugEatenOfClass:(Class)c {
    [super bugEatenOfClass:c];
    if (![self achieved] && [c isSubclassOfClass:NSClassFromString(bugClass)] && [otherClass isEqualToString:@"Eats"]){
        [self resetProgress];
    }
}

//- (NSString *) progressString {
//    if (!failed){
//        return [super progressString];
//    }
//    
//    return @"Maybe next time!";
//}

@end
