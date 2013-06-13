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
        CCSprite *background = [CCSprite spriteWithFile:@"baseleveling.png"];
        background.position = ccp(240, 160);
        [self addChild:background z:0];
        
        CCLabelTTF *padsRemainingTitleLabel = [CCLabelTTF labelWithString:@"Lilypads until next level:" dimensions:CGSizeMake(150, 100) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:30];
        padsRemainingTitleLabel.position = ccp(87, 190);
        [self addChild:padsRemainingTitleLabel z:1 tag:kPadsRemainingTitleTag];
        
        CCLabelTTF *padsRemainingLabel = [CCLabelTTF labelWithString:@"" fontName:@"soupofjustice" fontSize:40];
        padsRemainingLabel.position = ccp(115, 115);
        [self addChild:padsRemainingLabel z:1 tag:kPadsRemainingLabelTag];
        
        CCSprite *padsRemainingSprite = [CCSprite spriteWithFile:@"lillybadge.png"];
        padsRemainingSprite.position = ccp(49, 115);
        [self addChild:padsRemainingSprite z:1 tag:kPadsRemainingTag];
        
        NSString *currentLevelString = [NSString stringWithFormat:@"Leap Level %d", [BTStorageManager playerLevel]];
        CCLabelTTF *currentLevelLabel = [CCLabelTTF labelWithString:currentLevelString fontName:@"soupofjustice" fontSize:24];
        currentLevelLabel.position = ccp(87, 305);
        [self addChild:currentLevelLabel z:1 tag:kCurrentLevelTag];
        
        NSString *currentNameString = [[BTLeapManager sharedManager] nameForCurrentLevel];
        CCLabelTTF *currentNameLabel = [CCLabelTTF labelWithString:currentNameString dimensions:CGSizeMake(160, 50) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:18];
        currentNameLabel.position = ccp(87, 265);
        [self addChild:currentNameLabel z:1 tag:kCurrentNameTag];
        
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
    
//    if ([self getChildByTag:kCurrentLevelTag]){
//        CCLabelTTF *currentLevelLabel = (CCLabelTTF *)[self getChildByTag:kCurrentLevelTag];
//        NSString *currentLevelString = [NSString stringWithFormat:@"Leap Level %d", [BTStorageManager playerLevel]];
//        [currentLevelLabel setString:currentLevelString];
//    }
//    
//    if ([self getChildByTag:kCurrentNameTag]){
//        CCLabelTTF *currentNameLabel = (CCLabelTTF *)[self getChildByTag:kCurrentNameTag];
//        NSString *currentNameString = [[BTLeapManager sharedManager] nameForCurrentLevel];
//        [currentNameLabel setString:currentNameString];
//    }
}

@end
