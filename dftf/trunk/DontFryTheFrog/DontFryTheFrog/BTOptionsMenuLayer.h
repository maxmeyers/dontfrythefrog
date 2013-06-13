//
//  BTOptionsMenuLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

@class BTCreditsScene;

@interface BTOptionsMenuLayer : CCLayer <UIAlertViewDelegate> {
    BTCreditsScene *credits;
}

@end
