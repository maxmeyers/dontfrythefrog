//
//  BTBackgroundSelectLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTBackgroundSelectLayer.h"
#import "BTIncludes.h"

#define farLeftPosition     ccp(-75, 160)
#define leftThumbPosition   ccp(100, 160)
#define centerThumbPosition ccp(240, 160)
#define rightThumbPosition  ccp(380, 160)
#define farRightPosition    ccp(555, 160)

#define goneScale 0
#define sideScale 0.5
#define centerScale 1.0

#define kLeftBackgroundThumbTag 7
#define kCenterBackgroundThumbTag 8
#define kRightBackgroundThumbTag 9
#define kBackgroundTitleTag 10
#define kCenterTextTag 11
#define kLockTag 12
#define kPrice 13

#define kCenterButtonTag 20


@implementation BTBackgroundSelectLayer

@synthesize backgroundClasses = _backgroundClasses, backgroundThumbnails = _backgroundThumbnails, menu = _menu;

- (id) initWithHopshopLayer:(BTHopshopLayer *)hopshop {
    self = [super init];
    if (self){
                
        hopshopLayer_ = hopshop;        
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"purchase-box.png"];
        background.position = ccp(240, 160);
        [self addChild:background z:0 tag:4];
        
        CCSprite *title = [CCSprite spriteWithSpriteFrameName:@"background-title.png"];
        title.position = ccp(240, 282);
        [self addChild:title z:1 tag:5];
        
        CCMenuItemSprite *previous = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"left-arrow-undepressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"left-arrow-pressed.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"left-arrow-undepressed.png"] block:^(id sender){
            [self previous];
        }];
        previous.position = ccp(30, 160);
        
        CCMenuItemLabel *next = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"right-arrow-undepressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"right-arrow-pressed.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"right-arrow-undepressed.png"] block:^(id sender){
            [self next];
        }];
        next.position = ccp(450, 160);
        
        CCMenuItemSprite *exit = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"]selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
            [hopshopLayer_ returnToProminence];
            [self removeFromParent];
        }];
        exit.position = ccp(50, 35);
        
        self.menu = [CCMenu menuWithItems:previous, next, exit, nil];
        self.menu.position = ccp(0,0);
        [self addChild:self.menu z:7 tag:6];
        
        self.backgroundClasses = [NSArray arrayWithArray:[[[[BTHopshopManager sharedHopshopManager] hopshopDetails] backgrounds] allKeys]];
        NSMutableArray *thumbs = [NSMutableArray array];
        for (NSString *bgName in self.backgroundClasses){
            [thumbs addObject:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@.png", bgName]]];
        }
        self.backgroundThumbnails = [NSArray arrayWithArray:thumbs];
        [self showBackground:0];
    }
    return self;
}

- (void) previous {
    int newIndex = [self indexForDirection:kLeft currentIndex:backgroundIndex];
    if (newIndex != -1){
        [self showBackground:newIndex];
    }
}

- (void) next {
    int newIndex = [self indexForDirection:kRight currentIndex:backgroundIndex];
    if (newIndex != -1){
        [self showBackground:newIndex];
    }       
}

