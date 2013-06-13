//
//  BTNewLog.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"

#define kNewsLogOffscreen CGPointMake(520, 160)
#define kNewsLogOnscreen CGPointMake(347, 160)

@interface BTNewsLog : CCNode {
    bool onScreen_;
}

+ (BTNewsLog *) sharedNewsLog;
- (void) refreshNews;

- (void) toggle;
- (void) appear;
- (void) disappear;

@end
