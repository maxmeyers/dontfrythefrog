//
//  BTBugUpgradeLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTBugUpgradeSelectLayer.h"
#import "BTIncludes.h"

#define kMenuTag 97
#define kTitleTag 98
#define kBugUpgradeBackgroundTag 99
#define kRedBugLevel 100
#define kYellowBugLevel 101
#define kGreenBugLevel 102
#define kBlueBugLevel 103

@implementation BTBugUpgradeSelectLayer

@synthesize hopshopLayer = hopshopLayer_;

- (id) initWithHopshopLayer:(BTHopshopLayer *)hopshop {
    self = [super init];
    if (self){
        self.hopshopLayer = hopshop;        
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"select.png"];
        background.position = ccp(240, 160);
        [self addChild:background z:0 tag:kBugUpgradeBackgroundTag];
        
        CCSprite *title = [BTUtils spriteWithString:NSLocalizedString(@"Bug_Upgrade_Title", nil) fontName:@"soupofjustice" fontSize:45 color:ccWHITE strokeSize:1 strokeColor:btGREEN];
        title.position = ccp(240, 282);
        [self addChild:title z:1 tag:kTitleTag];
        
        CCMenuItemSprite *redBug = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"red-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"red-pressed.png"] block:^(id sender){
            [self lostProminence];
            [self addChild:[[[BTBugUpgradeSublayer alloc] initWithBugUpgradeLayer:self Bug:[BTFireBug class]] autorelease] z:0];
        }];
        redBug.position = ccp(328, 90);
        CCSprite *redLevel = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%d.png", MIN(4, [[BTHopshopManager sharedHopshopManager] levelForBug:[BTFireBug class]])]];
        redLevel.position = ccp(redBug.position.x + 50, redBug.position.y - 45);
        [self addChild:redLevel z:3 tag:kRedBugLevel];
        
        CCMenuItemLabel *yellowBug = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"yellow-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"yellow-pressed.png"] block:^(id sender){
            [self lostProminence];
            [self addChild:[[[BTBugUpgradeSublayer alloc] initWithBugUpgradeLayer:self Bug:[BTSickBug class]] autorelease] z:0];
        }];
        yellowBug.position = ccp(328, 200);
        CCSprite *yellowLevel = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%d.png", MIN(4, [[BTHopshopManager sharedHopshopManager] levelForBug:[BTSickBug class]])]];
        yellowLevel.position = ccp(yellowBug.position.x + 50, yellowBug.position.y - 45);
        [self addChild:yellowLevel z:3 tag:kYellowBugLevel];
        
        CCMenuItemLabel *greenBug = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"green-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"green-pressed.png"] block:^(id sender){
            [self lostProminence];
            [self addChild:[[[BTBugUpgradeSublayer alloc] initWithBugUpgradeLayer:self Bug:[BTGreenFly class]] autorelease] z:0];
        }];
        greenBug.position = ccp(160, 200);
        CCSprite *greenLevel = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%d.png", MIN(4, [[BTHopshopManager sharedHopshopManager] levelForBug:[BTGreenFly class]])]];
        greenLevel.position = ccp(greenBug.position.x + 50, greenBug.position.y - 45);
        [self addChild:greenLevel z:3 tag:kGreenBugLevel];
        
        CCMenuItemLabel *blueBug = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"blue-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"blue-pressed.png"] block:^(id sender){
            [self lostProminence];
            [self addChild:[[[BTBugUpgradeSublayer alloc] initWithBugUpgradeLayer:self Bug:[BTIceBug class]] autorelease] z:0];
        }];
        blueBug.position = ccp(160, 90);
        CCSprite *blueLevel = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%d.png", MIN(4, [[BTHopshopManager sharedHopshopManager] levelForBug:[BTIceBug class]])]];
        blueLevel.position = ccp(blueBug.position.x + 50, blueBug.position.y - 45);
        [self addChild:blueLevel z:3 tag:kBlueBugLevel];
        
        CCMenuItemSprite *exit = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"]selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
            [hopshopLayer_ returnToProminence];
            [self removeFromParent];
        }];
        exit.position = ccp(50, 35);
        
        CCMenu *menu = [CCMenu menuWithItems:redBug, yellowBug, greenBug, blueBug, exit, nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:2 tag:kMenuTag];
    }
    return self;
}