- (void) showBackground:(int) index {
    for (int i = kLeftBackgroundThumbTag; i <= kPrice; i++){
        if ([self getChildByTag:i]){
            [self removeChildByTag:i cleanup:YES];
        }
    }
    
    if ([self getChildByTag:kCenterButtonTag]){
        [self removeChildByTag:kCenterButtonTag cleanup:YES];
    }

    backgroundIndex = index;
    NSString *backgroundName = [self.backgroundClasses objectAtIndex:backgroundIndex];
    Class bgClass = NSClassFromString(backgroundName);
    
    int leftIndex = [self indexForDirection:kLeft currentIndex:backgroundIndex];
    int rightIndex = [self indexForDirection:kRight currentIndex:backgroundIndex];
    
    if (backgroundIndex < [self.backgroundThumbnails count]){
        CCSprite *centerThumb = [self.backgroundThumbnails objectAtIndex:backgroundIndex];
        centerThumb.position = centerThumbPosition;
        centerThumb.scale = centerScale;
        [self addChild:centerThumb z:4 tag:kCenterBackgroundThumbTag];
    }
    
    if (leftIndex != -1 && leftIndex < [self.backgroundThumbnails count]){
        CCSprite *leftThumb = [self.backgroundThumbnails objectAtIndex:leftIndex];
        leftThumb.position = leftThumbPosition;
        leftThumb.scale = sideScale;
        [self addChild:leftThumb z:3 tag:kLeftBackgroundThumbTag];
    }

    if (rightIndex != -1 && rightIndex < [self.backgroundThumbnails count]){
        CCSprite *rightThumb = [self.backgroundThumbnails objectAtIndex:rightIndex];
        rightThumb.position = rightThumbPosition;
        rightThumb.scale = sideScale;
        [self addChild:rightThumb z:3 tag:kRightBackgroundThumbTag];
    }
    
    CCLabelTTF *title = [CCLabelTTF labelWithString:[bgClass shortName] fontName:@"soupofjustice" fontSize:32];
    title.position = ccp(240, 245);
    title.color = ccc3(235, 235, 235);
    [self addChild:title z:4 tag:kBackgroundTitleTag];
    
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter new] autorelease];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    int cost = [[[[[[BTHopshopManager sharedHopshopManager] hopshopDetails] backgrounds] objectForKey:backgroundName] objectForKey:@"Cost"] intValue];
    int levelRequired = [[[[[[BTHopshopManager sharedHopshopManager] hopshopDetails] backgrounds] objectForKey:backgroundName] objectForKey:@"Level"] intValue];
    
    CCMenuItemLabel *centerButton = NULL;
    if ([BTStorageManager backgroundUnlocked:backgroundName] || (cost == 0 && [BTStorageManager playerLevel] >= levelRequired)
        ){
        if ([[BTStorageManager currentBackground] isEqualToString:backgroundName]){
            CCLabelTTF *centerText = [CCLabelTTF labelWithString:@"Current Background" fontName:@"soupofjustice" fontSize:25];
            centerText.position = ccp(240, 70);
            centerText.color = ccGREEN;
            [self addChild:centerText z:3 tag:kCenterTextTag];
        } else {
            [BTStorageManager setBackground:backgroundName Unlocked:YES]; // In case they got it via the second one, it should just be unlocked.
            CCLabelTTF *centerText = [CCLabelTTF labelWithString:@"Choose Background" fontName:@"soupofjustice" fontSize:25];
            centerText.color = ccBLUE;
            centerButton = [CCMenuItemLabel itemWithLabel:centerText block:^(id sender){
                [BTStorageManager setCurrentBackground:backgroundName];
                [self showBackground:backgroundIndex];
            }];
            centerButton.position = ccp(240, 70);
        }
    } else {       
        if ([BTStorageManager playerLevel] >= levelRequired){
            centerButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Buy!" fontName:@"soupofjustice" fontSize:30] block:^(id sender){
                if ([[BTHopshopManager sharedHopshopManager] flyTokens] >= cost){
                    if ([[BTHopshopManager sharedHopshopManager] spendFlyTokens:cost]){
                        [BTStorageManager setBackground:backgroundName Unlocked:YES];
                        [self showBackground:backgroundIndex];
                    }
                }
            }];
            centerButton.position = ccp(420, 40);
            
            if ([[BTHopshopManager sharedHopshopManager] flyTokens] < cost){
                centerButton.isEnabled = NO;
                CCSprite *cantAffordSprite = [CCSprite spriteWithSpriteFrameName:@"not-enough-FPs.png"];
                cantAffordSprite.position = centerButton.position;
                cantAffordSprite.scale = 0.4;
                [self addChild:cantAffordSprite z:8 tag:kLockTag];
            }            
            
            CCLabelTTF *priceLabel = [CCLabelTTF labelWithString:[numberFormatter stringFromNumber:[NSNumber numberWithInt:cost]] dimensions:CGSizeMake(150, 38) alignment:UITextAlignmentRight fontName:@"soupofjustice" fontSize:36];
            priceLabel.position = ccp(275, 42);
            [self addChild:priceLabel z:1 tag:kPrice];
        } else {            
            CCLabelTTF *unlockText = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Unlock at Level %d for\n%@ Fly Pennies", levelRequired, [numberFormatter stringFromNumber:[NSNumber numberWithInt:cost]]] dimensions:CGSizeMake(220, 46) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:20];
            unlockText.position = ccp(240, 60);
            [self addChild:unlockText z:3 tag:kCenterTextTag];
        }
        
    }
    
//    if ([BTStorageManager backgroundUnlocked:backgroundName]){
//        cost = 0;
//    }
    
    
    if (centerButton){
        CCMenu *buttonMenu = [CCMenu menuWithItems:centerButton, nil];
        buttonMenu.position = ccp(0,0);
        [self addChild:buttonMenu z:7 tag:kCenterButtonTag];
    }

}

- (int) indexForDirection:(tDirection) direction currentIndex:(int) index {
    if ([self.backgroundThumbnails count] == 1){
        return -1;
    } else if ([self.backgroundThumbnails count] == 2){
        if (index == 0 && direction == kRight){
            return 1;
        } else if (index == 1 && direction == kLeft){
            return 0;
        }
    } else if ([self.backgroundThumbnails count] >2){
        if (direction == kLeft){
            if ((backgroundIndex - 1) >= 0){
                return (backgroundIndex - 1);
            } else {
                return ([self.backgroundThumbnails count] - 1);
            }
        } else if (direction == kRight) {
            if ((backgroundIndex + 1) < [self.backgroundThumbnails count]){
                return (backgroundIndex + 1);
            } else {
                return 0;
            }
        } 
    }
    return -1;
}


@end












