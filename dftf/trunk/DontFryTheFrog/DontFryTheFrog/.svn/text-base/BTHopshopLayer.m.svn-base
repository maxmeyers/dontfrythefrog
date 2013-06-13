//
//  BTHopshopLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTHopshopLayer.h"
#import "BTIncludes.h"

@implementation BTHopshopLayer

@synthesize hopshopDetails, hopshopScene = hopshopScene_;

- (id) init {
    self = [super init];
    if (self) {       
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTMenus.plist" textureFile:@"BTMenus.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTHopshop.plist" textureFile:@"BTHopshop.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTHopshop-Flies.plist" textureFile:@"BTHopshop-Flies.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTBackgroundThumbs.plist" textureFile:@"BTBackgroundThumbs.pvr.ccz"];
        
        if ([[BTConfig sharedConfig] readFromPlist]){
            self.hopshopDetails = [[BTHopshopDetails alloc] init];
            [NSKeyedArchiver archiveRootObject:self.hopshopDetails toFile:@"/Users/mmeyers/Desktop/HopshopDetails.bin"];
        } else {
            self.hopshopDetails = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"HopshopDetails" ofType:@"bin"]] retain];
        }
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"hopshop.png"];
        background.position = ccp(240, 160);
        [self addChild:background z:0];
        
        CCSprite *zekeWelcome = [CCSprite spriteWithSpriteFrameName:@"zeke-welcome.png"];
        zekeWelcome.position = ccp(390, 107);
        [self addChild:zekeWelcome z:2 tag:kZekeWelcomeTag];
        
        CCMenuItemSprite *beamButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"Beam-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"Beam-pressed.png"] block:^(id sender) {
            [self lostProminence];
            [self addChild:[[[BTBeamSelectLayer alloc] initWithHopshopLayer:self] autorelease] z:2];
        }];
        beamButton.tag = kBeamButtonTag;
        beamButton.position = ccp(153, 250); 
        
        CCMenuItemSprite *bgButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"BG-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"BG-pressed.png"] block:^(id sender) {
            [self lostProminence];
            [self addChild:[[[BTBackgroundSelectLayer alloc] initWithHopshopLayer:self] autorelease] z:2];
        }];
        bgButton.tag = kBGButtonTag;
        bgButton.position = ccp(225, 250);
        
        CCMenuItemSprite *hatButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"hats-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"hats-pressed.png"] block:^(id sender) {
            [BTHatSelectionScene showWithOrigin:kOriginHopshop];
        }];
        hatButton.tag = kBGButtonTag;
        hatButton.position = ccp(300, 250);
        
        CCMenuItemSprite *fpButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"FP-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"FP-pressed.png"] block:^(id sender) {
            [self lostProminence];
            [self addChild:[[[BTFlyPennySelectLayer alloc] initWithHopshopLayer:self] autorelease] z:2];
        }];
        fpButton.tag = kFPButtonTag;
        fpButton.position = ccp(80, 150);
        
        CCMenuItemSprite *flyButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"Fly-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"Fly-pressed.png"] block:^(id sender) {
            [self lostProminence];
            [self addChild:[[[BTBugUpgradeSelectLayer alloc] initWithHopshopLayer:self] autorelease] z:2];
        }];
        flyButton.tag = kFlyButtonTag;
        flyButton.position = ccp(165, 150);
        
        CCMenuItemSprite *toolButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"Tools-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"Tools-pressed.png"] block:^(id sender) {
            [self lostProminence];
            [self addChild:[[[BTToolSelectLayer alloc] initWithHopshopLayer:self] autorelease] z:2];
        }];
        toolButton.tag = kToolButtonTag;
        toolButton.position = ccp(241, 150);
        
        CCMenuItemSprite *playButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"play-button-undepressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"play-button-pressed.png"] block:^(id sender) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"MenuSelect.m4a"];
            if ([(BTHopshopScene *)[self parent] hasCompletedMission]){
                BTPostGameScene *postGameScene = [[[BTPostGameScene alloc] initWithResultsLayer:nil GameScene:nil Destination:@"BTGameScene"] autorelease];
                [[CCDirector sharedDirector] pushScene:postGameScene];
            } else {
                AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [delegate exitToMainMenu];
                [delegate startGame];
            }
        }];
        playButton.position = ccp(395, 275);
        
        CCMenuItemSprite *homeButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"home-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"home-pressed.png"] block:^(id sender){
            if ([(BTHopshopScene *)[self parent] hasCompletedMission]){
                BTPostGameScene *postGameScene = [[[BTPostGameScene alloc] initWithResultsLayer:nil GameScene:nil Destination:@"BTMainMenuScene"] autorelease];
                [[CCDirector sharedDirector] pushScene:postGameScene];
            } else {
                AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [delegate exitToMainMenu];
            }
        }]; 
        homeButton.position = ccp(40, 37);
        
        CCMenu *menu = [CCMenu menuWithItems:beamButton, bgButton, hatButton, fpButton, flyButton, toolButton, playButton, homeButton, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu z:1 tag:6];
        
        flyPenniesLabel = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(82, 27) alignment:UITextAlignmentRight fontName:@"soupofjustice" fontSize:25];
        flyPenniesLabel.position = ccp(41, 302);
        flyPenniesLabel.color = ccc3(0, 135, 11);
        [self addChild:flyPenniesLabel z:5];
        
        CCSprite *coinbox = [CCSprite spriteWithSpriteFrameName:@"coin-box.png"];
        coinbox.position = ccp(62, 301);
        [self addChild:coinbox z:4];
        
        if ([SKPaymentQueue canMakePayments]){
            SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects: @"FP5000", @"FP10500", @"FP16500", @"FP28000", @"FP70000", @"PENNY.PYRAMID", nil]];
            request.delegate = [BTHopshopManager sharedHopshopManager];
            [request start];
        }
    }
    
    [self scheduleUpdate];
    
    return self;
}

- (void) lostProminence {
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:[self getChildByTag:6]];
}

- (void) returnToProminence {
    [(CCMenu *)[self getChildByTag:6] registerWithTouchDispatcher];
}

- (void) update:(ccTime) dt {   
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *hopshopTokensString = [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTHopshopManager sharedHopshopManager] flyTokens]]];
    if (![[flyPenniesLabel string] isEqualToString:hopshopTokensString]) {
        [flyPenniesLabel setString:hopshopTokensString];
    }
}

@end
