//
//  BTLeapBox.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"

@class BTLeap;

typedef enum {
    kPauseScreen,
    kLevelingScreen,
} tLeapBoxState;

@interface BTLeapBox : CCNode {
    NSMutableArray *singleLeaps_;
    tLeapBoxState state_;
}

@property (nonatomic, assign) NSMutableArray *singleLeaps;
@property tLeapBoxState state;

- (id) initWithState:(tLeapBoxState) state;
- (void) refresh;
- (bool) hasComplete;
- (int) lilyPadsRemaining;

@end

typedef enum {
    New,
    InProgress,
    Complete
} tSingleLeapBoxState;

#define kProgressLabelTag 9
#define kDescriptionLabelTag 10
#define kRewardsLabelTag 11
#define kMissionLabelTag 12

#define kLilyPad1Tag 13
#define kLilyPad2Tag 14
#define kLilyPad3Tag 15
#define kLilyPad4Tag 16
#define kLilyPad5Tag 17
#define kLilyPad6Tag 18

@interface BTSingleLeap : CCNode <CCRGBAProtocol> { 
    BTLeap *leap_;
    int index_;
    bool completed_;
    CGPoint location_;
    
    tSingleLeapBoxState state;
}

@property (nonatomic, assign) BTLeap *leap;
@property int index;
@property bool completed;
@property CGPoint location;
@property tSingleLeapBoxState state;

- (id) initWithLeap:(BTLeap *) leap AtIndex:(int) index WithPosition:(CGPoint) position;
- (void) refresh;
- (int) lilyPadsRemaining;

@end