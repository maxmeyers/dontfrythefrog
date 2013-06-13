//
//  BTBackgroundSubLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/20/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "cocos2d.h"

@interface BTBackgroundSubLayer : CCNode
{
    @private CCSprite *layer1;
    @private CCSprite *layer2;
    float width;
    ccTime duration;
    CCSprite *currentLayer;
}

@property (nonatomic, assign) CCSprite *layer1;
@property (nonatomic, assign) CCSprite *layer2;

- (id) initWithSpriteFrameName:(NSString *) string Width:(float) w Duration:(ccTime) dur;
- (void) switchLayers;

@end
