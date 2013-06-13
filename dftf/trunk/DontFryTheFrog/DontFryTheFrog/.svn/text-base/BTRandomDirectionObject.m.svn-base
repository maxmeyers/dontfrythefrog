//
//  BTRandomDirectionObject.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTRandomDirectionObject.h"
#import "BTIncludes.h"

@implementation BTRandomDirectionObject

- (id) initWithPosition:(CGPoint) point FileName:(NSString *)filename {
    self = [super initWithPosition:point FileName:filename];
    if (self){
        self.verticalPosition = 0;
        
        [self randomizeAesthetics];
        self.position = initialPoint;
    }
    return self;
}

- (void) drift:(BOOL) fromOffside {
    int distance = DISTANCE(initialPoint, finalPoint);
    [self runAction:[CCSequence actions:[CCMoveTo actionWithDuration:distance/self.speed position:finalPoint], [CCCallBlock actionWithBlock:^(void) {
        [self removeFromParentAndCleanup:YES];
    }], nil]];
}

- (void) randomize {
    
    [self randomizeAesthetics];
}

- (void) randomizeAesthetics {
    
    if (arc4random() % 2 == 0){
        // From top or bottom
        initialPoint.x = RANDBT(-20, 500);
        finalPoint.x = RANDBT(-20, 500);
        if (arc4random() % 2 == 0){
            // From top
            initialPoint.y = 360;
            finalPoint.y = -40;
        } else {
            // From bottom
            initialPoint.y = -40;
            finalPoint.y = 360;
        }
    } else {
        // From left or right
        initialPoint.y = RANDBT(-20, 340);
        finalPoint.y = RANDBT(-20, 340);
        if (arc4random() % 2 == 0){
            // From right
            initialPoint.x = 520;
            finalPoint.x = -40;
        } else {
            // From left
            initialPoint.x = -40;
            finalPoint.x = 520;
        }
    }
}

@end
