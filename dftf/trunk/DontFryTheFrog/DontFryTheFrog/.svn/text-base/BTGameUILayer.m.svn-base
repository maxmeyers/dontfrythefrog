//
//  StartStopLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTGameUILayer.h"
#import "BTIncludes.h" 

#define kBeamWarningTag 15

@implementation BTGameUILayer

@synthesize scene;

@synthesize energyBar;

@synthesize pauseButton, bugSprayButton, lifeCounter;

CCLabelTTF *scoreLabel;
CCLabelTTF *highscoreLabel;
CCLabelTTF *multiplierLabel;
CCLabelTTF *maxMultiplierLabel;

//Debug Labels
CCLabelTTF *fliesFriedLabel;
CCLabelTTF *timeElapsedLabel;
CCLabelTTF *careerFliesLabel;
CCLabelTTF *frogSpeedLabel;
CCLabelTTF *catchIntervalLabel;
CCLabelTTF *metasequenceLabel;
CCLabelTTF *sequenceLabel;

- (id) init {
    if ((self = [super init])){
        [self scheduleUpdate];
                
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444]; // add this line at the very beginning

        pauseButton = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"pause.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"pause2.png"] block:^(id sender){
            [(BTGameScene *)[self parent] pauseGame];
        }];
        pauseButton.position = CGPointMake(459, 299);
        
        bugSprayButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"bugspray-icon.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"bugspray-icon.png"] block:^(id sender){
            [(BTGameScene *)[self parent] activateBugSpray];
        }];
        bugSprayButton.position = ccp(438, 40);
        bugSprayButton.visible = NO;
        bugSprayButton.isEnabled = NO;
        
        lifeCounter = [[[BTLifeCounter alloc] init] autorelease];
        [self addChild:lifeCounter z:2];
        
        CCMenu *menu = [CCMenu menuWithItems:pauseButton, bugSprayButton, nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:2 tag:kHUDMenuTag];
        
        CCLabelTTF *scoreLabelTitle = [CCLabelTTF labelWithString:@"Score:" fontName:@"soupofjustice" fontSize:24];
        scoreLabelTitle.position = CGPointMake(52, 296);
        [self addChild:scoreLabelTitle z:10];
        
        scoreLabel = [[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(100, 25) alignment:UITextAlignmentLeft fontName:@"soupofjustice" fontSize:24] retain];
        scoreLabel.position = CGPointMake(144, 296);
        [self addChild:scoreLabel z:10];
                      
        CCLabelTTF *highscoreLabelTitle = [CCLabelTTF labelWithString:@"Best:" fontName:@"soupofjustice" fontSize:14];
        highscoreLabelTitle.position = CGPointMake(37, 275);
        [self addChild:highscoreLabelTitle z:10];
        
        highscoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", MAX([scene score], [BTStorageManager highscore])] dimensions:CGSizeMake(75, 15) alignment:UITextAlignmentLeft fontName:@"soupofjustice" fontSize:14];

        highscoreLabel.position = CGPointMake(95, 275);
        [self addChild:highscoreLabel z:10];
        
        multiplierLabel = [CCLabelTTF labelWithString:@"x1" fontName:@"soupofjustice" fontSize:32];
        multiplierLabel.position = CGPointMake(373, 299);
        [self addChild:multiplierLabel z:10];
        
        maxMultiplierLabel = [CCLabelTTF labelWithString:@"Max!" fontName:@"soupofjustice" fontSize:24];
        maxMultiplierLabel.position = CGPointMake(373, 299);
        maxMultiplierLabel.visible = NO;
        maxMultiplierLabel.rotation = -10;
        maxMultiplierLabel.opacity = 0.9*255;
        maxMultiplierLabel.color = ccc3(200, 0, 0);
        [self addChild:maxMultiplierLabel z:11];
        
        CCSprite *energyBarBack = [CCSprite spriteWithFile:@"Energybarback.png"];
        energyBarBack.position = ccp(373, 300);
        [self addChild:energyBarBack z:8];
        
        energyBar = [CCProgressTimer progressWithFile:@"Energybar.png"];
        energyBar.position = ccp(373, 300);
        energyBar.type = kCCProgressTimerTypeHorizontalBarLR;
        [energyBar runAction:[CCProgressTo actionWithDuration:0 percent:0]];
        [self addChild:energyBar z:9];
        
        playTimeLabel = [CCLabelTTF labelWithString:@"0:00" fontName:@"soupofjustice" fontSize:24];
        playTimeLabel.position = ccp(40, 20);
        [self addChild:playTimeLabel z:10];
        
        CCLabelTTF *beamWarningLabel = [CCLabelTTF labelWithString:@"Keep fingers on screen\nfor high score!" dimensions:CGSizeMake(480, 50) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:24];
        beamWarningLabel.position = ccp(240, 40);
        beamWarningLabel.color = [NSClassFromString([BTStorageManager currentBackground]) textColor];
        beamWarningLabel.visible = NO;
        [self addChild:beamWarningLabel z:10 tag:kBeamWarningTag];
        
        fliesFriedLabel = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Zaps: %d", [scene fliesFried]] fontName:@"soupofjustice" fontSize:12] retain]; 
        fliesFriedLabel.position = CGPointMake(50, 30);
        [self addChild:fliesFriedLabel];
        
        timeElapsedLabel = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Time: %f", [[scene gameLayer] playTime]] fontName:@"soupofjustice" fontSize:12] retain]; 
        timeElapsedLabel.position = CGPointMake(50, 5);
        [self addChild:timeElapsedLabel];
        
        careerFliesLabel = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Career Zaps: %d", [BTStorageManager numBugsZapped]] fontName:@"soupofjustice" fontSize:12] retain]; 
        careerFliesLabel.position = CGPointMake(200, 5);
        [self addChild:careerFliesLabel];
        
        frogSpeedLabel = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Frog Speed: %f", [[BTConfig sharedConfig] frogMovementRate]] fontName:@"soupofjustice" fontSize:12] retain]; 
        frogSpeedLabel.position = CGPointMake(200, 30);
        [self addChild:frogSpeedLabel];

        
        catchIntervalLabel = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Catch Interval: %f", [[BTConfig sharedConfig] frogCatchInterval]] fontName:@"soupofjustice" fontSize:12] retain]; 
        catchIntervalLabel.position = CGPointMake(400, 5);
        [self addChild:catchIntervalLabel];
        
        metasequenceLabel = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Metasequence: %@", [[[[scene gameLayer] bugManager] currentMetasequence] name]] fontName:@"soupofjustice" fontSize:12] retain];
        metasequenceLabel.position = CGPointMake(400, 30);
        [self addChild:metasequenceLabel];
        
        sequenceLabel = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Sequence: %@", [[[[[scene gameLayer] bugManager] currentMetasequence] currentSequence] name]] fontName:@"soupofjustice" fontSize:12] retain];
        sequenceLabel.position = CGPointMake(400, 55);
        [self addChild:sequenceLabel];

        fliesFriedLabel.visible = NO;
        timeElapsedLabel.visible = NO; 
        careerFliesLabel.visible = NO; 
        frogSpeedLabel.visible = NO; 
        catchIntervalLabel.visible = NO;
        metasequenceLabel.visible = NO;
        sequenceLabel.visible = NO;
    
    }
    
    return self;
}

