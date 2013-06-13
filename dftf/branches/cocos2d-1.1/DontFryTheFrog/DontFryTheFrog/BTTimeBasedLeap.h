//
//  BTTimeBasedLeap.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTLeap.h"

@interface BTTimeBasedLeap : BTLeap {
    ccTime seconds;
}

- (void) addTimeToProgress:(ccTime) time;

@end
