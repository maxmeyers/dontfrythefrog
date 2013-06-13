//
//  BTCreditsScene.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTCreditsScene.h"
#import "BTIncludes.h"

#define kLeftArrowTag 2
#define kRightArrowTag 3

@implementation BTCreditsScene

- (void) onEnter {
    [super onEnter];
    // TODO: REmove this
    [BTStorageManager setBackground:@"BTDesertBackgroundLayer" Unlocked:YES];
    [BTStorageManager setBackground:@"BTSpaceBackgroundLayer" Unlocked:YES];
//    [BTStorageManager unlockBug:[BTSickBug class]];
}

- (id) init { 
    self = [super init];
    if (self){

        pageIndex = 0;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 1; i <= 3; i++){
            CCSprite *page = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"Credits-%d.png", i]];
            page.position = ccp(240, 160);
            page.visible = NO;
            [self addChild:page z:0];
            [tempArray addObject:page];
        }
        
        pages = [[NSArray arrayWithArray:tempArray] retain];
        
        CCMenu *menu = [CCMenu menuWithItems:nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:1];
        
        CCLabelTTF *leftArrow = [CCLabelTTF labelWithString:@"<" fontName:@"AmericanTypewriter-Bold" fontSize:60];
        leftArrow.color = ccBLACK;
        leftArrowButton = [CCMenuItemLabel itemWithLabel:leftArrow block:^(id sender){
            pageIndex = MAX(0, pageIndex-1);
            [self showPageAtIndex:pageIndex];
        }];
        leftArrowButton.position = ccp(200, 30);
        [menu addChild:leftArrowButton z:0  tag:kLeftArrowTag];        
        
        CCLabelTTF *rightArrow = [CCLabelTTF labelWithString:@">" fontName:@"AmericanTypewriter-Bold" fontSize:60];
        rightArrow.color = ccBLACK;
        rightArrowButton = [CCMenuItemLabel itemWithLabel:rightArrow block:^(id sender){
            pageIndex = MIN(2, pageIndex+1);
            [self showPageAtIndex:pageIndex];
        }];
        rightArrowButton.position = ccp(350, 30);
        [menu addChild:rightArrowButton z:0 tag:kRightArrowTag];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
            [[CCDirector sharedDirector] popScene];
        }];
        backButton.position = ccp(50, 30);
        [menu addChild:backButton];
        
        [self showPageAtIndex:pageIndex];
    }
    return self;    
}

- (void) showPageAtIndex:(int) index {
    for (int i = 0; i < [pages count]; i++){ 
        CCSprite *page = [pages objectAtIndex:i];
        if (i == index){
            page.visible = YES;
        } else {
            page.visible = NO;
        }
    }
    
    if (index == 0){
        leftArrowButton.opacity = 0;
    } else {
        leftArrowButton.opacity = 255;
    }
    
    if (index == [pages count] - 1){
        rightArrowButton.opacity = 0;
    } else {
        rightArrowButton.opacity = 255;
    }
}

- (void) dealloc {
    [pages release];
    [super dealloc];
}

@end
