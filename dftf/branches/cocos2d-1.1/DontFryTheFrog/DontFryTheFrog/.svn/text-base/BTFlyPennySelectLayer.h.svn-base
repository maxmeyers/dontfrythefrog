//
//  BTBackgroundSelectLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

typedef enum {
    kNoInternetConnection,
    kProductsNotLoaded,
    kProductsLoaded,
    kWaitingToPurchase,
    kTransactionProcessing
} tFlyPennySelectState;

@class BTHopshopLayer;

@interface BTFlyPennySelectLayer : CCLayer {
    BTHopshopLayer *hopshopLayer_;
    tFlyPennySelectState state;
}

@property tFlyPennySelectState state;

- (id) initWithHopshopLayer:(BTHopshopLayer *)hopshop;
- (void) displayJar:(int) jarLevel;

- (void) lostProminence;
- (void) returnToProminenceWithSuccess:(bool) success;

@end
