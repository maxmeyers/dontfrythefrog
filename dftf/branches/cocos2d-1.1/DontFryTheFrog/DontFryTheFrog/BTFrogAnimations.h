//
//  BTFrogAnimations.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/11/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCAnimation, CCSprite;

@interface BTFrogAnimations : NSObject {
    CCAnimation *idleAnimation;
    CCAnimation *openAnimation;
    CCAnimation *eatAnimation;
    CCAnimation *zapAnimation;
    CCAnimation *explodeAnimation;
    CCSprite *jawSprite;

    bool tongue;
    int base;
}

@property (nonatomic, retain) CCAnimation *idleAnimation;
@property (nonatomic, retain) CCAnimation *openAnimation;
@property (nonatomic, retain) CCAnimation *eatAnimation;
@property (nonatomic, retain) CCAnimation *zapAnimation;
@property (nonatomic, retain) CCAnimation *explodeAnimation;
@property (nonatomic, retain) CCSprite *jawSprite;

@property bool tongue;
@property int base;

- (id) initWithBase:(int) i IdleAnimation:(CCAnimation *) idle OpenAnimation:(CCAnimation *) open EatAnimation:(CCAnimation *) eat ZapAnimation:(CCAnimation *) zap ExplodeAnimation:(CCAnimation *) explode Tongue:(bool) t Jaw:(CCSprite *) jaw;

+ (id) animationsWithBase:(int) base Suffix:(NSString *) suffix;

@end
