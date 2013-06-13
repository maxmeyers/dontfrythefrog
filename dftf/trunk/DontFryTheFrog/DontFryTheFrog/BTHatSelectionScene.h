//
//  BTHatSelectionScene.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCScene.h"

@class CCMenu, CCSprite, CCLabelTTF;

#define kOriginMenuSelect 1
#define kOriginHopshop 2

@interface BTHatSelectionScene : CCScene {
    int hatIndex;
    int currentCost;
    NSString *currentName;
    
    CCLabelTTF *flyPenniesLabel;
}

@property int origin;
@property (nonatomic, retain) NSArray *hats;
@property (nonatomic, retain) NSDictionary *hatSprites;
@property (nonatomic, assign) CCMenu *menu;
@property (nonatomic, assign) CCSprite *currentHat;
@property (nonatomic, retain) NSArray *centerButtons;

+ (void) showWithOrigin:(int) origin;
- (void) showHat:(int) index;

@end
