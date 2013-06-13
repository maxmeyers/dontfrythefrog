//
//  BTUtils.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BTUtils : NSObject

+ (CCSprite*) spriteWithString:(NSString *)string fontName:(NSString *)fontName fontSize:(CGFloat)fontSize color:(ccColor3B)color strokeSize:(CGFloat)strokeSize strokeColor:(ccColor3B)strokeColor;
+ (CCRenderTexture*) createStroke: (CCLabelTTF*) label   size:(float)size   color:(ccColor3B)cor;

@end
