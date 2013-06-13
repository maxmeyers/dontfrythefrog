//
//  BTSelectionScene.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTHatSelectionScene.h"
#import "BTIncludes.h"

#define kCenterButtonEquipNoHat 0
#define kCenterButtonNoHatEquipped 1
#define kCenterButtonEquip 2
#define kCenterButtonEquipped 3
#define kCenterButtonBuy 4

#define kCurrentTextTag 5
#define kCurrentFrogModelTag 6
#define kCurrentHatTag 7
#define kFrogModelTag 8
#define kFrogHatTag 9
#define kCenterButtonTag 10
#define kCenterTextTag 11
#define kLockTag 12

@implementation BTHatSelectionScene

@synthesize origin = _origin, hats = _hats, menu = _menu, currentHat = _currentHat;
@synthesize hatSprites = _hatSprites, centerButtons = _centerButtons;

+ (void) showWithOrigin:(int) origin {
    BTHatSelectionScene *newScene = [BTHatSelectionScene node];
    newScene.origin = origin;
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.75 scene:newScene]];
}

- (NSString *) filenameForHat:(NSString *) hatName {
    NSDictionary *hatInfo = [[[[BTHopshopManager sharedHopshopManager] hopshopDetails] hats] objectForKey:hatName];
    if (hatInfo != NULL && [hatInfo objectForKey:@"filename"] != NULL){
        return [hatInfo objectForKey:@"filename"];
    }
    return @"";
}

