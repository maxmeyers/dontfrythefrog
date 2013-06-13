//
//  BTHopshopLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

#define kZekeWelcomeTag 1
#define kZekeSoldTag 2
#define kBeamButtonTag 3
#define kBGButtonTag 4
#define kFPButtonTag 5
#define kFlyButtonTag 6
#define kToolButtonTag 7
#define kHopshopMenuTag 8

@class CCLabelTTF, BTHopshopDetails, BTHopshopScene;

@interface BTHopshopLayer : CCLayer {
    CCLabelTTF *flyPenniesLabel;
    BTHopshopDetails *hopshopDetails;

    BTHopshopScene *hopshopScene_;
}

@property (nonatomic, assign) BTHopshopDetails *hopshopDetails;
@property (nonatomic, assign) BTHopshopScene *hopshopScene;

// When a layer is added on top of me.
- (void) lostProminence;

// When there are no longer any layers on top of me.
- (void) returnToProminence;

@end
