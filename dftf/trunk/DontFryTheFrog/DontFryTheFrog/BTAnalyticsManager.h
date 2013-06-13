//
//  BTAnalyticsManager.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCArray;

@interface BTAnalyticsManager : NSObject

+ (void) reportGameStartWithSceneChildren:(CCArray *) sceneChildren;

@end
