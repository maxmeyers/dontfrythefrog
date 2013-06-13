//
//  BTAnalyticsManager.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTAnalyticsManager.h"
#import "BTIncludes.h"

@implementation BTAnalyticsManager

+ (void) reportGameStartWithSceneChildren:(CCArray *) sceneChildren {
    NSString *toolString = @"";
    for (CCNode *child in sceneChildren){
        if ([child isKindOfClass:[BTTool class]]){
            toolString = [toolString stringByAppendingFormat:@"%@, ", [[child class] description]];
        }
    }
    
    [FlurryAnalytics logEvent:@"Game Start" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:toolString, @"Tools Used",  nil]];
}

@end
