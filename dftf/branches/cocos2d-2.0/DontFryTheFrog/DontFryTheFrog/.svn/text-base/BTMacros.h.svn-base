//
//  BTMacros.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define RANDBT(x,y) ((arc4random() % (y-x)) + x)


static float ROTATION_FOR_TWO_POINTS(CGPoint pivot, CGPoint aux) {
    float opposite = abs(aux.x - pivot.x);
    float adjacent = abs(aux.y - pivot.y);
    
    float theta = CC_RADIANS_TO_DEGREES( atanf(opposite / adjacent) );
    
    if (aux.y < pivot.y && aux.x > pivot.x){
        theta = 180 - theta;
    }
    
    if (aux.y < pivot.y && aux.x < pivot.x) {
        theta += 180;
    }
    
    if (aux.y > pivot.y && aux.x < pivot.x) {
        theta = 360 - theta;
    }
    
    // This code is already unreadable, so here goes some more.
    if ((aux.y == pivot.y && aux.x < pivot.x) || (aux.y < pivot.y && aux.x == pivot.x)){
        theta += 180;
    }
    
    return theta;
}

/* Returns an offset, not an absolute point */
static CGPoint OFFSET_FOR_ROTATION_AND_DISTANCE(int theta, int distance){
    
    if (theta < 0){
        theta += 360;
    }
    
    int xMultiplier = 1;
    int yMultiplier = 1;
    
    if (theta >= 89 && theta < 180){
        theta = 180 - theta;
        yMultiplier = -1;
    }
    
    if (theta >= 180 && theta < 270){
        theta = theta - 180;
        xMultiplier = -1;
        yMultiplier = -1;
    }
    
    if (theta >= 270 && theta < 360){
        theta = 360 - theta;
        xMultiplier = -1;
    }

    float thetaInRadians = CC_DEGREES_TO_RADIANS(theta);
    float x = sin(thetaInRadians) * distance * xMultiplier;
    float y = cos(thetaInRadians) * distance * yMultiplier;
    
    return CGPointMake(x,y);
}

static CGPoint MIDPOINT(CGPoint a, CGPoint b){
    return CGPointMake((a.x+b.x)/2, (a.y+b.y)/2);
}

static float DISTANCE(CGPoint bottom, CGPoint top){
    float opposite = abs(top.y - bottom.y);
    float adjacent = abs(top.x - bottom.x);
    return sqrtf(opposite * opposite + adjacent * adjacent); 
}

//      QUADRANT MAP
//          4  |  1
//         ----------
//          3  |  2

static unsigned int QUADRANT_FOR_POINT(CGPoint point){
    CGSize size = CGSizeMake(480, 320);
    CGPoint newPoint = CGPointMake(point.x - size.width/2, 
                                   point.y - size.height/2); // 0, 0 now in the middle of the screen
    if (newPoint.x > 0){
        if (newPoint.y > 0){
            return 1;
        } else {
            return 2;
        }
    } else {
        if (newPoint.y > 0){
            return 4;
        } else {
            return 3;
        }
    }
    
    return 0;
}
//
// from: http://stackoverflow.com/questions/791232/canonical-way-to-randomize-an-nsarray-in-objective-c
//
@interface NSMutableArray (ArchUtils_Shuffle)
- (void)shuffle;
@end

// Chooses a random integer below n without bias.
// Computes m, a power of two slightly above n, and takes random() modulo m,
// then throws away the random number if it's between n and m.
// (More naive techniques, like taking random() modulo n, introduce a bias 
// towards smaller numbers in the range.)
static NSUInteger random_below(NSUInteger n) {
    NSUInteger m = 1;
    
    // Compute smallest power of two greater than n.
    // There's probably a faster solution than this loop, but bit-twiddling
    // isn't my specialty.
    do {
        m <<= 1;
    } while(m < n);
    
    NSUInteger ret;
    
    do {
        ret = random() % m;
    } while(ret >= n);
    
    return ret;
}

@implementation NSMutableArray (ArchUtils_Shuffle)

- (void)shuffle {
    // http://en.wikipedia.org/wiki/Knuth_shuffle
    srand(time(NULL));
    for(NSUInteger i = [self count]; i > 1; i--) {
        NSUInteger j = random_below(i);
        [self exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
}

@end