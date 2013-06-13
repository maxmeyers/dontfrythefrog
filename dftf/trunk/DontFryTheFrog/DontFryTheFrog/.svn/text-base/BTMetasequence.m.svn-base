//
//  BTMetasequence.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 9/30/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTMetasequence.h"
#import "BTIncludes.h"

#define kMetasequenceSequences @"Sequences"

@implementation BTMetasequence

@synthesize name, currentSequence, state;

- (id) initWithSequences:(NSArray *) seq {
    self = [super init];
    if (self) {
        sequences = [seq retain];
        
        NSString *temp = @"";
        for (int i = 0; i < [sequences count]; i++){
            BTSpawnSequence *sequence = [sequences objectAtIndex:i];
            NSString *addition = @"";
            if ([sequence isMemberOfClass:[BTSpawnSequence class]]){
                addition = [[sequence name] substringToIndex:1];
            } else if ([sequence isMemberOfClass:[BTSpecialSequence class]]){
                addition = @"S";
            }
            temp = [temp stringByAppendingFormat:@"%@ ", addition];
        }
        self.name = temp;
        
        [self reset];
    }
    return self;
}

- (void) setBugManager:(BTBugManager *) manager {
    bugManager = manager;
}

- (void) startSequence:(int) i {
    bool foundSequence = NO;
    currentSequence = [sequences objectAtIndex:i];
    if ([currentSequence isMemberOfClass:[BTSpecialSequence class]]){
        BTSpecialSequence *specialSequence;
        
        NSMutableArray *specialSequences = [NSMutableArray arrayWithArray:[bugManager specialSequences]];
        while ([specialSequences count] > 0 && !foundSequence){ 
            specialSequence = [specialSequences objectAtIndex:(arc4random()%[specialSequences count])];
            if ([specialSequence isUnlocked]){
                foundSequence = YES;
                NSLog(@"Starting Special Sequence: %@", [specialSequence name]);
                currentSequence = [[specialSequence sequences] objectAtIndex:1];
            } else {
                [specialSequences removeObject:specialSequence];
            }
        }
    } else {
        NSLog(@"Starting Normal Sequence");
        foundSequence = YES;
    }
    
    if (foundSequence){
        [currentSequence startAtTime:[[bugManager gameLayer] playTime]];
    } else {
        NSLog(@"No Unlocked Special Sequence Found");
        [self nextSequence];
    }
}

- (void) start {
    NSLog(@"Starting Metasequence");
    for (int i = 0; i < [sequences count]; i++){
        [(BTSpawnSequence *)[sequences objectAtIndex:i] reset];
    }
    state = Started;
    sequenceIndex = 0;
    [self startSequence:sequenceIndex];
}

- (NSArray *) ordersForTime:(ccTime) time {
    if (state == Started && ![currentSequence isMemberOfClass:[BTSpecialSequence class]]){
        NSArray *orders = [currentSequence ordersForTime:time];
        if ([currentSequence state] == Finished){
            [self nextSequence];
        }
        return orders;
    }
    return [NSArray array];
}

- (void) nextSequence {
    NSLog(@"Starting next sequence of metasequence");
    sequenceIndex += 1;
    if (sequenceIndex < [sequences count]){
        [self startSequence:sequenceIndex];
    } else {
        [self finish];
    }
}



- (void) finish {
    state = Finished;
}

- (void) reset {
    sequenceIndex = 0;
    currentSequence = [sequences objectAtIndex:sequenceIndex];
    state = NotStarted;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    NSArray *tempArray = [NSArray array];
    if ([aDecoder decodeObjectForKey:kMetasequenceSequences]){
        tempArray = [aDecoder decodeObjectForKey:kMetasequenceSequences];
    }
    
    self = [self initWithSequences:tempArray];
    if (self){
        
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:sequences forKey:kMetasequenceSequences];
}

@end
