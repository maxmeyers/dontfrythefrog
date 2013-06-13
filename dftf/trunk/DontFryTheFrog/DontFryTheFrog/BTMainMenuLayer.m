//
//  BTMainMenuLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/26/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTMainMenuLayer.h"
#import "BTIncludes.h"
#import "Appirater.h"


@implementation BTMainMenuLayer

BTConfigScene *configScene;

- (id) init {
    if ((self = [super init])){
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTMenus.plist" textureFile:@"BTMenus.pvr.ccz"];
        
        configScene = [[BTConfigScene alloc] init];
                     
        CCSprite *sign = [CCSprite spriteWithSpriteFrameName:@"title-swing-1.png"];
        sign.position = ccp(240, 259);
        [self addChild:sign z:3];
        
        CCAnimate *swingForward = [CCAnimate actionWithAnimation:[BTStorageManager animationWithString:@"BTStartSign" atInterval:0.1 Reversed:NO] restoreOriginalFrame:NO];
        [sign runAction:[CCRepeatForever actionWithAction:swingForward]];
        
        BTMenuLilypad *startButton = [[[BTMenuLilypad alloc] initWithPressed:NO] autorelease];
        BTMenuLilypad *startButtonPressed = [[[BTMenuLilypad alloc] initWithPressed:YES] autorelease];      
        CCMenuItemSprite *startButtonMenuItem = [CCMenuItemSprite itemFromNormalSprite:startButton selectedSprite:startButtonPressed block:^(id sender){
            [self buttonPressed];
            [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
            BTMenuSelectionScene *scene = [BTMenuSelectionScene node];
            [[CCDirector sharedDirector] pushScene:scene];
        }];
        startButtonMenuItem.position = ccp(240, 125);
        CCSprite *startTitle = [BTUtils spriteWithString:NSLocalizedString(@"Play", nil) fontName:@"soupofjustice" fontSize:45 color:ccWHITE strokeSize:2 strokeColor:btGREEN];
        startTitle.position = startButtonMenuItem.position;
        [self addChild:startTitle z:2];
        
        BTMenuLilypad *optionsButton = [[[BTMenuLilypad alloc] initWithPressed:NO] autorelease];
        BTMenuLilypad *optionsButtonPressed = [[[BTMenuLilypad alloc] initWithPressed:YES] autorelease];
        CCMenuItemSprite *optionsButtonMenuItem = [CCMenuItemSprite itemFromNormalSprite:optionsButton selectedSprite:optionsButtonPressed block:^(id sender){
            BTMainMenuScene *mainMenuScene = (BTMainMenuScene *)[self parent];
            [mainMenuScene pushMenu:[mainMenuScene optionsMenuLayer]];
            [[SimpleAudioEngine sharedEngine] playEffect:@"MenuSelect.m4a"];
        }];
        optionsButtonMenuItem.position = ccp(85, 50);
        CCSprite *optionsTitle = [BTUtils spriteWithString:NSLocalizedString(@"More", nil) fontName:@"soupofjustice" fontSize:40 color:ccWHITE strokeSize:1 strokeColor:btGREEN];
        optionsTitle.position = optionsButtonMenuItem.position;
        [self addChild:optionsTitle z:2];
                
        BTMenuLilypad *hopshopButton = [[[BTMenuLilypad alloc] initWithPressed:NO] autorelease];
        BTMenuLilypad *hopshopButtonPressed = [[[BTMenuLilypad alloc] initWithPressed:YES] autorelease];
        CCMenuItemSprite *hopshopButtonMenuItem = [CCMenuItemSprite itemFromNormalSprite:hopshopButton selectedSprite:hopshopButtonPressed target:self selector:@selector(hopshopButtonPressed)];
        hopshopButtonMenuItem.position = ccp(410, 50);
        CCSprite *hopshopTitle = [BTUtils spriteWithString:NSLocalizedString(@"Shop", nil) fontName:@"soupofjustice" fontSize:40 color:ccWHITE strokeSize:1 strokeColor:btGREEN];
        hopshopTitle.position = hopshopButtonMenuItem.position;
        [self addChild:hopshopTitle z:2];
        
        CCMenuItemSprite *facebookMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"facebook.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"facebook-pressed.png"] block:^(id sender){
            NSString *string = @"I'm playing Don't Fry the Frog!";
            NSURL *url = [NSURL URLWithString:@"http://dontfrythefrog.com"];
            SHKItem *item = [SHKItem URL:url title:string];
            [SHKFacebook shareItem:item];
        }];
        facebookMenuItem.position = ccp(20, 243);
        
        CCMenuItemSprite *twitterMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"twitter.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"twitter-pressed.png"] block:^(id sender){
            NSString *string = @"I'm playing Don't Fry the Frog!";
            SHKItem *item = [SHKItem text:[NSString stringWithFormat:@"%@ dontfrythefrog.com", string]];
            [SHKTwitter shareItem:item];
        }];
        twitterMenuItem.position = ccp(facebookMenuItem.position.x, facebookMenuItem.position.y - 44);
        
        CCMenuItemSprite *gcMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"GameCenter.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"gamecenter-pressed.png"] block:^(id sender){
            [self leaderboardButtonPressed];
        }];
        gcMenuItem.position = ccp(twitterMenuItem.position.x, twitterMenuItem.position.y - 44);
        
        CCLabelTTF *noticeLabel = [CCLabelTTF labelWithString:@"BETA Build belonging to Blacktorch Games LLC.\nWIP: Not representative of final game." dimensions:CGSizeMake(290, 32) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"Marker Felt" fontSize:14];
        noticeLabel.position = ccp(240, 307);
        noticeLabel.color = ccc3(255, 0, 0);