- (void) lostProminence {
    for (int i = kMenuTag; i <= kBlueBugLevel; i++){
        if ([self getChildByTag:i] != nil){
            [self getChildByTag:i].visible = NO;
        }
    }
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:[self getChildByTag:kMenuTag]];
}

- (void) returnToProminence {
    for (int i = kMenuTag; i <= kBlueBugLevel; i++){
        if ([self getChildByTag:i] != nil){
            [self getChildByTag:i].visible = YES;
        }
    }
    [(CCMenu *)[self getChildByTag:kMenuTag] registerWithTouchDispatcher];
    [[self parent] addChild:[[[BTBugUpgradeSelectLayer alloc] initWithHopshopLayer:hopshopLayer_] autorelease] z:2];
    [self removeFromParent];
}

@end

#define kDescription 15
#define kMenu 16
#define kPrice 17
#define kLock 18
#define kBug 19
#define kBugShiny 20
#define kBugLevel 21

@implementation BTBugUpgradeSublayer

- (id) initWithBugUpgradeLayer:(BTBugUpgradeSelectLayer *) upgradeSelectLayer Bug:(Class) bugClass {
    self = [super init];
    if (self){
        upgradeSelectLayer_ = upgradeSelectLayer;
        bugClass_ = bugClass;
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"purchase-box.png"];
        background.position = ccp(240, 160);
        [self addChild:background z:0 tag:kBugUpgradeBackgroundTag];
        
        
        CCSprite *title = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-fly-upgrade-title.png", [bugClass_ color]]];
        title.position = ccp(240, 282);
        [self addChild:title z:1 tag:kTitleTag];
        
        int currentLevel = [[BTHopshopManager sharedHopshopManager] levelForBug:bugClass_];
        int levelDisplayed = MIN(4, currentLevel + 1);
        [self setDisplayedLevel:levelDisplayed];
    }
    
    return self;
}

