//
//  BTConfigLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@class BTConfigScene;


@interface BTConfigLayer : CCLayerColor <UIAlertViewDelegate, UITextFieldDelegate> {
    BTConfigScene *configScene;
}

@property (nonatomic, assign) BTConfigScene *configScene;

- (id) initWithConfigScene: (BTConfigScene *) scene;
- (void) buttonPress:(id) sender;
- (void) unlockBugs;

@end