//        [self addChild:noticeLabel z:5];
    
        BTNewsLog *newsLog = [BTNewsLog sharedNewsLog];
        [self addChild:newsLog z:4 tag:kNewslogTag];
        
        CCMenuItem *newslogButton = [CCMenuItem itemWithBlock:^(id sender){
            [newsLog appear];
        }];
        newslogButton.position = ccp(437, 202);
        newslogButton.contentSize = CGSizeMake(96, 70);
        
        CCMenu *menu = [CCMenu menuWithItems:startButtonMenuItem, optionsButtonMenuItem, hopshopButtonMenuItem, newslogButton, facebookMenuItem, twitterMenuItem, gcMenuItem, nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:1 tag:kMainMenuTag];
    }
    return self;
}

- (void) buttonPressed {
    [[SimpleAudioEngine sharedEngine] playEffect:@"MenuSelect.m4a"];
}

- (void) highscoreButtonPressed {
    [self buttonPressed];
    CCScene *highscoreScene = [CCScene node];
    [highscoreScene addChild:[BTHighScoreLayer node]];
    [[CCDirector sharedDirector] pushScene:highscoreScene];
}

- (void) leaderboardButtonPressed {
    [self buttonPressed];

    if ([GKLocalPlayer localPlayer].authenticated){
        [[BTGameCenterManager sharedManager] showLeaderboard];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Must be logged into Game Center." delegate:nil cancelButtonTitle:@"Oh, okay..." otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
    }
}

- (void) configButtonPressed {
    [self buttonPressed];
        BTGameScene *scene = [[[BTGameScene alloc] init] autorelease];
        scene.score = 1680;
        scene.fliesFried = 50;
        scene.maxMultiplier = 2;
        [scene unscheduleUpdate];
        
        BTResultsLayer *resultsLayer = [[[BTResultsLayer alloc] initWithScore:0 AllTimeScore:12345 FliesFried:12345 AllTimeFliesFried:0 FlyPennies:0 Multiplier:25 AllTimeMultiplier:0 Bank:0 PlayTime:0] autorelease];
        [scene addChild:resultsLayer z:1]; 
    
    BTPostGameScene *postGameScene = [[[BTPostGameScene alloc] initWithResultsLayer:nil GameScene:nil Destination:@""] autorelease];
    
    [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInR transitionWithDuration:0.25 scene:postGameScene]];
}

- (void) hopshopButtonPressed {
    [self buttonPressed];
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];

    if ([BTStorageManager levelForTag:@"EverShoppedFromMainMenu"] == 0){
        [BTStorageManager setLevel:1 ForTag:@"EverShoppedFromMainMenu"];
        [FlurryAnalytics logEvent:@"Opened Hopshop From Main Menu for First Time"];         
    }
    [FlurryAnalytics logEvent:@"Opened Hopshop From Main Menu"];

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate openHopshop];
}

@end
