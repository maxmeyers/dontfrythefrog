//
//  BTStatsMenuLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTStatsMenuLayer.h"
#import "BTIncludes.h"

@implementation BTStatsMenuLayer

- (id) init {
    self = [super init];
    if (self){
        CCSprite *lilyUnderlay = [CCSprite spriteWithSpriteFrameName:@"lilypad-underlay.png"];
        lilyUnderlay.position = ccp(240, 280);
        [self addChild:lilyUnderlay z:2];
        
        CCSprite *statsHeader = [BTUtils spriteWithString:NSLocalizedString(@"Stats", nil) fontName:@"soupofjustice" fontSize:60 color:ccWHITE strokeSize:1 strokeColor:btGREEN];
        statsHeader.position = ccp(240, 280);
        [self addChild:statsHeader z:3];
        
        CCMenu *menu = [CCMenu menuWithItems:nil];
        menu.position = ccp(0, 0);
        [self addChild:menu z:0 tag:kMainMenuTag];

        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
            BTMainMenuScene *mainMenuScene = (BTMainMenuScene *)[self parent];
            [mainMenuScene popMenu];
        }];
        backButton.position = ccp(50, 30);
        [menu addChild:backButton];
        
        BTMenuLilypad *playerButton = [[[BTMenuLilypad alloc] initWithPressed:NO] autorelease];
        BTMenuLilypad *playerButtonPressed = [[[BTMenuLilypad alloc] initWithPressed:YES] autorelease];
        CCMenuItemSprite *playerButtonItem = [CCMenuItemSprite itemFromNormalSprite:playerButton selectedSprite:playerButtonPressed block:^(id sender){
            [[SimpleAudioEngine sharedEngine] playEffect:@"MenuSelect.m4a"];
            BTMainMenuScene *mainMenuScene = (BTMainMenuScene *)[self parent];
            [[mainMenuScene playerStatsMenuLayer] refresh];
            [mainMenuScene pushMenu:[mainMenuScene playerStatsMenuLayer]];
        }];
        playerButtonItem.position = ccp(240, 160);
        [menu addChild:playerButtonItem];
        CCLabelTTF *playerTitle = [CCLabelTTF labelWithString:@"player" fontName:@"soupofjustice" fontSize:34];
        playerTitle.position = playerButtonItem.position;
        [self addChild:playerTitle z:1];
    }
    
    return self;
}

@end
