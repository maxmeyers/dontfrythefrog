//
//  BTBackgroundSelectLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

typedef enum {
    kLeft,
    kRight
} tDirection;

@class BTHopshopLayer, CCMenu;

@interface BTBackgroundSelectLayer : CCLayer {
    BTHopshopLayer      *hopshopLayer_;
    int                 backgroundIndex;
}

@property (nonatomic, retain) NSArray *backgroundClasses;
@property (nonatomic, retain) NSArray *backgroundThumbnails;

@property (nonatomic, assign) CCMenu *menu;

- (id) initWithHopshopLayer:(BTHopshopLayer *)hopshop;
- (void) previous;
- (void) next;
- (void) showBackground:(int) index;
- (int) indexForDirection:(tDirection) direction currentIndex:(int) index;

@end
