//
//  BTBugFryLeap.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTBugFryLeap.h"

@implementation BTBugFryLeap

- (void) bugFriedOfClass:(Class) c {
    [super bugFriedOfClass:c];
    if ([NSClassFromString(bugClass) isSubclassOfClass:c]){
        self.progress = MIN(quantity, self.progress+1);
    } else if (otherClass != nil && [c isSubclassOfClass:NSClassFromString(otherClass)]){
        self.progress = MIN(quantity, self.progress+1);
    }
}

@end
