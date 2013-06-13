//
//  CCMenuItemFontWithStroke.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCMenuItemFontWithStroke.h"
#import "BTIncludes.h"

@implementation CCMenuItemFontWithStroke

#define kTagStroke 1029384756

-(id) initFromString: (NSString*) value target:(id) rec selector:(SEL) cb
{
	self = [super initFromString:value target:rec selector:cb];
    
	if ([label_ isKindOfClass: [CCLabelTTF class]]) {
		CCRenderTexture * stroke  = [BTUtils createStroke:(CCLabelTTF *)label_ size:1 color:btGREEN];
		[self addChild:stroke z:-1 tag:kTagStroke];
	}else{
		NSLog(@"Error adding stroke in menu, label_ is not a CCLabelTTF.  This has only been tested on cocos2d 99.5");
	}
    
	return self;
}

-(void) setString:(NSString *)string
{
	[super setString:string];
    
	if ([label_ isKindOfClass: [CCLabelTTF class]]) {
		[self removeChildByTag:kTagStroke cleanup:YES];
		CCRenderTexture * stroke  = [BTUtils createStroke:(CCLabelTTF *)label_ size:1 color:btGREEN];
		[self addChild:stroke z:-1 tag:kTagStroke];
        
	}else{
		NSLog(@"Error adding stroke in menu, label_ is not a CCLabelTTF.  This has only been tested on cocos2d 99.5");
	}
    
}

@end

@implementation CCMenuItemLabelWithStroke

- (id) initWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol> *)label strokeColor:(ccColor3B)strokeColor block:(void (^)(id))block {
    block_ = [block copy];
	return [self initWithLabel:label strokeColor:strokeColor target:block_ selector:@selector(ccCallbackBlockWithSender:)];
}

- (id) initWithLabel:(CCNode<CCLabelProtocol,CCRGBAProtocol> *)label strokeColor:(ccColor3B) strokeColor target:(id)target selector:(SEL)selector
{
    self = [super initWithLabel:label target:target selector:selector];
    
    if ([label_ isKindOfClass: [CCLabelTTF class]]) {
		CCRenderTexture * stroke  = [BTUtils createStroke:(CCLabelTTF *)label_ size:1 color:strokeColor];
		[self addChild:stroke z:-1 tag:kTagStroke];
	}else{
		NSLog(@"Error adding stroke in menu, label_ is not a CCLabelTTF.  This has only been tested on cocos2d 99.5");
	}
    
    return self;
}

- (void) setString:(NSString *)string {
	[super setString:string];
    
	if ([label_ isKindOfClass: [CCLabelTTF class]]) {
		[self removeChildByTag:kTagStroke cleanup:YES];
		CCRenderTexture * stroke  = [BTUtils createStroke:(CCLabelTTF *)label_ size:1 color:btGREEN];
		[self addChild:stroke z:-1 tag:kTagStroke];
        
	}else{
		NSLog(@"Error adding stroke in menu, label_ is not a CCLabelTTF.  This has only been tested on cocos2d 99.5");
	}
    
}

@end