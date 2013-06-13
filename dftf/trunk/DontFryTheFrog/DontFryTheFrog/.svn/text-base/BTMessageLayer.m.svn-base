//
//  BTMessageLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTMessageLayer.h"
#import "BTIncludes.h"
#import "CCTouchDispatcher.h"

#define kNewbieMessageBGTag 4
#define kNewbieMessageTag 5

@implementation BTMessageLayer

- (id) initWithMessage:(NSString *) string {
    self = [super init];
    
    if (self){
        loaded = NO;
        self.isTouchEnabled = YES;
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        CCLayerColor *back = [CCLayerColor layerWithColor:ccc4(38, 38, 38, 225) width:443 height:285];
        back.position = ccp(18, 17);
        
        CCLabelTTF *message = [CCLabelTTF labelWithString:string dimensions:CGSizeMake(350, 160) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:32];
        message.position = ccp(240, 160);
        
        [self addChild:back z:3 tag:kNewbieMessageBGTag];
        [self addChild:message z:4 tag:kNewbieMessageTag];
        
//        CCDelayTime *delay = [CCDelayTime actionWithDuration:0.5f];
//        CCCallBlock *loadButton = [CCCallBlock actionWithBlock:^(void) {
//            CCSprite *playButton = [CCSprite spriteWithSpriteFrameName:@"play-load-1.png"];
//            playButton.position = ccp(433, 47); 
//            [self addChild:playButton z:3];
//            CCAnimation *loadAnimation = [BTStorageManager animationWithString:@"BTPlayButton" atInterval:2.0/8 Reversed:NO];
//            [playButton runAction:[CCSequence actions:[CCAnimate actionWithAnimation:loadAnimation restoreOriginalFrame:NO], [CCCallBlock actionWithBlock:^(void) {
//                loaded = YES;
//            }], nil]];
//            
//        }];
//        [self runAction:[CCSequence actionOne:delay two:loadButton]];
        
        CCMenuItemSprite *nextButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"next-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"next-pressed.png"] block:^(id sender) {
            if ([[super parent] respondsToSelector:@selector(awardFlyPenniesUntilZero)]){
                [[super parent] performSelector:@selector(awardFlyPenniesUntilZero)];
            }
            [self removeFromParentAndCleanup:YES];
        }];
        nextButton.position = ccp(433, 47);
        CCMenu *menu = [CCMenu menuWithItems:nextButton, nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:4];
    }
    
    return self;
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

@end
