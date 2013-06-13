//
//  BTHighScoreLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTHighScoreLayer.h"
#import "BTIncludes.h"

@implementation BTHighScoreLayer

- (id) init {
    if ((self = [super init])){        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"High Scores" fontName:@"soupofjustice" fontSize:32];
        title.position = CGPointMake(240, 240);
        [self addChild:title];
        
        NSArray *highscores = [BTStorageManager highscoreList];
        NSString *scoreString = @"";
        for (int i = 0; i < 5; i++){
            int score = 0;
            if ([highscores count] > i){
                score = [(NSNumber *)[highscores objectAtIndex:i] intValue];
            }
            scoreString = [scoreString stringByAppendingString:[NSString stringWithFormat:@"\n%d. %d", i+1, score]];
        }
        CCLabelTTF *scores = [CCLabelTTF labelWithString:scoreString dimensions:CGSizeMake(100, 173) alignment:UITextAlignmentLeft lineBreakMode:UILineBreakModeCharacterWrap fontName:@"soupofjustice" fontSize:22];
        scores.position = CGPointMake(240, 140);
        scores.color = ccc3(255, 255, 255);
        [self addChild:scores];

        CCMenuItemLabel *resetButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Reset" fontName:@"soupofjustice" fontSize:32] target:self selector:@selector(resetButtonPressed)];
        CCMenuItemLabel *okButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"OK" fontName:@"soupofjustice" fontSize:32] target:self selector:@selector(okButtonPressed)];
        CCMenu *menu = [CCMenu menuWithItems:resetButton, okButton, nil];
        [menu alignItemsHorizontallyWithPadding:50];
        menu.position = CGPointMake(240, 35);
        [self addChild:menu];
        
//        BTGameScene *scene = [[[BTGameScene alloc] init] autorelease];
//        scene.score = 1680;
//        scene.fliesFried = 50;
//        scene.maxMultiplier = 2;
//        [scene unscheduleUpdate];
//        
//        BTResultsLayer *resultsLayer = [[[BTResultsLayer alloc] initWithScore:0 AllTimeScore:12345 FliesFried:12345 AllTimeFliesFried:0 FlyPennies:0 Multiplier:25 AllTimeMultiplier:0 Bank:0] autorelease];
//        [scene addChild:resultsLayer z:1]; 
//        [self addChild:scene];
    }
    return self;
}

- (void) okButtonPressed {
    [[CCDirector sharedDirector] popScene];
}

- (void) resetButtonPressed {
    [BTStorageManager resetHighscores];
    [self okButtonPressed];
}

@end
