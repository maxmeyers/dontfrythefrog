//
//  BTFrogMilestone.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 9/13/11.
//  Copyright 2011 New York University. All rights reserved.
//


@interface BTFrogMilestone : NSObject <NSCoding> {
    int time;
    
    float catchInterval;
    float speed;
    float animationDelay;
}

@property int time;
@property int zaps;

@property float catchInterval;
@property float speed;
@property float animationDelay;

- (id)initWithTime:(int) t CatchInterval:(float) c Speed:(float) s AnimationDelay:(float) a;
- (void) apply;

@end
