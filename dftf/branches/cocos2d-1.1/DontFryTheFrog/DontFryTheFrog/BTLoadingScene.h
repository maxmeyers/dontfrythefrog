//
//  BTLoadingScene.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface BTLoadingScene : CCScene  {
    CCProgressTimer *loadingBar;
}

@property (nonatomic, assign) CCProgressTimer *loadingBar;

@end
