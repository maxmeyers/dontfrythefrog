//
//  BTPopup.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/27/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTPopup.h"
#import "BTIncludes.h"
#import "CCTouchDispatcher.h"

@implementation BTPopup

- (id) init {
    self = [super init];
    if (self){
        dismissable = NO;
    }
    return self;
}

- (void) showPopup {
    [self registerWithTouchDispatcher];
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] gameScene] softPause];
    
    CCSprite *playButton = [CCSprite spriteWithSpriteFrameName:@"play-load-1.png"];
    playButton.position = ccp(433, 47); 
    [self addChild:playButton z:3];
    CCAnimation *loadAnimation = [BTStorageManager animationWithString:@"BTPlayButton" atInterval:2.0/8 Reversed:NO];
    [playButton runAction:[CCAnimate actionWithAnimation:loadAnimation restoreOriginalFrame:NO]];
}

- (void) enableDismiss {
    dismissable = YES;
}

- (bool) dismissPopup {
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] gameScene] softResume];

    [self removeFromParentAndCleanup:YES];
    return YES;
    
    return NO;
}

-(void) registerWithTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:3 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if (dismissable){
        [self dismissPopup];
    }
    return YES;
}

- (void) dealloc {
    [super dealloc];
}


@end

@implementation BTAnimatedPopup

- (id) initWithAnimation:(CCAnimation *) anim {    
    if ((self = [super init])){
        animation = [anim retain];
        image = [CCSprite spriteWithSpriteFrame:[[anim frames] objectAtIndex:0]];
        image.position = CGPointMake(240, 160);
        [self addChild:image z:2];
    }
    
    return self;
}

- (void) showPopup {
    [super showPopup];
    
    CCAnimate *repeatedAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames:[animation frames] delay:[animation delay]] restoreOriginalFrame:NO]];

    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.0], [CCCallFunc actionWithTarget:self selector:@selector(enableDismiss)], nil]];
    [image runAction:repeatedAnimate];
}

- (bool) dismissPopup {
//    CCNode *tempParent = [self parent];
    if ([super dismissPopup]){
        
        // If this was a tutorial explaining the last death
//        if ([tempParent isMemberOfClass:[BTGameScene class]] && [[[[(BTGameLayer *)tempParent scene] gameUILayer] lifeCounter] lives] == 0){
//            [(BTGameLayer *)tempParent stopWithState:kGameStateGameOver];
//        }
        
        return YES;
    }
    return NO;
}

- (void) pauseSchedulerAndActions {
    [super pauseSchedulerAndActions];
    [image pauseSchedulerAndActions];
}

- (void) resumeSchedulerAndActions {
    [super resumeSchedulerAndActions];
    [image resumeSchedulerAndActions];
}

- (void) dealloc {
    [animation release];
    [super dealloc];
}

@end

@implementation BTAnimatedPopupClean

- (id) initWithAnimation:(CCAnimation *)anim {
    if ((self = [super initWithAnimation:anim])){

    }
    
    return self;
}

- (void) showPopup {
    animationAction = [[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]] retain];
    [image runAction:animationAction];
}

- (bool) dismissPopup {
    if (animationAction != nil){
        [image stopAction:animationAction];
        [animationAction release];
        animationAction = nil;
        [self removeFromParentAndCleanup:YES];
        return YES;
    }
    return NO;
}

- (void) dealloc {
    [animationAction release];
    [super dealloc];
}

@end






