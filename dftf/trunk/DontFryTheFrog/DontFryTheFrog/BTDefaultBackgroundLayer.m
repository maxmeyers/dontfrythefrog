//
//  BTBackgroundLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/20/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTDefaultBackgroundLayer.h"
#import "BTIncludes.h"
#import "BTLilypad.h"
#import "BTWaterStreak.h"

@implementation BTDefaultBackgroundLayer

- (id) init {
    self = [super init];
    if (self){
        CCLayerColor *layer1 = [CCLayerColor layerWithColor:ccc4(64, 194, 213, 255)];;
        CCSprite *layer6 = [CCSprite spriteWithSpriteFrameName:@"background-layer6.png"];
        layer6.position = ccp(240, 22);
        [self addChild:layer1 z:1];
        [self addChild:layer6 z:6];

        const int bigLilyPads = 3;
        const int smallLilyPads = 6;
        
        for (int i = 0; i < bigLilyPads; i++){
            BTLilypad *lilyPad = [[BTLilypad alloc] initWithSize:kLarge Position:ccp(RANDBT(0, 480), RANDBT(0, 320))];
            [self addChild:lilyPad z:RANDBT(4, 6)];
        }
        
        for (int i = 0; i < smallLilyPads; i++){
            BTLilypad *lilyPad = [[BTLilypad alloc] initWithSize:kSmall Position:ccp(RANDBT(0, 480), RANDBT(0, 320))];
            [self addChild:lilyPad z:RANDBT(4, 6)];
        }
        
        for (int i = 0; i < 7; i++){
            BTWaterStreak *waterStreak = [[BTWaterStreak alloc] initWithPosition:ccp(85*(i-2), RANDBT(175, 295))];
            [self addChild:waterStreak z:3];
            
            waterStreak = [[BTWaterStreak alloc] initWithPosition:ccp(85*(i-2), RANDBT(15, 145))];
            [self addChild:waterStreak z:3];
        }
    }
    return self;
}

+ (ccColor3B)textColor {
    return ccc3(0, 59, 22);
}

+ (NSString *) shortName {
    return @"Swamp";
}

@end
