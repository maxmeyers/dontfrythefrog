//
//  BTDesertBackgroundLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTDesertBackgroundLayer.h"
#import "BTIncludes.h"
#import "BTTumbleWeed.h"

@implementation BTDesertBackgroundLayer

- (id) init {
    self = [super init];
    if (self){
        CCLayerColor *bg = [CCLayerColor layerWithColor:ccc4(254, 218, 156, 255)];
        [self addChild:bg z:0];
        
        CCSprite *skull = [CCSprite spriteWithSpriteFrameName:@"skull.png"];
        skull.position = ccp(380, 170);
        [self addChild:skull z:1];
        
        CCSprite *cactus = [CCSprite spriteWithSpriteFrameName:@"cactus.png"];
        cactus.position = ccp(30, 45);
        [self addChild:cactus z:2];
        
        BTMovableBackgroundObject *sandstripe = [[[BTMovableBackgroundObject alloc] initWithPosition:ccp(20, 160) FileName:@"migrating-sand-stripe.png"] autorelease];
        sandstripe.speed = 2.5;
        [sandstripe drift:NO];
        [self addChild:sandstripe z:1];
        
        BTTumbleWeed *tumbleWeed = [[[BTTumbleWeed alloc] init] autorelease];
        [self addChild:tumbleWeed z:2];
    }
    return self;
}

+ (NSString *) name {
    return @"Desert Background";
}

+ (NSString *) shortName {
    return @"Desert";
}

+ (ccColor3B) textColor {
    return ccc3(0, 59, 22);
}

@end