- (void) setDisplayedLevel:(int) level {

    for (int i = kDescription; i <= kBugLevel; i++){
        if ([self getChildByTag:i] != nil){
            [self removeChildByTag:i cleanup:YES];
        }
    }
    
    int currentLevel = [[BTHopshopManager sharedHopshopManager] levelForBug:bugClass_];    
    CCMenu *menu = [CCMenu menuWithItems:nil];
    menu.position = ccp(0,0);
    [self addChild:menu z:1 tag:kMenu];
    for (int i = 1; i < 5; i++){
        NSString *fileName = [NSString stringWithFormat:@"black%d.png", i];
        if (i != level){
            if (currentLevel < 4){
                // Any number that's not selected and less than or equal to current level
                if (i <= currentLevel){
                    fileName = [NSString stringWithFormat:@"%@%d.png", [bugClass_ color], i];
                } 
                // Any number that's not selected and greater than the current level
                else if (i > currentLevel){
                    fileName = [NSString stringWithFormat:@"black%d.png", i];
                }
            } else if (currentLevel >= 4){
                fileName = [NSString stringWithFormat:@"gold%d.png", i];
            }
        } else if (i == level){
            fileName = [NSString stringWithFormat:@"grey%d.png", i];
        }
        
        int x = -240;
        if (i == 1){
            x = 200;
        } else if (i == 2){
            x = 250;
        } else if (i == 3){
            x = 320;
        } else if (i == 4){
            x = 400;
        }
        
        CCMenuItemSprite *levelButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:fileName] selectedSprite:[CCSprite spriteWithSpriteFrameName:fileName] block:^(id sender){
            [self setDisplayedLevel:i];
        }];
        levelButton.position = ccp(x, 215);
        [menu addChild:levelButton];
    }
    
    CCSprite *flySprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-pressed.png", [bugClass_ color]]];
    flySprite.position = ccp(110, 215);
    [self addChild:flySprite z:1 tag:kBug];
    
    CCSprite *bugLevel = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%d.png", MIN(4, currentLevel)]];
    bugLevel.position = ccp(flySprite.position.x + 50, flySprite.position.y - 45);
    [self addChild:bugLevel z:2 tag:kBugLevel];
    
    if (level >= 2){
        CCSprite *shinySprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"sparkle-overlay-L%d.png", MIN(level, 4)]];
        shinySprite.position = ccp(100, 215);
        [self addChild:shinySprite z:2 tag:kBugShiny];
    }

    NSArray *levels = [[[[BTHopshopManager sharedHopshopManager] hopshopDetails] bugUpgrades] objectForKey:[bugClass_ description]];
    
    NSDictionary *levelInfo = [levels objectAtIndex:level];
    NSNumber *price = (NSNumber *)[levelInfo objectForKey:@"Price"];
    NSString *description = (NSString *)[levelInfo objectForKey:@"Description"];
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    CCLabelTTF *priceLabel = [CCLabelTTF labelWithString:[numberFormatter stringFromNumber:price] dimensions:CGSizeMake(150, 38) alignment:UITextAlignmentRight fontName:@"soupofjustice" fontSize:36];
    priceLabel.position = ccp(275, 42);
    [self addChild:priceLabel z:1 tag:kPrice];
    [numberFormatter release];
    
    CCLabelTTF *descriptionLabel = [CCLabelTTF labelWithString:description dimensions:CGSizeMake(350, 100) alignment:UITextAlignmentLeft lineBreakMode:UILineBreakModeWordWrap fontName:@"Marker Felt" fontSize:18];
    descriptionLabel.position = ccp(260, 100);
    [self addChild:descriptionLabel z:1 tag:kDescription];
    
    CCMenuItemSprite *buyButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"buy-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"buy-pressed.png"] block:^(id sender){
        if ([[BTHopshopManager sharedHopshopManager] flyTokens] >= [price intValue]){
            // Spend the money
            [[BTHopshopManager sharedHopshopManager] spendFlyTokens:[price intValue]];
            [FlurryAnalytics logEvent:@"Purchased Bug Upgrade" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@", [bugClass_ description]], @"Name", [NSString stringWithFormat:@"%d", level], @"Level", nil]];

            // Get the thing
            [[BTHopshopManager sharedHopshopManager] setLevel:MIN(level, 4) ForBug:bugClass_];
            // Make the noise
            [[SimpleAudioEngine sharedEngine] playEffect:@"BuyInStore.m4a"];
            // Set Just Unlocked!
            [BTStorageManager setJustUnlocked:YES ForTag:[bugClass_ description]];
            
            // Leaps!
            NSString *purchaseIdentifier = [NSString stringWithFormat:@"flyupgrade%d", level];
            [[BTLeapManager sharedManager] itemPurchasedWithIdentifier:purchaseIdentifier PenniesSpent:[price intValue]];
            
            [self setDisplayedLevel:MIN(4, [[BTHopshopManager sharedHopshopManager] levelForBug:bugClass_]+1)];
        } else {
            UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"You don't have enough Fly Pennies!" message:nil delegate:nil cancelButtonTitle:@"Darn..." otherButtonTitles: nil] autorelease];
            [alertView show];
            
        }
    }];
    buyButton.position = ccp(420, 40);
    [menu addChild:buyButton];
    
    if (level > currentLevel + 1){
        buyButton.isEnabled = NO;
        CCSprite *lockSprite = [CCSprite spriteWithSpriteFrameName:@"locked.png"];
        lockSprite.position = ccp(420, 60);
        [self addChild:lockSprite z:2 tag:kLock];
    } else if (currentLevel >= level){
        buyButton.isEnabled = NO;
        CCSprite *ownedSprite = [CCSprite spriteWithSpriteFrameName:@"You-own-it.png"];
        ownedSprite.position = ccp(420, 45);
        [self addChild:ownedSprite z:2 tag:kLock];
    } else if ([price intValue] > [[BTHopshopManager sharedHopshopManager] flyTokens]){
        buyButton.isEnabled = NO;
        CCSprite *cantAffordSprite = [CCSprite spriteWithSpriteFrameName:@"not-enough-FPs.png"];
        cantAffordSprite.position = ccp(420, 45);
        cantAffordSprite.scale = 0.60;
        [self addChild:cantAffordSprite z:2 tag:kLock];
    }
    
    CCMenuItemSprite *exit = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"]selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
        [upgradeSelectLayer_ returnToProminence];
        [self removeFromParent];
    }];
    exit.position = ccp(50, 35);
    [menu addChild:exit];
}
                                   
@end
