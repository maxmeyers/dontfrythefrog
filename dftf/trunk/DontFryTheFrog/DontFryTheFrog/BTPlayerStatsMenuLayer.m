//
//  BTStatsMenuLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTPlayerStatsMenuLayer.h"
#import "BTIncludes.h"

@implementation BTPlayerStatsMenuLayer

- (id) init {
    self = [super init];
    if (self){
        CCSprite *lilyUnderlay = [CCSprite spriteWithSpriteFrameName:@"lilypad-underlay.png"];
        lilyUnderlay.position = ccp(240, 280);
        [self addChild:lilyUnderlay z:2];
        
        CCSprite *statsHeader = [BTUtils spriteWithString:NSLocalizedString(@"Player", nil) fontName:@"soupofjustice" fontSize:60 color:ccWHITE strokeSize:1 strokeColor:btGREEN];
        statsHeader.position = ccp(240, 280);
        [self addChild:statsHeader z:3];
        
        CCMenu *menu = [CCMenu menuWithItems:nil];
        menu.position = ccp(0, 0);
        [self addChild:menu z:4 tag:kMainMenuTag];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
            BTMainMenuScene *mainMenuScene = (BTMainMenuScene *)[self parent];
            [mainMenuScene popMenu];
        }];
        backButton.position = ccp(50, 20);
        [menu addChild:backButton];
        
        CCLayerColor *background = [CCLayerColor layerWithColor:ccc4(100, 100, 100, 200) width:430 height:230];
        background.position = ccp(25, 15);
        [self addChild:background z:0];        
                
        column1 = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(200, 100) alignment:UITextAlignmentLeft lineBreakMode:UILineBreakModeWordWrap fontName:@"Marker Felt" fontSize:18];
        column1.position = ccp(155, 92);
        [self addChild:column1 z:2];
        
        column2 = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(200, 220) alignment:UITextAlignmentLeft fontName:@"Marker Felt" fontSize:18];
        column2.position = ccp(370, 132);
        [self addChild:column2 z:2];
              
        levelTitle = [CCLabelTTF labelWithString:@"" fontName:@"soupofjustice" fontSize:35];
        levelTitle.position = ccp(180, 210);
        [self addChild:levelTitle z:2];
        
        levelName = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(175, 65) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:20];
        levelName.position = ccp(180, 166);
        levelName.color = ccc3(179, 255, 199);
        [self addChild:levelName z:2];
        
        [self refresh];
    }
    return self;
}

- (void) refresh {
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *string1 = [NSString stringWithFormat:@"Highest Score: %@\nMost Flies Fried: %@\nTime Spent at x25: %@\nFly Pennies Earned: %@\nFly Pennies Spent: %@", 
                              [numberFormatter stringFromNumber:[NSNumber numberWithInt:[BTStorageManager highscore]]],
                              [numberFormatter stringFromNumber:[NSNumber numberWithInt:[BTStorageManager highFliesFried]]],
                              [BTConfig timeFormatted:(int)[[BTStatsManager sharedManager] maxBeamBonusTime]],
                              [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTStatsManager sharedManager] flyPenniesEarned]]],
                              [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTStatsManager sharedManager] flyPenniesSpent]]]];

    [column1 setString:string1];
    
    NSString *string2 = [NSString stringWithFormat:@"Flies Fried: %@\nGrey Flies Fried: %@\nYellow Flies Fried: %@\nRed Flies Fried: %@\nGreen Flies Eaten: %@\nBlue Flies Eaten: %@\n\nPlay Time: %@\nGames Played: %@\nFrogs Fried: %@\nFrogs Exploded: %@", 
                             [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTStatsManager sharedManager] totalFliesFried]]],
                             [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTStatsManager sharedManager] greyFliesFried]]],
                             [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTStatsManager sharedManager] yellowFliesFried]]],
                             [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTStatsManager sharedManager] redFliesFried]]],
                             [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTStatsManager sharedManager] greenFliesEaten]]],
                             [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTStatsManager sharedManager] blueFliesEaten]]],
                             [BTConfig timeWithHoursFormatted:(int)[[BTStatsManager sharedManager] totalPlayTime]],
                             [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTStatsManager sharedManager] gamesPlayed]]],
                             [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTStatsManager sharedManager] frogsFried]]],
                             [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTStatsManager sharedManager] frogsExploded]]]];
    [column2 setString:string2];
    
    int level = [BTStorageManager playerLevel];
    if (level >= 0 && level <= 30){
        [levelTitle setString:[NSString stringWithFormat:@"Level %d:", level]];
        [levelName setString:[[BTLeapManager sharedManager] nameForLevel:level]];
        //    [levelName setString:@"Rocky Mountain Tailed Frog"];
        
        [frogSprite removeFromParentAndCleanup:YES];
        frogSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"level-%d.png", level]];
        frogSprite.position = ccp(65, 190);
        [self addChild:frogSprite z:2];
    }

}

@end
