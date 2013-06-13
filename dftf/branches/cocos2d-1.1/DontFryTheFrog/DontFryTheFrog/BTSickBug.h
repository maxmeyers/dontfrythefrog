//
//  BTRedfly.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "BTSpecialBug.h"

@interface BTSickBug : BTBadBug {
    
}

- (id) initFlyWithAnimation:(CCAnimation *)animation GameLayer:(BTGameLayer *) layer;

@end
