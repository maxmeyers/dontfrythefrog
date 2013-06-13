//
//  BTBackgroundLayer.m
//  
//
//  Created by Max Meyers on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTBackgroundLayer.h"
#import "BTIncludes.h"

@implementation BTBackgroundLayer

- (id) init {
    self = [super init];
    if (self){
        [self scheduleUpdate];
    }
    return self;
}

+ (ccColor3B) textColor {
    return ccWHITE;
}

+ (NSString *) name {
    return @"Background";
}

+ (NSString *) shortName {
    return @"BG";
}

- (void) update:(ccTime) dt {
    
}

- (void) killObject:(CCNode *) node {
    if ([[self children] containsObject:node]){
        if ([[self parent] isMemberOfClass:[BTGameScene class]]){
            BTGameScene *scene = (BTGameScene *)[self parent];
            [[scene gameLayer] showPointsFadeawayString:@"50" position:node.position];
            [scene addPoints:50];
        }
        
        CCAnimation *burstAnimation = [BTStorageManager animationWithString:@"BTGenericCloud" atInterval:0.05f Reversed:NO];
        
        CCSprite *sprite = [CCSprite spriteWithSpriteFrame:[[burstAnimation frames] objectAtIndex:0]];
        sprite.position = node.position;
        [self addChild:sprite z:node.zOrder];
        
        [self removeChild:node cleanup:YES];
        
        [sprite runAction:[CCSequence actions:[CCAnimate actionWithAnimation:burstAnimation restoreOriginalFrame:NO], [CCCallBlock actionWithBlock:^(void){
            [sprite removeFromParentAndCleanup:YES];
        }], nil]];
    }
}

- (void) pauseSchedulerAndActions { 
    [super pauseSchedulerAndActions];
    for (CCNode *node in self.children){
        [node pauseSchedulerAndActions];
    }
}

- (void) resumeSchedulerAndActions {
    [super resumeSchedulerAndActions];
    
    for (CCNode *node in self.children){
        [node resumeSchedulerAndActions];
    }
}

@end
