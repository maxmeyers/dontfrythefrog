//
//  BTSelectionScene.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTMenuSelectionScene.h"
#import "BTIncludes.h"

#define kCenterButtonTag 10
#define kCenterTextTag 11
#define kLockTag 12
#define kHopshopButtonTag 13
#define kHopshopTextTag 14

@implementation BTMenuSelectionScene

@synthesize backgrounds = _backgrounds, currentBackground = _currentBackground, menu = _menu;

- (id) init {
    self = [super init];
    if (self){
        BTBlockLayer *blockLayer = [BTBlockLayer node];
        [self addChild:blockLayer z:100];
                
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTBackground.plist" textureFile:@"BTBackground.pvr.ccz"];
        [BTStorageManager setBackground:@"BTDefaultBackgroundLayer" Unlocked:YES];
               
        backgroundIndex = -1;
        NSMutableArray *backgrounds = [NSMutableArray array]; 
        
        NSArray *backgroundNames = [NSArray arrayWithArray:[[[[BTHopshopManager sharedHopshopManager] hopshopDetails] backgrounds] allKeys]];
        for (NSString *string in backgroundNames){                
            Class backgroundClass = NSClassFromString(string);
            if ([backgroundClass isSubclassOfClass:[BTBackgroundLayer class]]){
                BTBackgroundLayer *background = [[[backgroundClass alloc] init] autorelease];
                [background setVisible:NO];
                [self addChild:background z:0];
                [backgrounds addObject:background];
                
                if ([string isEqualToString:[BTStorageManager currentBackground]]){
                    backgroundIndex = [backgrounds indexOfObject:background];
                }
            }
        }
        
        if (backgroundIndex == -1 && [self.backgrounds count] > 0){
            backgroundIndex = 0;
        }
        
        self.backgrounds = [NSArray arrayWithArray:backgrounds];
        
        CCSprite *lilyUnderlay = [CCSprite spriteWithSpriteFrameName:@"lilypad-underlay.png"];
        lilyUnderlay.position = ccp(240, 280);
        [self addChild:lilyUnderlay z:2];
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:NSLocalizedString(@"BG_Select_Title", nil) dimensions:CGSizeMake(360, 75) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:32];
        title.position = lilyUnderlay.position;
        [self addChild:title z:3];
//        CCRenderTexture *stroke = [BTUtils createStrokeWithLabel:title strokeSize:1 strokeColor:btGreen];
        CCRenderTexture *stroke = [BTUtils createStroke:title size:1 color:btGREEN];
        [self addChild:stroke z:2];
        
        CCMenuItemSprite *previous = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"left-arrow-undepressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"left-arrow-pressed.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"left-arrow-undepressed.png"] block:^(id sender){
            if (backgroundIndex == 0){
                [self showBackground:[self.backgrounds count]-1];
            } else {
                [self showBackground:backgroundIndex-1];
            }
        }];
        previous.position = ccp(30, 160);

        CCMenuItemLabel *next = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"right-arrow-undepressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"right-arrow-pressed.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"right-arrow-undepressed.png"] block:^(id sender){
            if (backgroundIndex == [self.backgrounds count]-1){
                [self showBackground:0];
            } else {
                [self showBackground:backgroundIndex+1];
            }
        }];
        next.position = ccp(450, 160);

        CCLayerColor *centerPanel = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 255*.75) width:240 height:120];
        centerPanel.position = ccp(120, 100);
        [self addChild:centerPanel z:2];
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
            [[CCDirector sharedDirector] popScene];
        }];
        backButton.position = ccp(50, 30);
        
        self.menu = [CCMenu menuWithItems:previous, next, backButton, nil];
        self.menu.position = ccp(0,0);
        [self addChild:self.menu z:3];
        
        CCMenuItemSprite *hats = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"hat-select-lilypad.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"hat-select-lilypad.png"] block:^(id sender){
            [BTHatSelectionScene showWithOrigin:kOriginMenuSelect];
        }];
        hats.position = ccp(400, 50);
        [self.menu addChild:hats];
        
        if (backgroundIndex != -1){
            [self showBackground:backgroundIndex];
        }
    }
    return self;
}

