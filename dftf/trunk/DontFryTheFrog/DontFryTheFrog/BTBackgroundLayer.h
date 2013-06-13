//
//  BTBackgroundLayer.h
//  
//
//  Created by Max Meyers on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"

@interface BTBackgroundLayer : CCLayer

+ (ccColor3B) textColor;
+ (NSString *) name;
+ (NSString *) shortName;
- (void) killObject:(CCNode *) node;

@end
