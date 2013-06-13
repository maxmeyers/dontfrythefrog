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

- (id) initWithHopshopLayer:(BTHopshopLayer *)hopshop;

- (void) lostProminence;
- (void) returnToProminence;

@end
