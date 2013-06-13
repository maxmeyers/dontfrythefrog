//
//  BTFrogEffect.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/16/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "cocos2d.h"

@class BTFrog;

@interface BTFrogEffect : NSObject {
    BTFrog *frog;
    CCTimer *timer;
    ccTime duration;
}

@property (nonatomic, assign) BTFrog *frog;
@property (nonatomic, readonly) CCTimer *timer;

- (id) initWithFrog:(BTFrog *) f Duration:(ccTime) d;
- (void) apply;
- (void) stop; // Starts the shutdown process -- stuff that is optional
- (void) remove; // Shuts itself down immediately -- stuff that has to happen

@end
