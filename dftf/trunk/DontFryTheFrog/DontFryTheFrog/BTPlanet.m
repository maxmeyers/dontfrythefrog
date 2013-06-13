//
//  BTPlanet.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTPlanet.h"
#import "BTIncludes.h"

@implementation BTPlanet

- (void) randomizeAesthetics {
    self.scale = RANDBT(50, 100)/100.0;
        
    if (self.sprite && [[self children] containsObject:self.sprite]){
        [self removeChild:self.sprite cleanup:YES];
    }
    
    self.sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"planet%d.png", RANDBT(1, 4)]];
    [self addChild:self.sprite];
}

@end