- (void) update:(ccTime) dt {
    [self getChildByTag:kBeamWarningTag].visible = NO;
    
    if ([scene gameState] == kGameStateReady){

    } else if ([scene gameState] == kGameStateStarted){
        if ([[[scene gameLayer] player] getNumTouches] < 2){
            if (![[scene gameLayer] getChildByTag:kSputterNotificationTag]){
                [self getChildByTag:kBeamWarningTag].visible = YES;
            }
        }
    } 
    
    // Update Score Label
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSString *scoreString = [numberFormatter stringFromNumber:[NSNumber numberWithInt:[scene score]]];
    if ([[scoreLabel string] compare:scoreString] != NSOrderedSame){
        [scoreLabel setString:scoreString];
    }

    NSString *highscoreString = [numberFormatter stringFromNumber:[NSNumber numberWithInt:MAX([scene score], [BTStorageManager highscore])]];
    if ([[highscoreLabel string] compare:highscoreString] != NSOrderedSame){
        [highscoreLabel setString:highscoreString];
    }
    
    // Update Multiplier Label
    NSString *multiplierString = [NSString stringWithFormat:@"x%d", [scene multiplierInt]];
    if ([scene multiplierInt] >= [[BTConfig sharedConfig] playerMultiplierMaximum]){
        maxMultiplierLabel.visible = YES;
    } else {
        maxMultiplierLabel.visible = NO;
    }
    if ([[multiplierLabel string] compare:multiplierString] != NSOrderedSame){
        [multiplierLabel setString:multiplierString];
    }
    
    NSString *timeString = [BTConfig timeFormatted:(int)[[scene gameLayer] playTime]];
    if (![timeString isEqualToString:[playTimeLabel string]]){
        [playTimeLabel setString:timeString];
    }
    
    if ([[BTConfig sharedConfig] debug]){
        [fliesFriedLabel setString:[NSString stringWithFormat:@"Zaps: %d", [scene fliesFried]]];
        [timeElapsedLabel setString:[NSString stringWithFormat:@"Time: %f", [[scene gameLayer] playTime]]];
        [careerFliesLabel setString:[NSString stringWithFormat:@"Career Zaps: %d", [BTStorageManager numBugsZapped]]];
        [frogSpeedLabel setString:[NSString stringWithFormat:@"Frog Speed: %f", [[BTConfig sharedConfig] frogMovementRate]]];
        [catchIntervalLabel setString:[NSString stringWithFormat:@"Catch Interval: %f", [[BTConfig sharedConfig] frogCatchInterval]]];
        
        NSString *metasequenceString = @"";
        NSString *sequenceString = @"";
        
        if ([[[[scene gameLayer] bugManager] introSequence] state] == Started){
            metasequenceString = @"Intro";
            sequenceString = @"Intro";
        } else {
            metasequenceString = [[[[scene gameLayer] bugManager] currentMetasequence] name];
            sequenceString = [[[[[scene gameLayer] bugManager] currentMetasequence] currentSequence] name];
        }
        [metasequenceLabel setString:[NSString stringWithFormat:@"Metasequence: %@", metasequenceString]];
        [sequenceLabel setString:[NSString stringWithFormat:@"Sequence: %@", sequenceString]];
        
        fliesFriedLabel.visible = YES;
        timeElapsedLabel.visible = YES; 
        careerFliesLabel.visible = YES; 
        frogSpeedLabel.visible = YES; 
        catchIntervalLabel.visible = YES;
        metasequenceLabel.visible = YES;
        sequenceLabel.visible = YES;
    } else {
        fliesFriedLabel.visible = NO;
        timeElapsedLabel.visible = NO; 
        careerFliesLabel.visible = NO; 
        frogSpeedLabel.visible = NO; 
        catchIntervalLabel.visible = NO;
        metasequenceLabel.visible = NO;
        sequenceLabel.visible = NO;
    }
}

- (void) dealloc {
    [super dealloc];
}

@end
