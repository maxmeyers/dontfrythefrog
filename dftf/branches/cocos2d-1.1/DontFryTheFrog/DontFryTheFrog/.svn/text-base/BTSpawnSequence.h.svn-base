//
//  BTBugSpawn.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 7/9/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTMetasequence.h"
#import "cocos2d.h"

@interface BTSpawnSequence : NSObject <NSCoding> {
    NSString *name;

    ccTime startingTime;
    tSequenceState state;
    NSMutableArray *orders;
}

@property (nonatomic, retain) NSString *name;

@property ccTime startingTime;
@property tSequenceState state;
@property (nonatomic, assign) NSMutableArray *orders;

- (id) initWithOrders:(NSArray *) Orders Name:(NSString *) str;
- (void) startAtTime:(ccTime) time;
- (NSArray *) ordersForTime:(ccTime) time;
- (void) reset;
- (void) finish;

@end

@interface BTSpecialSequence : NSObject <NSCoding> {
    NSString *name;

    NSArray *sequences;
    NSArray *requiredBugs;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *sequences;

- (id) initWithSequences:(NSArray *) seq Name:(NSString *) str RequiredBugs:(NSArray *) bugs;
- (bool) isUnlocked;
- (void) reset;

@end


