//
//  BTBackgroundSelectLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTBeamSelectLayer.h"
#import "BTIncludes.h"

@implementation BTBeamSelectLayer

- (id) initWithHopshopLayer:(BTHopshopLayer *)hopshop {
    self = [super init];
    if (self){
        
        hopshopLayer_ = hopshop;        
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"select.png"];
        background.position = ccp(240, 160);
        [self addChild:background z:0 tag:4];
        
        CCSprite *title = [CCSprite spriteWithSpriteFrameName:@"beam-title.png"];
        title.position = ccp(240, 282);
        [self addChild:title z:1 tag:5];
        
        CCSprite *comingSoon = [CCSprite spriteWithSpriteFrameName:@"coming-soon.png"];
        comingSoon.position = ccp(240, 160);
        [self addChild:comingSoon z:1];
        
        CCMenuItemSprite *exit = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"]selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
            [hopshopLayer_ returnToProminence];
            [self removeFromParent];
        }];
        exit.position = ccp(50, 35);
        
        CCMenu *menu = [CCMenu menuWithItems:exit, nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:2 tag:6];
    }
    return self;
}

- (void) lostProminence {
    
    
}

- (void) returnToProminence {
    
    
}

@end