- (id) init {
    self = [super init];
    if (self){
        BTBlockLayer *blockLayer = [BTBlockLayer node];
        [self addChild:blockLayer z:100];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTBackground.plist" textureFile:@"BTBackground.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTHopshop-Flies.plist" textureFile:@"BTHopshop-Flies.pvr.ccz"];

        self.hats = [[[[BTHopshopManager sharedHopshopManager] hopshopDetails] hats] allKeys];
        hatIndex = 0;
        
        NSMutableDictionary *sprites = [NSMutableDictionary dictionary];
        for (int i = 0; i < [self.hats count]; i++){
            NSString *name = [self.hats objectAtIndex:i];
            NSString *filename = [self filenameForHat:name];
            if (filename && ![filename isEqualToString:@""]){
                CCSprite *hat = [CCSprite spriteWithSpriteFrameName:filename];
                hat.position = ccp(240, 160);
                hat.visible = NO;
                [self addChild:hat z:4];
                [sprites setObject:hat forKey:name];                
            }
        }
        self.hatSprites = [NSDictionary dictionaryWithDictionary:sprites];
        
        Class bgClass = NSClassFromString([BTStorageManager currentBackground]);
        BTBackgroundLayer *bg;
        if ([bgClass isSubclassOfClass:[BTBackgroundLayer class]]){
            bg = [[[bgClass alloc] init] autorelease];
        } else {
            bg = [[[BTDefaultBackgroundLayer alloc] init] autorelease];
        }
        [self addChild:bg z:1];
        
        CCSprite *lilyUnderlay = [CCSprite spriteWithSpriteFrameName:@"lilypad-underlay.png"];
        lilyUnderlay.position = ccp(240, 280);
        [self addChild:lilyUnderlay z:2];
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Choose a hat!" dimensions:CGSizeMake(360, 75) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:32];
        title.position = lilyUnderlay.position;
        [self addChild:title z:3];
        
        CCMenuItemSprite *previous = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"left-arrow-undepressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"left-arrow-pressed.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"left-arrow-undepressed.png"] block:^(id sender){
            if (hatIndex == 0){
                [self showHat:[self.hats count]-1];
            } else {
                [self showHat:hatIndex-1];
            }
        }];
        previous.position = ccp(30, 160);
        
        CCMenuItemLabel *next = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"right-arrow-undepressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"right-arrow-pressed.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"right-arrow-undepressed.png"] block:^(id sender){
            if (hatIndex == [self.hats count]-1){
                [self showHat:0];
            } else {
                [self showHat:hatIndex+1];
            }
        }];
        next.position = ccp(450, 160);
        
        CCLayerColor *centerPanel = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 255*.75) width:240 height:120];
        centerPanel.position = ccp(120, 5);
        [self addChild:centerPanel z:2];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
            CCScene *newScene;
            if (self.origin == 0 || self.origin == kOriginMenuSelect){
                newScene = [BTMenuSelectionScene node];
            } else if (self.origin == kOriginHopshop) {
               newScene = [BTHopshopScene node];
            }
            
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.75 scene:newScene]];                
        }];
        backButton.position = ccp(50, 30);
        
        self.menu = [CCMenu menuWithItems:previous, next, backButton, nil];
        self.menu.position = ccp(0,0);
        [self addChild:self.menu z:3];
                
        CCMenuItemLabel *equipNoHatButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Take Off Hat!" fontName:@"soupofjustice" fontSize:30] target:self selector:@selector(equipHatAtIndex)];
        CCMenuItemLabel *noHatEquippedButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"No Hat Equipped" fontName:@"soupofjustice" fontSize:30]];
        noHatEquippedButton.isEnabled = NO;
        CCMenuItemLabel *equipButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Equip!" fontName:@"soupofjustice" fontSize:40] target:self selector:@selector(equipHatAtIndex)];
        CCMenuItemLabel *equippedButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Equipped!" fontName:@"soupofjustice" fontSize:40]];
        CCMenuItemLabel *buyButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Buy!" fontName:@"soupofjustice" fontSize:40] block:^(id sender){
            if ([[BTHopshopManager sharedHopshopManager] flyTokens] >= currentCost){
                if ([[BTHopshopManager sharedHopshopManager] spendFlyTokens:currentCost]){
                    [BTStorageManager setHat:currentName Unlocked:YES];
                    [BTStorageManager setCurrentHat:currentName];
                    [self showHat:hatIndex];
                }
            }
        }];
        equippedButton.isEnabled = NO;
        self.centerButtons = [NSArray arrayWithObjects:equipNoHatButton, noHatEquippedButton, equipButton, equippedButton, buyButton, nil];
        
        flyPenniesLabel = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(82, 27) alignment:UITextAlignmentRight fontName:@"soupofjustice" fontSize:25];
        flyPenniesLabel.position = ccp(41, 302);
        flyPenniesLabel.color = ccc3(0, 135, 11);
        [self addChild:flyPenniesLabel z:5];
        [self scheduleUpdate];
        
        CCSprite *coinbox = [CCSprite spriteWithSpriteFrameName:@"coin-box.png"];
        coinbox.position = ccp(62, 301);
        [self addChild:coinbox z:4];
        
        if (hatIndex != -1){
            [self showHat:hatIndex];
        }
    }
    return self;
}

- (void) update:(ccTime) dt {   
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *hopshopTokensString = [numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTHopshopManager sharedHopshopManager] flyTokens]]];
    if (![[flyPenniesLabel string] isEqualToString:hopshopTokensString]) {
        [flyPenniesLabel setString:hopshopTokensString];
    }
}

- (void) equipHatAtIndex {
    NSString *hatName = [self.hats objectAtIndex:hatIndex];
    
    if ([hatName isEqualToString:@"BTNoHat"]){
        [BTStorageManager setCurrentHat:@""];
    } else {
        [BTStorageManager setCurrentHat:hatName];
    }
    [self showHat:hatIndex];
}

