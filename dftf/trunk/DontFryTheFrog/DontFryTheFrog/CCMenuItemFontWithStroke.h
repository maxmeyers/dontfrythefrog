//
//  CCMenuItemFontWithStroke.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCMenuItem.h"

@interface CCMenuItemFontWithStroke : CCMenuItemFont

@end

@interface CCMenuItemLabelWithStroke : CCMenuItemLabel

- (id) initWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol> *)label strokeColor:(ccColor3B)strokeColor block:(void (^)(id))block;
- (id) initWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol> *)label strokeColor:(ccColor3B)strokeColor target:(id)target selector:(SEL)selector;

@end