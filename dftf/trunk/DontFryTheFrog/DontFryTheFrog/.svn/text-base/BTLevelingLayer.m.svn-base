//
//  BTLevelingLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTLevelingLayer.h"
#import "BTIncludes.h"

@implementation BTLevelingLayer

- (id) init {
    self = [super init];
    if (self){
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"baseleveling.png"];
        background.position = ccp(89, 160);
        [self addChild:background z:0];
        
        CCSprite *title = [CCSprite spriteWithSpriteFrameName:@"levelingtitle.png"];
        title.position = ccp(330, 282);
        [self addChild:title z:0];
        
        CCLabelTTF *padsRemainingTitleLabel = [CCLabelTTF labelWithString:@"Lilypads needed to level up:" dimensions:CGSizeMake(150, 100) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:30];
        padsRemainingTitleLabel.position = ccp(87, 190);
        [self addChild:padsRemainingTitleLabel z:1 tag:kPadsRemainingTitleTag];
        
        CCLabelTTF *padsRemainingLabel = [CCLabelTTF labelWithString:@"" fontName:@"soupofjustice" fontSize:40];
        padsRemainingLabel.position = ccp(115, 115);
        [self addChild:padsRemainingLabel z:1 tag:kPadsRemainingLabelTag];
        
        CCSprite *padsRemainingSprite = [CCSprite spriteWithSpriteFrameName:@"lillybadge.png"];
        padsRemainingSprite.position = ccp(49, 115);
        [self addChild:padsRemainingSprite z:1 tag:kPadsRemainingTag];
        
        int level = [BTStorageManager playerLevel];
        if (level >= 0 && level <= 30){
            CCSprite *frogSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"level-%d.png", level]];
            frogSprite.position = ccp(35, 285);
            [self addChild:frogSprite z:1 tag:kCurrentFrogSpriteTag];
            
            NSString *currentLevelString = [NSString stringWithFormat:@"Leap Level %d", level];
            CCLabelTTF *currentLevelLabel = [CCLabelTTF labelWithString:currentLevelString fontName:@"soupofjustice" fontSize:20];
            currentLevelLabel.position = ccp(115, 305);
            [self addChild:currentLevelLabel z:1 tag:kCurrentLevelTag];
            
            NSString *currentNameString = [[BTLeapManager sharedManager] nameForLevel:level];
            CCLabelTTF *currentNameLabel = [CCLabelTTF labelWithString:currentNameString dimensions:CGSizeMake(95, 50) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:16];
            currentNameLabel.position = ccp(115, 270);
            [self addChild:currentNameLabel z:1 tag:kCurrentNameTag];
        }
        
        [self refresh];
    }
    return self;
}

- (void) refresh {
    if ([self getChildByTag:kPadsRemainingTag]){
        CCLabelTTF *padsRemainingLabel = (CCLabelTTF *)[self getChildByTag:kPadsRemainingLabelTag];
        NSString *padsRemainingString = [NSString stringWithFormat:@"x%d", [BTStorageManager padsRemaining]];
        [padsRemainingLabel setString:padsRemainingString];
    }
}

@end
