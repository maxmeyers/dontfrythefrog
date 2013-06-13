//
//  BTLilypad.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"

typedef enum {
    kSmall,
    kLarge,
} tLilyPadSize;

#import "BTMovableBackgroundObject.h"

@interface BTLilypad : BTMovableBackgroundObject

@property tLilyPadSize  size;

- (id) initWithSize:(tLilyPadSize) size Position:(CGPoint) position;

@end
