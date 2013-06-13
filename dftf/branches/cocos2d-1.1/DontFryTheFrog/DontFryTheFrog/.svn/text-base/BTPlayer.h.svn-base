//
//  BTPlayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTObject.h"

#define kSputterSequenceTag 1
#define kSputterNotificationTag 54381

@interface BTPlayer : BTObject {
//    NSMutableArray *touches;
    UITouch *touch0;
    UITouch *touch1;
    
    bool sputtering_;
    bool sputtered_;
    ccTime timeSinceSputtered_;
    int touchesRemoved_;
}

//@property (nonatomic, retain) NSMutableArray *touches;
@property (nonatomic, assign) UITouch *touch0;
@property (nonatomic, assign) UITouch *touch1;

- (void) sputter;
- (void) unSputter;

- (bool) beamActive;
-(void) addTouch:(UITouch *) touch;
-(void) removeTouch:(UITouch *) touch;
-(int) getNumTouches;
-(void) decay;

@end
