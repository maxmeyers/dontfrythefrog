//
//  BTMetasequence.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 9/30/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "cocos2d.h"

typedef enum {
    NotStarted,
    Started,
    Finished,
    PostFinished,
} tSequenceState;

@class BTBugManager, BTSpawnSequence;
@interface BTMetasequence : NSObject <NSCoding> {
    NSString *name;
    
    BTBugManager *bugManager;
    BTSpawnSequence *currentSequence;
    int sequenceIndex;
    
    NSArray *sequences;
    tSequenceState state;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) BTSpawnSequence *currentSequence;
@property tSequenceState state;

- (id) initWithSequences:(NSArray *) seq;
- (void) setBugManager:(BTBugManager *) manager;
- (void) startSequence:(int) i;
- (void) start;
- (void) nextSequence;
- (NSArray *) ordersForTime:(ccTime) time;
- (void) finish;
- (void) reset;

@end