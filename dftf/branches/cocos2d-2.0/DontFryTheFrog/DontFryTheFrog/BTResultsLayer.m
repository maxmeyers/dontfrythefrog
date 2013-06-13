//
//  BTResultsLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/22/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTResultsLayer.h"
#import "BTIncludes.h"

@implementation BTResultsLayer 

@synthesize gameScene;

- (id) init {
    self = [super init];
    if (self){
        mainSprite = [CCSprite spriteWithSpriteFrameName:@"results.png"];
        mainSprite.position = ccp(240, 160);
        [self addChild:mainSprite z:0];
        
        leftArrowMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"left-arrow-undepressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"left-arrow-pressed.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"left-arrow-undepressed.png"] target:self selector:@selector(leftArrowPressed)];
        leftArrowMenuItem.position = ccp(39, 108);
        
        rightArrowMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"right-arrow-undepressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"right-arrow-pressed.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"right-arrow-undepressed.png"] target:self selector:@selector(rightArrowPressed)];        
        rightArrowMenuItem.position = ccp(277, 108);

        playButtonMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"play-button-undepressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"play-button-pressed.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"play-button-pressed.png"] target:self selector:@selector(playButtonPressed)];
        playButtonMenuItem.position = ccp(370, 110);
        
        menuButtonMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"menu-button-undepressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"menu-button-pressed.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"menu-button-pressed.png"] target:self selector:@selector(menuButtonPressed)];
        menuButtonMenuItem.position = ccp(390, 60);
        
        hopshopMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"hopshop-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"hopshop-pressed.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"hopshop-pressed.png"] block:^(id sender){
                AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [delegate openHopshop];
        }];
        hopshopMenuItem.position = ccp(370, 183);
        
        twitterMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"twitter.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"twitter.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"twitter.png"] target:self selector:@selector(twitterButtonPressed)];
        twitterMenuItem.position = ccp(112, 50);
        
        facebookMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"facebook.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"facebook.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"facebook.png"] target:self selector:@selector(facebookButtonPressed)];
        facebookMenuItem.position = ccp(twitterMenuItem.position.x+44, twitterMenuItem.position.y);
        
        gcMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"GameCenter.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"GameCenter.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"GameCenter.png"] target:self selector:@selector(gcButtonpressed)];
        gcMenuItem.position = ccp(facebookMenuItem.position.x+44, twitterMenuItem.position.y);
        
        CCMenu *menu = [CCMenu menuWithItems:leftArrowMenuItem, rightArrowMenuItem, playButtonMenuItem, menuButtonMenuItem, hopshopMenuItem, twitterMenuItem, facebookMenuItem, gcMenuItem, nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:2];
    }
    
    return self;
}

- (id) initWithScore:(int) score AllTimeScore:(int) allTimeScore FliesFried:(int) fliesFried AllTimeFliesFried:(int) allTimeFliesFried FlyPennies:(int) flyPennies Multiplier:(int) multiplier AllTimeMultiplier:(int) alltimeMultiplier Bank:(int) bank {
    self = [self init];
    if (self){
        NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:[numberFormatter stringFromNumber:[NSNumber numberWithInt:score]] dimensions:CGSizeMake(150, 25) alignment:UITextAlignmentCenter fontName:@"soupofjustice" fontSize:24];
        scoreLabel.position = ccp(86, 253);
        [self addChild:scoreLabel z:1];
        
        CCLabelTTF *fliesFriedLabel = [CCLabelTTF labelWithString:[numberFormatter stringFromNumber:[NSNumber numberWithInt:fliesFried]] dimensions:CGSizeMake(150, 25) alignment:UITextAlignmentCenter fontName:@"soupofjustice" fontSize:24];
        fliesFriedLabel.position = ccp(203, 253);
        [self addChild:fliesFriedLabel z:1];
        
        CCLabelTTF *bestScoreLabel = [CCLabelTTF labelWithString:[numberFormatter stringFromNumber:[NSNumber numberWithInt:allTimeScore]] dimensions:CGSizeMake(75, 16) alignment:UITextAlignmentCenter fontName:@"soupofjustice" fontSize:16];
        bestScoreLabel.position = ccp(89, 210);
        [self addChild:bestScoreLabel z:1];
        
        int highFliesFried = allTimeFliesFried;
        if (fliesFried > highFliesFried){
            highFliesFried = fliesFried;
        }
        CCLabelTTF *bestFliesFriedLabel = [CCLabelTTF labelWithString:[numberFormatter stringFromNumber:[NSNumber numberWithInt:highFliesFried]] dimensions:CGSizeMake(75, 16) alignment:UITextAlignmentCenter fontName:@"soupofjustice" fontSize:16];
        bestFliesFriedLabel.position = ccp(205, 210);
        [self addChild:bestFliesFriedLabel z:1];
        
        CCLabelTTF *flyPenniesLabel = [CCLabelTTF labelWithString:[numberFormatter stringFromNumber:[NSNumber numberWithInt:flyPennies]] dimensions:CGSizeMake(100, 32) alignment:UITextAlignmentRight fontName:@"soupofjustice" fontSize:30];
        flyPenniesLabel.position = ccp(332, 245);
        flyPenniesLabel.color = ccc3(206, 162, 31);
        [self addChild:flyPenniesLabel z:1];
        
        CCLabelTTF *bankLabel = [CCLabelTTF labelWithString:[numberFormatter stringFromNumber:[NSNumber numberWithInt:bank]] dimensions:CGSizeMake(100, 30) alignment:UITextAlignmentRight fontName:@"soupofjustice" fontSize:20];
        bankLabel.position = ccp(365, 162);
        bankLabel.color = flyPenniesLabel.color;
        [self addChild:bankLabel z:3];
                
        BTHighScoreBox *alltimeHighScoreBox = [[[BTHighScoreBox alloc] initWithTimeScope:GKLeaderboardTimeScopeAllTime LastScore:score] autorelease];
        alltimeHighScoreBox.position = kBoxOffScreen;
        [self addChild:alltimeHighScoreBox z:1 tag:kAllTimeHighScoreBoxTag];
        
        BTHighScoreBox *weeklyHighScoreBox = [[[BTHighScoreBox alloc] initWithTimeScope:GKLeaderboardTimeScopeWeek LastScore:score] autorelease];
        weeklyHighScoreBox.position = kBoxOffScreen;
        [self addChild:weeklyHighScoreBox z:1 tag:kWeeklyHighScoreBoxTag];
        
        BTDrTimBox *drTimBox = [[[BTDrTimBox alloc] initWithLastScore:score AllTimeHighScoreBox:alltimeHighScoreBox WeeklyHighScoreBox:weeklyHighScoreBox] autorelease];
        drTimBox.position = kBoxOffScreen;
        [self addChild:drTimBox z:1 tag:kDrTimBoxTag];

        highscoreBoxes = [[NSArray alloc] initWithObjects:drTimBox, alltimeHighScoreBox, weeklyHighScoreBox, nil];
        currentHighScoreBox = [highscoreBoxes objectAtIndex:0];
        currentHighScoreBox.position = kBoxOnScreen;
        
        [numberFormatter release];
    }
    return self;
}

