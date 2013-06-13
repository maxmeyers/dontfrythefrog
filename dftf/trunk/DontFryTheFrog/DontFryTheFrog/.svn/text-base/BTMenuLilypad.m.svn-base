//
//  BTMenuLilypad.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTMenuLilypad.h"
#import "BTIncludes.h"

@implementation BTMenuLilypad



- (id) initWithPressed:(bool) pressed {
    self = [self initWithPressed:pressed LilyPadSpriteName:@"generic-lilypad.png"];
    if (self){
        
    }
    return self;
}

- (id) initWithPressed:(bool)pressed LilyPadSpriteName:(NSString *) spriteName {
    self = [super init];
    if (self){
        if (pressed){
            CCAnimate *ripplesAnimate = [CCAnimate actionWithAnimation:[BTStorageManager animationWithString:@"BTRipples" atInterval:0.2 Reversed:NO] restoreOriginalFrame:NO];
            CCSprite *ripples = [CCSprite spriteWithSpriteFrameName:@"ripple-1.png"];
            ripples.isRelativeAnchorPoint= NO;
            
            // I know, I know...actually, I don't.
            ripples.position = ccp(-36, -40);
            if ([spriteName isEqualToString:@"start-lilypad.png"]){
                ripples.position = ccp(-30, -25);
            }
            [self addChild:ripples z:0];
            [ripples runAction:[CCRepeatForever actionWithAction:ripplesAnimate]];
        }
        
        CCSprite *lilyPad = [CCSprite spriteWithSpriteFrameName:spriteName];
        lilyPad.isRelativeAnchorPoint = NO;
        [self addChild:lilyPad z:1];
        self.contentSize = lilyPad.contentSize;
    }
    return self;
}

-(void) setColor:(ccColor3B)color {
    
}


-(ccColor3B) color {
    return ccWHITE;
}

-(GLubyte) opacity {
    return 255;
}

-(void) setOpacity: (GLubyte) opacity {
    
}

@end
