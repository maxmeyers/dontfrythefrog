//
//  BTMenuLilypad.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"

@interface BTMenuLilypad : CCNode <CCRGBAProtocol>

- (id) initWithPressed:(bool) pressed;
- (id) initWithPressed:(bool)pressed LilyPadSpriteName:(NSString *) spriteName;

@end
