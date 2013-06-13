//
//  BTSoundMenuLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTSoundMenuLayer.h"
#import "BTIncludes.h"

#define kSoundsMenu 10
#define kSoundsOnTag 1
#define kSoundsOffTag 2
#define kMusicOnTag 3
#define kMusicOffTag 4

@implementation BTSoundMenuLayer

- (id) init {
    self = [super init];
    if (self){
        
        CCLayerColor *layerColor = [CCLayerColor layerWithColor:ccc4(79, 82, 83, 200)];
        [self addChild:layerColor z:0];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"sounds_background.png"];
        background.position = ccp(240, 160);
        [self addChild:background z:1];
    
        CCSprite *labels = [CCSprite spriteWithSpriteFrameName:@"sounds.png"];
        labels.position = ccp(165, 180);
        [self addChild:labels z:2];
        
        CCMenu *menu = [CCMenu menuWithItems:nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:2 tag:kSoundsMenu];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
            [self removeFromParent];
        }];
        backButton.position = ccp(145, 100);
        [menu addChild:backButton];
        
        NSString *soundsOnString = @"on-selected.png";
        if ([[SimpleAudioEngine sharedEngine] effectsVolume] < 1){
            soundsOnString = @"on-unselected.png";
        }
        CCMenuItemSprite *soundsOn = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:soundsOnString] selectedSprite:[CCSprite spriteWithSpriteFrameName:soundsOnString] block:^(id sender){
            [[BTConfig sharedConfig] setEffectsVolume:1.0];
            [self refresh];
        }];
        soundsOn.position = ccp(260, 197);
        [[self getChildByTag:kSoundsMenu] addChild:soundsOn z:0 tag:kSoundsOnTag];
        
        NSString *soundsOffString = @"off-selected.png";
        if ([[SimpleAudioEngine sharedEngine] effectsVolume] > 0){
            soundsOffString = @"off-unselected.png";
        }
        CCMenuItemSprite *soundsOff = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:soundsOffString] selectedSprite:[CCSprite spriteWithSpriteFrameName:soundsOffString] block:^(id sender){
            [[BTConfig sharedConfig] setEffectsVolume:0.0];
            [self refresh];
        }];
        soundsOff.position = ccp(320, 197);
        [[self getChildByTag:kSoundsMenu] addChild:soundsOff z:0 tag:kSoundsOffTag];
        
        NSString *musicOnString = @"on-selected.png";
        if ([[SimpleAudioEngine sharedEngine] backgroundMusicVolume] < 1){
            musicOnString = @"on-unselected.png";
        }
        CCMenuItemSprite *musicOn = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:musicOnString] selectedSprite:[CCSprite spriteWithSpriteFrameName:musicOnString] block:^(id sender){
            [[BTConfig sharedConfig] setMusicVolume:1.0];
            [self refresh];
        }];
        musicOn.position = ccp(260, 163);
        [[self getChildByTag:kSoundsMenu] addChild:musicOn z:0 tag:kMusicOnTag];
        
        NSString *musicOffString = @"off-selected.png";
        if ([[SimpleAudioEngine sharedEngine] backgroundMusicVolume] == 1){
            musicOffString = @"off-unselected.png";
        }
        CCMenuItemSprite *musicOff = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:musicOffString] selectedSprite:[CCSprite spriteWithSpriteFrameName:musicOffString] block:^(id sender){
            [[BTConfig sharedConfig] setMusicVolume:0.0];
            [self refresh];
        }];
        musicOff.position = ccp(320, 163); 
        [[self getChildByTag:kSoundsMenu] addChild:musicOff z:0 tag:kMusicOffTag];

    }
    
    return self;
}

- (void) refresh {    
    NSString *soundsOnString = @"on-selected.png";
    if ([[SimpleAudioEngine sharedEngine] effectsVolume] < 1){
        soundsOnString = @"on-unselected.png";
    }
    CCMenuItemSprite *soundsOn = (CCMenuItemSprite *)[[self getChildByTag:kSoundsMenu] getChildByTag:kSoundsOnTag];
    soundsOn.normalImage = [CCSprite spriteWithSpriteFrameName:soundsOnString];
    soundsOn.selectedImage = [CCSprite spriteWithSpriteFrameName:soundsOnString];
    
    NSString *soundsOffString = @"off-selected.png";
    if ([[SimpleAudioEngine sharedEngine] effectsVolume] > 0){
        soundsOffString = @"off-unselected.png";
    }
    CCMenuItemSprite *soundsOff = (CCMenuItemSprite *)[[self getChildByTag:kSoundsMenu] getChildByTag:kSoundsOffTag];
    soundsOff.normalImage = [CCSprite spriteWithSpriteFrameName:soundsOffString];
    soundsOff.selectedImage = [CCSprite spriteWithSpriteFrameName:soundsOffString];
    
    NSString *musicOnString = @"on-selected.png";
    if ([[SimpleAudioEngine sharedEngine] backgroundMusicVolume] < 1){
        musicOnString = @"on-unselected.png";
    }
    CCMenuItemSprite *musicOn = (CCMenuItemSprite *)[[self getChildByTag:kSoundsMenu] getChildByTag:kMusicOnTag];
    musicOn.normalImage = [CCSprite spriteWithSpriteFrameName:musicOnString];
    musicOn.selectedImage = [CCSprite spriteWithSpriteFrameName:musicOnString];
    
    NSString *musicOffString = @"off-selected.png";
    if ([[SimpleAudioEngine sharedEngine] backgroundMusicVolume] == 1){
        musicOffString = @"off-unselected.png";
    }
    CCMenuItemSprite *musicOff = (CCMenuItemSprite *)[[self getChildByTag:kSoundsMenu] getChildByTag:kMusicOffTag];
    musicOff.normalImage = [CCSprite spriteWithSpriteFrameName:musicOffString];
    musicOff.selectedImage = [CCSprite spriteWithSpriteFrameName:musicOffString];

}

- (void) removeFromParent {
    [(CCMenu *)[[self parent] getChildByTag:kMainMenuTag] setIsTouchEnabled:YES];
    [super removeFromParent];
}

@end
