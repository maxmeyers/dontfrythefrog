//
//  BTPuddle.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/1/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTObject.h"

#define kPuddleTag 354315

typedef enum {
    kBubblingUp,
    kBubbled,
    kEvaporating,
} tPuddleState;

@class CCTimer, BTFrogEffectPuddled;

@interface BTPuddle : BTObject {
    CCTimer *timer;
    CGSize size;
    tPuddleState puddleState;
}

- (id) initWithFile:(NSString *)fileName Position:(CGPoint)position IdleAnimation:(CCAnimation *)animation ParentLayer:(BTGameLayer *)layer Size:(CGSize) s;
- (void) evaporate;

@end
