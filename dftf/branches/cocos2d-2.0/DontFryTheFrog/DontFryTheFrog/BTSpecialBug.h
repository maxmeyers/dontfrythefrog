//
//  BTSpecialBug.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 6/13/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "cocos2d.h"
#import "BTBug.h"

@class BTFrogEffect;

@interface BTSpecialBug : BTBug {
    BTFrogEffect *effect;
    bool isExtraSpecial;
    
    CCSprite *sparkleSprite;
    CCAnimation *sparkleAnimation;
}

- (id) initFlyWithAnimation:(CCAnimation *)animation GameLayer:(BTGameLayer *) layer;
+ (NSString *) color;

@property (nonatomic, assign) BTFrogEffect *effect;
@property (nonatomic, assign) CCSprite *sparkleSprite;
@property bool isExtraSpecial;

@end

@interface BTGoodBug : BTSpecialBug
@end

@interface BTBadBug : BTSpecialBug
@end
