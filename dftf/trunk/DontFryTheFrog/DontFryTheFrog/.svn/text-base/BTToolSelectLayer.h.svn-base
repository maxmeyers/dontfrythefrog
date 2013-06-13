//
//  BTBackgroundSelectLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

@class BTHopshopLayer;

@interface BTToolSelectLayer : CCLayer {
    BTHopshopLayer *hopshopLayer_;
}

@property (nonatomic, assign) BTHopshopLayer *hopshopLayer;

- (id) initWithHopshopLayer:(BTHopshopLayer *)hopshop;

- (void) lostProminence;
- (void) returnToProminence;

@end

@interface BTToolPurchaseLayer : CCLayer {
    BTToolSelectLayer *toolSelectLayer_;
    Class toolClass_;
}

- (id) initWithToolSelectLayer:(BTToolSelectLayer *) toolSelectLayer Tool:(Class) toolClass;
- (void) setDisplayedLevel:(int) level;

- (void) lostProminence;
- (void) returnToProminenceWithSuccess:(bool) success;

@end