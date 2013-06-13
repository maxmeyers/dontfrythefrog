//
//  BTPopup.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/27/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "cocos2d.h"

#define kBTPopupLayer 15

@class BTPopup;

@protocol BTPopupable <NSObject>

+ (BTPopup *) popup;

@end

@interface BTPopup : CCLayer {
    bool dismissable;
}

- (void) showPopup;
- (void) enableDismiss;
- (bool) dismissPopup;

@end

@interface BTAnimatedPopup : BTPopup {
    CCSprite *image;
    CCAnimation *animation;
}

- (id) initWithAnimation:(CCAnimation *) anim;

@end

@interface BTAnimatedPopupClean : BTAnimatedPopup {
    CCAnimate *animationAction;
}

@end