- (void) showHat:(int) index {
    hatIndex = index;
    
    for (int i = kCurrentTextTag; i <= kLockTag; i++){
        if ([self.menu getChildByTag:i]){
            [self.menu removeChildByTag:i cleanup:YES];
        }
        
        if ([self getChildByTag:i]){
            [self removeChildByTag:i cleanup:YES];
        }
    }
    
    CCLabelTTF *currentText = [CCLabelTTF labelWithString:@"Current Frog" fontName:@"soupofjustice" fontSize:15];
    currentText.position = ccp(420, 65);
    [self addChild:currentText z:3 tag:kCurrentTextTag];
    
    CCSprite *currentFrog = [CCSprite spriteWithSpriteFrameName:@"frog-model.png"];
    currentFrog.position = ccp(420, 30);
    currentFrog.scale = 0.33;
    [self addChild:currentFrog z:3 tag:kCurrentFrogModelTag];
    
    if (![[BTStorageManager currentHat] isEqualToString:@""] && ![[self filenameForHat:[BTStorageManager currentHat]] isEqualToString:@""]){
        CCSprite *currentHat = [CCSprite spriteWithSpriteFrameName:[self filenameForHat:[BTStorageManager currentHat]]];
        currentHat.scale = currentFrog.scale;
        currentHat.position = currentFrog.position;
        [self addChild:currentHat z:3 tag:kCurrentHatTag];
    }
    
    CCSprite *model = [CCSprite spriteWithSpriteFrameName:@"frog-model.png"];
    model.position = ccp(240, 160);
    [self addChild:model z:3 tag:kFrogModelTag];
    
    currentName = [self.hats objectAtIndex:hatIndex];
    for (int i = 0; i < [self.hats count]; i++){
        CCSprite *hatSprite = [self.hatSprites objectForKey:[self.hats objectAtIndex:i]];
        if (hatSprite){
            if (hatIndex == i){
                hatSprite.visible = YES;
            } else {
                hatSprite.visible = NO;
            }
        }
    }
      
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

    currentCost = [[[[[[BTHopshopManager sharedHopshopManager] hopshopDetails] hats] objectForKey:currentName] objectForKey:@"Cost"] intValue];
    
    CCMenuItemLabel *centerButton = nil;
    if ([BTStorageManager hatUnlocked:currentName] || [currentName isEqualToString:@"BTNoHat"]){
        if ([[BTStorageManager currentHat] isEqualToString:currentName]){
            centerButton = [self.centerButtons objectAtIndex:kCenterButtonEquipped];
        } else if ([currentName isEqualToString:@"BTNoHat"]){
            if ([[BTStorageManager currentHat] isEqualToString:@""]){
                centerButton = [self.centerButtons objectAtIndex:kCenterButtonNoHatEquipped];
            } else {
                centerButton = [self.centerButtons objectAtIndex:kCenterButtonEquipNoHat];
            }
        } else {
            centerButton = [self.centerButtons objectAtIndex:kCenterButtonEquip];
        }
        centerButton.position = ccp(240, 40);
    } else {       
        centerButton = [self.centerButtons objectAtIndex:kCenterButtonBuy];
        centerButton.position = ccp(240, 60);
        
        if ([[BTHopshopManager sharedHopshopManager] flyTokens] < currentCost){
            centerButton.isEnabled = NO;
            CCSprite *cantAffordSprite = [CCSprite spriteWithSpriteFrameName:@"not-enough-FPs.png"];
            cantAffordSprite.position = centerButton.position;
            cantAffordSprite.scale = 0.5;
            [self addChild:cantAffordSprite z:4 tag:kLockTag];
        } else {
            centerButton.isEnabled = YES;
        }
        
        CCLabelTTF *unlockText = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Cost: %@ Fly Pennies", [numberFormatter stringFromNumber:[NSNumber numberWithInt:currentCost]]] dimensions:CGSizeMake(220, 46) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:20];
        unlockText.position = ccp(240, 20);
        [self addChild:unlockText z:3 tag:kCenterTextTag];
    }
    if (centerButton != nil){
        [self.menu addChild:centerButton z:0 tag:kCenterButtonTag];           
    }
}

- (void) dealloc {
    [_hats release];
    [super dealloc];
}

@end