- (void) playButtonPressed {
//    [self removeFromParentAndCleanup:YES];
    
    if (gameScene != nil){
        [gameScene resetGame];
    } else {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [self setGameScene:[delegate gameScene]];
        [gameScene resetGame];
    }
    
    [[CCDirector sharedDirector] popScene];
}

- (void) menuButtonPressed {
    [self removeFromParentAndCleanup:YES];

    [gameScene resetGame];
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] exitToMainMenu];

}

- (void) hopshopButtonPressed {
    
}

- (void) facebookButtonPressed {
    BTDrTimBox *drTimBox = (BTDrTimBox *)[self getChildByTag:kDrTimBoxTag];
    NSString *string = @"I just played Don't Fry the Frog!";
    if (drTimBox && [drTimBox socialAchievement] && [[drTimBox socialAchievement] achieved]){
        string = [[drTimBox socialAchievement] socialString];
    }

    NSURL *url = [NSURL URLWithString:@"http://dontfrythefrog.com"];
    SHKItem *item = [SHKItem URL:url title:string];
    [SHKFacebook shareItem:item];
}

- (void) twitterButtonPressed {
    BTDrTimBox *drTimBox = (BTDrTimBox *)[self getChildByTag:kDrTimBoxTag];
    NSString *string = @"I just played Don't Fry the Frog!";
    if (drTimBox && [drTimBox socialAchievement] && [[drTimBox socialAchievement] achieved]){
        string = [[drTimBox socialAchievement] socialString];
    }
    SHKItem *item = [SHKItem text:[NSString stringWithFormat:@"%@ http://dontfrythefrog.com", string]];
    [SHKTwitter shareItem:item];


}
- (void) gcButtonpressed {
    if ([GKLocalPlayer localPlayer].authenticated){
        [[BTGameCenterManager sharedManager] showLeaderboard];
    } else {
        BTAlertView *alertView = [[BTAlertView alloc] initWithTitle:@"Error" message:@"Must be logged into Game Center." delegate:nil cancelButtonTitle:@"Oh, okay..." otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }
}

- (void) leftArrowPressed {
    currentHighScoreBox.position = kBoxOffScreen;
    int currentIndex = [highscoreBoxes indexOfObject:currentHighScoreBox];
    int newIndex = currentIndex - 1;
    if (newIndex < 0){
        newIndex = [highscoreBoxes count] - 1;
    }
    currentHighScoreBox = [highscoreBoxes objectAtIndex:newIndex];
    currentHighScoreBox.position = kBoxOnScreen;
    if ([currentHighScoreBox isMemberOfClass:[BTDrTimBox class]]){
        [self showSocialButtons:YES];
    } else {
        [self showSocialButtons:NO];
    }
}

- (void) rightArrowPressed {
    currentHighScoreBox.position = kBoxOffScreen;
    int currentIndex = [highscoreBoxes indexOfObject:currentHighScoreBox];
    int newIndex = currentIndex + 1;
    if (newIndex > [highscoreBoxes count] - 1){
        newIndex = 0;
    }
    currentHighScoreBox = [highscoreBoxes objectAtIndex:newIndex];
    currentHighScoreBox.position = kBoxOnScreen;
    if ([currentHighScoreBox isMemberOfClass:[BTDrTimBox class]]){
        [self showSocialButtons:YES];
    } else {
        [self showSocialButtons:NO];
    }
}

- (void) showSocialButtons:(bool)show {
    facebookMenuItem.visible = show;
    facebookMenuItem.isEnabled = show;
    
    twitterMenuItem.visible = show;
    twitterMenuItem.isEnabled = show;
    
    gcMenuItem.visible = show;
    gcMenuItem.isEnabled = show;
}

- (void) dealloc {
    [highscoreBoxes release];
    [super dealloc];
}

@end
