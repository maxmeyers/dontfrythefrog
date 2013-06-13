//
//  BTOptionsMenuLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTOptionsMenuLayer.h"
#import "BTIncludes.h"

@implementation BTOptionsMenuLayer

+ (CCSprite *) lilypadTitleWithString:(NSString *) string {
    return [BTUtils spriteWithString:string fontName:@"soupofjustice" fontSize:34 color:ccWHITE strokeSize:1 strokeColor:ccc3(44, 84, 4)];
 
}

- (id) init {
    self = [super init];
    if (self){
        credits = [[BTCreditsScene node] retain];
        
        CCSprite *lilyUnderlay = [CCSprite spriteWithSpriteFrameName:@"lilypad-underlay.png"];
        lilyUnderlay.position = ccp(240, 280);
        [self addChild:lilyUnderlay z:2];
        
        CCSprite *optionsHeader = [BTUtils spriteWithString:NSLocalizedString(@"Options", nil) fontName:@"soupofjustice" fontSize:60 color:ccWHITE strokeSize:1 strokeColor:btGREEN];
        optionsHeader.position = ccp(240, 280);
        [self addChild:optionsHeader z:3];
        
        CCMenu *menu = [CCMenu menuWithItems:nil];
        menu.position = ccp(0, 0);
        [self addChild:menu z:0 tag:kMainMenuTag];
        
        BTMenuLilypad *aboutButton = [[[BTMenuLilypad alloc] initWithPressed:NO] autorelease];
        BTMenuLilypad *aboutButtonPressed = [[[BTMenuLilypad alloc] initWithPressed:YES] autorelease];
        CCMenuItemSprite *aboutButtonItem = [CCMenuItemSprite itemFromNormalSprite:aboutButton selectedSprite:aboutButtonPressed block:^(id sender){
            [[SimpleAudioEngine sharedEngine] playEffect:@"MenuSelect.m4a"];
            [[CCDirector sharedDirector] pushScene:credits];
        }];
        aboutButtonItem.position = ccp(240, 130);
        [menu addChild:aboutButtonItem];
        CCSprite *aboutTitle = [BTOptionsMenuLayer lilypadTitleWithString:NSLocalizedString(@"About", nil)];
        aboutTitle.position = aboutButtonItem.position;
        [self addChild:aboutTitle z:2];
        
        
        
        BTMenuLilypad *helpButton = [[[BTMenuLilypad alloc] initWithPressed:NO] autorelease];
        BTMenuLilypad *helpButtonPressed = [[[BTMenuLilypad alloc] initWithPressed:YES] autorelease];
        CCMenuItemSprite *helpButtonItem = [CCMenuItemSprite itemFromNormalSprite:helpButton selectedSprite:helpButtonPressed block:^(id sender){
            [[SimpleAudioEngine sharedEngine] playEffect:@"MenuSelect.m4a"];
            CCLayerColor *layerColor = [CCLayerColor layerWithColor:ccc4(79, 82, 83, 200)];
            [self addChild:layerColor z:6];
            
            CCSprite *helpScreen = [CCSprite spriteWithSpriteFrameName:@"simplehelp.png"];
            helpScreen.position = ccp(240, 160);
            [self addChild:helpScreen z:7];
            
            [(CCMenu *)[self getChildByTag:kMainMenuTag] setIsTouchEnabled:NO];
            CCMenu *helpMenu = [CCMenu menuWithItems:nil];
            helpMenu.position = ccp(0,0);
            CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
                [helpScreen removeFromParentAndCleanup:YES];
                [layerColor removeFromParentAndCleanup:YES];
                [helpMenu removeFromParentAndCleanup:YES];
                [(CCMenu *)[self getChildByTag:kMainMenuTag] setIsTouchEnabled:YES];
                
            }];
            backButton.position = ccp(50, 25);
            [helpMenu addChild:backButton];
            [self addChild:helpMenu z:8];
            [(CCMenu *)[self getChildByTag:kMainMenuTag] setIsTouchEnabled:NO];
        }];
        helpButtonItem.position = ccp(120, 80);
        [menu addChild:helpButtonItem];
        CCSprite *helpTitle = [BTOptionsMenuLayer lilypadTitleWithString:NSLocalizedString(@"Help", nil)];
        helpTitle.position = helpButtonItem.position;
        [self addChild:helpTitle z:1];
        
        BTMenuLilypad *audioButton = [[[BTMenuLilypad alloc] initWithPressed:NO] autorelease];
        BTMenuLilypad *audioButtonPressed = [[[BTMenuLilypad alloc] initWithPressed:YES] autorelease];
        CCMenuItemSprite *audioButtonItem = [CCMenuItemSprite itemFromNormalSprite:audioButton selectedSprite:audioButtonPressed block:^(id sender){
            [[SimpleAudioEngine sharedEngine] playEffect:@"MenuSelect.m4a"];
            BTSoundMenuLayer *soundMenuLayer = [BTSoundMenuLayer node];
            menu.isTouchEnabled = NO;
            [self addChild:soundMenuLayer z:6];
        }];
        audioButtonItem.position = ccp(360, 180);
        [menu addChild:audioButtonItem];
        CCSprite *audioTitle = [BTOptionsMenuLayer lilypadTitleWithString:NSLocalizedString(@"Audio", nil)];
        audioTitle.position = audioButtonItem.position;
        [self addChild:audioTitle z:1];
        
        BTMenuLilypad *resetButton = [[[BTMenuLilypad alloc] initWithPressed:NO] autorelease];
        BTMenuLilypad *resetButtonPressed = [[[BTMenuLilypad alloc] initWithPressed:YES] autorelease];
        CCMenuItemSprite *resetButtonItem = [CCMenuItemSprite itemFromNormalSprite:resetButton selectedSprite:resetButtonPressed block:^(id sender){
            [[SimpleAudioEngine sharedEngine] playEffect:@"MenuSelect.m4a"];
            UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Reset_Title", nil) message:NSLocalizedString(@"Reset_Message", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Reset_Cancel", nil) otherButtonTitles:NSLocalizedString(@"Reset_Okay", nil), nil] autorelease];
            [alertView show];
        }];
        resetButtonItem.position = ccp(360, 80);
        [menu addChild:resetButtonItem];
        CCSprite *resetTitle = [BTOptionsMenuLayer lilypadTitleWithString:NSLocalizedString(@"Reset", nil)];
        resetTitle.position = resetButtonItem.position;
        [self addChild:resetTitle z:1];
        
        BTMenuLilypad *statsButton = [[[BTMenuLilypad alloc] initWithPressed:NO] autorelease];
        BTMenuLilypad *statsButtonPressed = [[[BTMenuLilypad alloc] initWithPressed:YES] autorelease];
        CCMenuItemSprite *statsButtonMenuItem = [CCMenuItemSprite itemFromNormalSprite:statsButton selectedSprite:statsButtonPressed block:^(id sender){
            BTMainMenuScene *mainMenuScene = (BTMainMenuScene *)[self parent];
            [mainMenuScene pushMenu:[mainMenuScene statsMenuLayer]];
            [[SimpleAudioEngine sharedEngine] playEffect:@"MenuSelect.m4a"];
        }];
        statsButtonMenuItem.position = ccp(120, 180);
        [menu addChild:statsButtonMenuItem];
        CCSprite *statsTitle = [BTOptionsMenuLayer lilypadTitleWithString:NSLocalizedString(@"Stats", nil)];
        statsTitle.position = statsButtonMenuItem.position;
        [self addChild:statsTitle z:1];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
            BTMainMenuScene *mainMenuScene = (BTMainMenuScene *)[self parent];
            [mainMenuScene popMenu];
        }];
        backButton.position = ccp(50, 30);
        [menu addChild:backButton];

    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1){
        [BTStorageManager reset];
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Reset_Complete", nil) message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] autorelease];
        [alertView show];
    }
}

- (void) dealloc {
    [credits release];
    [super dealloc];
}

@end
