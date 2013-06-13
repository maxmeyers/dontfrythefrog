//
//  BTMovableBackgroundObject.h
//  
//
//  Created by Max Meyers on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "chipmunk.h"

@class CCSprite;

@interface BTMovableBackgroundObject : CCNode {
    CGPoint     initialPoint;
    CGPoint     finalPoint;
}

@property (nonatomic, assign) CCSprite *sprite;
@property float         speed;
@property int           verticalPosition;
@property int           pauseTime;

// Optional
@property (nonatomic, assign) cpBody *body;
@property (nonatomic, assign) cpShape *shape;

- (id) initWithPosition:(CGPoint) point FileName:(NSString *)filename;
- (void) enableDestructionWithRadius:(int) r;
- (void) drift:(BOOL) fromOffside;
- (void) randomize;
- (void) randomizeAesthetics;

@end