- (void) showBackground:(int) index {
    backgroundIndex = index;
    
    for (int i = 0; i < [self.backgrounds count]; i++){
        BTBackgroundLayer *background = [self.backgrounds objectAtIndex:i];
        if (i == backgroundIndex){
            background.visible = YES;
            self.currentBackground = background;
        } else {
            background.visible = NO;
        }
    }
    NSString *backgroundName = NSStringFromClass([self.currentBackground class]);

    for (int i = kCenterButtonTag; i <= kHopshopTextTag; i++){
        if ([self.menu getChildByTag:i]){
            [self.menu removeChildByTag:i cleanup:YES];
        }
        
        if ([self getChildByTag:i]){
            [self removeChildByTag:i cleanup:YES];
        }
    }

    CCMenuItemSprite *hopshopMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"hopshop-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"hopshop-pressed.png"] disabledSprite:[CCSprite spriteWithSpriteFrameName:@"hopshop-pressed.png"] block:^(id sender){
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [delegate openHopshop];
    }];
    hopshopMenuItem.position = ccp(240, 40);
    [self.menu addChild:hopshopMenuItem z:0 tag:kHopshopButtonTag];
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    CCLabelTTF *hopshopLabel = [CCLabelTTF labelWithString:[numberFormatter stringFromNumber:[NSNumber numberWithInt:[[BTHopshopManager sharedHopshopManager] flyTokens]]] dimensions:CGSizeMake(100, 30) alignment:UITextAlignmentRight fontName:@"soupofjustice" fontSize:16];
    hopshopLabel.color = ccc3(206, 162, 31);
    hopshopLabel.position = ccp(238, 25);
    [self addChild:hopshopLabel z:4 tag:kHopshopTextTag];
    
    int cost = [[[[[[BTHopshopManager sharedHopshopManager] hopshopDetails] backgrounds] objectForKey:backgroundName] objectForKey:@"Cost"] intValue];
    int levelRequired = [[[[[[BTHopshopManager sharedHopshopManager] hopshopDetails] backgrounds] objectForKey:backgroundName] objectForKey:@"Level"] intValue];
    
    CCMenuItemLabelWithStroke *centerButton;
    if ([BTStorageManager backgroundUnlocked:backgroundName] || (cost == 0 && [BTStorageManager playerLevel] >= levelRequired)){
        [BTStorageManager setCurrentBackground:backgroundName];
        [BTStorageManager setBackground:backgroundName Unlocked:YES]; // In case they got it via the second one, it should just be unlocked.
        CCLabelTTF *playLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"BG_Select_Play", nil) fontName:@"soupofjustice" fontSize:40];
        playLabel.color = btGREEN;
        centerButton = [[[CCMenuItemLabelWithStroke alloc] initWithLabel:playLabel strokeColor:ccWHITE block:^(id sender) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate startGame];
        }] autorelease];
        centerButton.position = ccp(240, 160);
    } else {       

        if ([BTStorageManager playerLevel] >= levelRequired){
            CCLabelTTF *buyLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"BG_Select_Buy", nil) fontName:@"soupofjustice" fontSize:40];
            buyLabel.color = btGREEN;
            centerButton = [[[CCMenuItemLabelWithStroke alloc] initWithLabel:buyLabel strokeColor:ccWHITE block:^(id sender){
                if ([[BTHopshopManager sharedHopshopManager] flyTokens] >= cost){
                    if ([[BTHopshopManager sharedHopshopManager] spendFlyTokens:cost]){
                        [BTStorageManager setBackground:backgroundName Unlocked:YES];
                        [self showBackground:backgroundIndex];
                    }
                }
            }] autorelease];
            centerButton.position = ccp(240, 180);
            
            if ([[BTHopshopManager sharedHopshopManager] flyTokens] < cost){
                centerButton.isEnabled = NO;
                CCSprite *cantAffordSprite = [CCSprite spriteWithSpriteFrameName:@"not-enough-FPs.png"];
                cantAffordSprite.position = centerButton.position;
                cantAffordSprite.scale = 0.5;
                [self addChild:cantAffordSprite z:4 tag:kLockTag];
            }
            
            CCLabelTTF *unlockText = [CCLabelTTF labelWithString:[NSString stringWithFormat:NSLocalizedString(@"BG_Select_Cost_Message", nil), [numberFormatter stringFromNumber:[NSNumber numberWithInt:cost]]] dimensions:CGSizeMake(220, 46) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:20];
            unlockText.position = ccp(240, 120);
            [self addChild:unlockText z:3 tag:kCenterTextTag];
            
        } else {
            centerButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:NSLocalizedString(@"BG_Select_Locked", nil) fontName:@"soupofjustice" fontSize:40]];
            centerButton.isEnabled = NO;
            centerButton.position = ccp(240, 180);
            
            CCLabelTTF *unlockText = [CCLabelTTF labelWithString:[NSString stringWithFormat:NSLocalizedString(@"BG_Select_Unlock_Message", nil), levelRequired, [numberFormatter stringFromNumber:[NSNumber numberWithInt:cost]]] dimensions:CGSizeMake(220, 46) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:20];
            unlockText.position = ccp(240, 140);
            [self addChild:unlockText z:3 tag:kCenterTextTag];
        }
    }
    [self.menu addChild:centerButton z:0 tag:kCenterButtonTag];
                                
    [numberFormatter release];
}
                                         
- (void) dealloc {
    [_backgrounds release];
    [super dealloc];
}

@end
