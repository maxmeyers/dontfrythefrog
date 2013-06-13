//
//  BTLoadingScene.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTLoadingScene.h"

@implementation BTLoadingScene

@synthesize loadingBar;

- (id) init {
    if ((self = [super init])){
        if ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"]){
//            self.scale = 1024.0/480.0;
//            self.position = ccp(579, 475);
        }
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Loading..." fontName:@"soupofjustice" fontSize:72];
        label.position = CGPointMake(240, 160);
        [self addChild:label];
    }
    return self;
}

- (void) onEnter {
    [super onEnter];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"BTHopshop.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"BTHopshop-Flies.plist"];
    
//    [loadingBar runAction:[CCProgressTo actionWithDuration:0 percent:5]];
}

- (void) update: (ccTime) dt {

}

@end
