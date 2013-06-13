//
//  BTLevelingLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

#define kPadsRemainingTitleTag 1
#define kPadsRemainingTag 2
#define kPadsRemainingLabelTag 3
#define kCurrentFrogSpriteTag 4
#define kCurrentLevelTag 5
#define kCurrentNameTag 6

@interface BTLevelingLayer : CCLayer

- (void) refresh;

@end
