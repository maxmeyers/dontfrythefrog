//
//  BTMovableBackgroundObject.m
//  
//
//  Created by Max Meyers on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTMovableBackgroundObject.h"
#import "BTIncludes.h"

@implementation BTMovableBackgroundObject

@synthesize sprite = _sprite, speed = _speed, verticalPosition = _verticalPosition, pauseTime = _pauseTime;
@synthesize body = _body, shape = _shape;

- (id) initWithPosition:(CGPoint) point FileName:(NSString *)filename {
    self = [super init];
    if (self){
        if (filename){
            self.sprite = [CCSprite spriteWithSpriteFrameName:filename];
            [self addChild:self.sprite];
        }
        
        [self randomizeAesthetics];
        self.verticalPosition = point.y;
        self.pauseTime = 0;
        
        initialPoint = point;
        finalPoint = ccp(480+[self.sprite textureRect].size.width/2, initialPoint.y); 
        self.position = initialPoint;
    }
    return self;
}
- (void) enableDestructionWithRadius:(int) r {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([appDelegate mode] == kModeGame && [appDelegate gameScene] != nil){
        BTChipmunkManager *chipmunkManager = [[[appDelegate gameScene] gameLayer] chipmunkManager];
        
        self.body = cpBodyNew(INFINITY, INFINITY);
        self.body->p.x = self.position.x; self.body->p.y = self.position.y;
        
        self.shape = cpCircleShapeNew( self.body, r, cpv(0,0));
        self.shape->collision_type = kCollisionTypeAsteroid;
        self.shape->data = self;
        cpSpaceAddShape( [chipmunkManager space], self.shape );      
        
        [self scheduleUpdate];
    }
}

- (void) drift:(BOOL) fromOffside {
    if (fromOffside){
        [self randomize];
    }
    int distance = finalPoint.x - initialPoint.x;
    [self runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0 position:initialPoint], [CCMoveTo actionWithDuration:distance/self.speed position:finalPoint], [CCDelayTime actionWithDuration:self.pauseTime], [CCCallBlock actionWithBlock:^(void) {
        [self drift:YES];  
    }], nil]];
}

- (void) randomize {
    [self randomizeAesthetics];
    initialPoint = ccp(-floor([self.sprite textureRect].size.width/2), self.verticalPosition);
    finalPoint = ccp(480+[self.sprite textureRect].size.width, initialPoint.y);
}

- (void) randomizeAesthetics {
    
}

@end
