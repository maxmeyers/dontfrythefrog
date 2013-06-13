//
//  BTNewLog.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTNewsLog.h"
#import "BTIncludes.h"

#define kMessageTag 1

@implementation BTNewsLog

+ (BTNewsLog *) sharedNewsLog {
    static BTNewsLog *sharedNewsLog;
    @synchronized(self)
    {
        if (!sharedNewsLog) {
            sharedNewsLog = [[BTNewsLog alloc] init];
        }
        return sharedNewsLog;
    }
}

- (id) init {
    self = [super init];
    if (self){
        onScreen_ = NO;
        self.position = kNewsLogOffscreen;
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"news-log.png"];
        [self addChild:background z:0];
        
        [self refreshNews];
        
        CCMenuItemLabel *backButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Back" fontName:@"soupofjustice" fontSize:32] block:^(id sender){
            [self disappear];
        }];
        backButton.color = ccBLACK;
        backButton.position = ccp(50, -110);
//        backButton.position = ccp(-38, 0);
        
//        CCMenuItem *backZone = [CCMenuItem itemWithTarget:self selector:@selector(disappear)];
//        backZone.position = ccp(-38, -160);
//        backZone.contentSize = CGSizeMake(171, 320);
        
        CCMenu *menu = [CCMenu menuWithItems:backButton, nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:1];
    }
    return self;
}

- (void) refreshNews {
    if ([self getChildByTag:kMessageTag]){
        [self removeChildByTag:kMessageTag cleanup:YES];
    }
    
    NSString *newsString = [BTStorageManager news];
    if ([newsString isEqualToString:@""]){
        newsString = @"Thanks for downloading our game!\n\nStop by BlacktorchGames.com to see what else we are working on.";
    }
    CCLabelTTF *message = [CCLabelTTF labelWithString:newsString dimensions:CGSizeMake(115, 210) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"Marker Felt" fontSize:14];
    message.position = ccp(67, 0);
    message.color = ccBLACK;
    [self addChild:message z:2 tag:kMessageTag];
}

- (void) toggle {
    if (onScreen_){
        [self disappear];
    } else {
        [self appear];
    }
}

- (void) appear {
    if (!onScreen_){
        [self runAction:[CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.5 position:kNewsLogOnscreen] rate:5]];
        onScreen_ = YES; 
        if ([[self parent] getChildByTag:kMainMenuTag]){
            [(CCMenu *)[[self parent] getChildByTag:kMainMenuTag] setIsTouchEnabled:NO];
        }
    }
}

- (void) disappear {
    if (onScreen_) {
        [self runAction:[CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.2 position:kNewsLogOffscreen] rate:3]];
        onScreen_ = NO;
        if ([[self parent] getChildByTag:kMainMenuTag]){
            [(CCMenu *)[[self parent] getChildByTag:kMainMenuTag] setIsTouchEnabled:YES];
        }
    }
}

@end
