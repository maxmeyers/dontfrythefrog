//
//  BTBugUpgradeLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

@class BTHopshopLayer;

@interface BTBugUpgradeSelectLayer : CCLayer {
    BTHopshopLayer *hopshopLayer_;
}

@property (nonatomic, assign) BTHopshopLayer *hopshopLayer;

- (id) initWithHopshopLayer:(BTHopshopLayer *)hopshop;

- (void) lostProminence;
- (void) returnToProminence;

@end

@interface BTBugUpgradeSublayer : CCLayer {
    BTBugUpgradeSelectLayer *upgradeSelectLayer_;
    Class bugClass_;
}

- (id) initWithBugUpgradeLayer:(BTBugUpgradeSelectLayer *) upgradeSelectLayer Bug:(Class) bugClass;
- (void) setDisplayedLevel:(int) level;

@end