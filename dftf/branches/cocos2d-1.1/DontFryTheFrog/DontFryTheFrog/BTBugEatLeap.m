//
//  BTBugEatLeap.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTBugEatLeap.h"

@implementation BTBugEatLeap

- (void) bugEatenOfClass:(Class) c {
    [super bugEatenOfClass:c];
    if ([c isSubclassOfClass:NSClassFromString(bugClass)]){
        self.progress = MIN(quantity, self.progress+1);
    } else if (otherClass != nil && [c isSubclassOfClass:NSClassFromString(otherClass)]){
        self.progress = MIN(quantity, self.progress+1);
    }
}

@end
