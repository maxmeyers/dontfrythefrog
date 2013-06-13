//
//  BTBackgroundSelectLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTToolSelectLayer.h"
#import "BTIncludes.h"

#define kToolBackgroundTag 10
#define kToolTitleTag 11
#define kToolMenuTag 12
#define kBugSpraySelectTag 13
#define kFoilHatSelectTag 14
#define kPennyFrenzySelectTag 15
#define kShuffleSelectTag 16

#define kFoilHatLabelTag 17
#define kBugSprayLabelTag 18
#define kPennyFrenzyLabelTag 19
#define kShuffleLabelTag 20


@implementation BTToolSelectLayer

@synthesize hopshopLayer = hopshopLayer_;

- (id) initWithHopshopLayer:(BTHopshopLayer *)hopshop {
    self = [super init];
    if (self){
        
        hopshopLayer_ = hopshop;        
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"select.png"];
        background.position = ccp(240, 160);
        [self addChild:background z:0 tag:kToolBackgroundTag];
        
        CCSprite *title = [CCSprite spriteWithSpriteFrameName:@"tool-title.png"];
        title.position = ccp(240, 282);
        [self addChild:title z:1 tag:kToolTitleTag];
        
        CCMenuItemSprite *foilHatMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"foil-hat-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"foil-hat-pressed.png"] block:^(id sender){
            [self lostProminence];
            [self addChild:[[[BTToolPurchaseLayer alloc] initWithToolSelectLayer:self Tool:[BTFoilHat class]] autorelease] z:0];                                               
        }];
        foilHatMenuItem.position = ccp(145, 200);
        foilHatMenuItem.tag = kFoilHatSelectTag;
        
        CCLabelTTF *foilHatLabel = [CCLabelTTF labelWithString:@"Foil Hat" fontName:@"soupofjustice" fontSize:20];
        foilHatLabel.position = ccp(150, 155);
        [self addChild:foilHatLabel z:3 tag:kFoilHatLabelTag];
        
        CCMenuItemSprite *bugSprayMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"bug-spray-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"bug-spray-pressed.png"] block:^(id sender){
            [self lostProminence];
            [self addChild:[[[BTToolPurchaseLayer alloc] initWithToolSelectLayer:self Tool:[BTBugSpray class]] autorelease] z:0];   
        }];
        bugSprayMenuItem.position = ccp(145, 90);
        bugSprayMenuItem.tag = kBugSpraySelectTag;
        
        CCLabelTTF *bugSprayLabel = [CCLabelTTF labelWithString:@"Bug Spray" fontName:@"soupofjustice" fontSize:20];
        bugSprayLabel.position = ccp(150, 45);
        [self addChild:bugSprayLabel z:3 tag:kBugSprayLabelTag];
        
        CCMenuItemSprite *pennyFrenzyMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"Frenzy-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"Frenzy-pressed.png"] block:^(id sender){
            [self lostProminence];
            [self addChild:[[[BTToolPurchaseLayer alloc] initWithToolSelectLayer:self Tool:[BTPennyFrenzy class]] autorelease] z:0];   
        }];
        pennyFrenzyMenuItem.position = ccp(328, 205);
        pennyFrenzyMenuItem.tag = kPennyFrenzySelectTag;
        pennyFrenzyMenuItem.scale = .65;
        
        CCLabelTTF *pennyFrenzyLabel = [CCLabelTTF labelWithString:@"Penny Frenzy" fontName:@"soupofjustice" fontSize:20];
        pennyFrenzyLabel.position = ccp(333, 155);
        [self addChild:pennyFrenzyLabel z:3 tag:kPennyFrenzyLabelTag];
        
        CCMenuItemSprite *missionShuffleMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"mission-shuffle-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"mission-shuffle-pressed.png"] block:^(id sender){
            [self lostProminence];
            [self addChild:[[[BTToolPurchaseLayer alloc] initWithToolSelectLayer:self Tool:[BTTool class]] autorelease] z:0];
        }];
        missionShuffleMenuItem.position = ccp(328, 90);
        missionShuffleMenuItem.tag = kShuffleSelectTag;
        
        CCLabelTTF *missionShuffleLabel = [CCLabelTTF labelWithString:@"Mission Shuffle" fontName:@"soupofjustice" fontSize:20];
        missionShuffleLabel.position = ccp(333, 45);
        [self addChild:missionShuffleLabel z:3 tag:kShuffleLabelTag];
        
        CCMenuItemSprite *exit = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"]selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
            [hopshopLayer_ returnToProminence];
            [self removeFromParent];
        }];
        exit.position = ccp(50, 35);
        
        CCMenu *menu = [CCMenu menuWithItems:foilHatMenuItem, bugSprayMenuItem, pennyFrenzyMenuItem, missionShuffleMenuItem, exit, nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:2 tag:kToolMenuTag];
    }
    return self;
}

- (void) lostProminence {
    [(CCMenu *)[self getChildByTag:kToolMenuTag] setIsTouchEnabled:NO];
    for (int i = kToolBackgroundTag; i <= kShuffleLabelTag; i++){
        [self getChildByTag:i].visible = NO;
    }
}

- (void) returnToProminence {
    [(CCMenu *)[self getChildByTag:kToolMenuTag] setIsTouchEnabled:YES];    
    for (int i = kToolBackgroundTag; i <= kShuffleLabelTag; i++){
        [self getChildByTag:i].visible = YES;
    }
}

@end

#define kOwned 14
#define kDescription 15
#define kMenu 16
#define kPrice 17
#define kLock 18
#define kAura 19

@implementation BTToolPurchaseLayer

- (id) initWithToolSelectLayer:(BTToolSelectLayer *) toolSelectLayer Tool:(Class) toolClass {
    self = [super init];
    if (self){
        toolSelectLayer_ = toolSelectLayer;
        toolClass_ = toolClass;
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"purchase-box.png"];
        background.position = ccp(240, 160);
        [self addChild:background z:0 tag:kToolBackgroundTag];
        
        CCSprite *title = [CCSprite spriteWithSpriteFrameName:[toolClass_ titleFileString]];
        title.position = ccp(240, 282);
        [self addChild:title z:1 tag:kToolTitleTag];
        
        [self setDisplayedLevel:1];

    }
    
    return self;
}

- (void) setDisplayedLevel:(int) level {
    for (int i = kOwned; i <= kAura; i++){
        if ([self getChildByTag:i] != nil){
            [self removeChildByTag:i cleanup:YES];
        }
    }
    
    CCMenu *menu = [CCMenu menuWithItems:nil];
    menu.position = ccp(0,0);
    [self addChild:menu z:1 tag:kMenu];
    CCMenuItemSprite *exit = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"]selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
        [toolSelectLayer_ returnToProminence];
        [self removeFromParent];
    }];
    exit.position = ccp(50, 35);
    [menu addChild:exit];
    
    NSArray *levels = [[[[BTHopshopManager sharedHopshopManager] hopshopDetails] tools] objectForKey:[toolClass_ description]];
    NSDictionary *levelInfo = [levels objectAtIndex:level];
    if (![levelInfo objectForKey:@"Price"]){
        return;
    }
    
    NSNumber *price = (NSNumber *)[levelInfo objectForKey:@"Price"];
    int count = [(NSNumber *)[levelInfo objectForKey:@"Count"] intValue];
    NSString *description = (NSString *)[levelInfo objectForKey:@"Description"];
    

    for (int i = 1; i <= 5; i += 1){
        NSDictionary *itemInfo = (NSDictionary *)[levels objectAtIndex:i];
        if ([itemInfo objectForKey:@"Price"]){
            int itemCount = [(NSNumber *)[itemInfo objectForKey:@"Count"] intValue];
            
            NSString *fileName = [NSString stringWithFormat:@"%d%@", itemCount, [toolClass_ menuImageSuffix]];

            if ([itemInfo objectForKey:@"Image"]){
                fileName = [itemInfo objectForKey:@"Image"];
            }

            if (![fileName isEqualToString:@""]){
                int x = -240;
                if (i == 1){
                    x = 100;
                } else if (i == 2){
                    x = 190;
                } else if (i == 3){
                    x = 280;
                } else if (i == 5){
                    x = 400;
                }
                
                CCMenuItemSprite *levelButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:fileName] selectedSprite:[CCSprite spriteWithSpriteFrameName:fileName] block:^(id sender){
                    [self setDisplayedLevel:i];
                }];
                levelButton.position = ccp(x, 215);
                [menu addChild:levelButton];
                
                if (i == level){
                    CCSprite *aura = [CCSprite spriteWithSpriteFrameName:@"pressed-underlay.png"];
                    aura.position = levelButton.position;
                    [self addChild:aura z:0 tag:kAura];
                }
            }
        }
    }
    
    __block SKProduct *product = nil;
    if (toolClass_ == [BTPennyFrenzy class] && level == 5){
        for (SKProduct *tempProduct in [[BTHopshopManager sharedHopshopManager] otherProducts]){
            if ([[tempProduct productIdentifier] isEqualToString:@"PENNY.PYRAMID"]){
                product = tempProduct;
            }
        }
    }
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    NSString *priceString;
    NSString *font = @"soupofjustice";
    if (product){
        font = @"Marker Felt";
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setLocale:product.priceLocale];
        priceString = [numberFormatter stringFromNumber:product.price];
    } else {
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        priceString = [numberFormatter stringFromNumber:price];
    }
    CCLabelTTF *priceLabel = [CCLabelTTF labelWithString:priceString dimensions:CGSizeMake(150, 38) alignment:UITextAlignmentRight fontName:font fontSize:36];
    priceLabel.position = ccp(275, 42);
    [self addChild:priceLabel z:1 tag:kPrice];
    [numberFormatter release];
    
    CCLabelTTF *descriptionLabel = [CCLabelTTF labelWithString:description dimensions:CGSizeMake(350, 100) alignment:UITextAlignmentLeft lineBreakMode:UILineBreakModeWordWrap fontName:@"Marker Felt" fontSize:18];
    descriptionLabel.position = ccp(260, 110);
    [self addChild:descriptionLabel z:1 tag:kDescription];
    
    if (toolClass_ != [BTTool class] && !product){
        CCLabelTTF *ownedLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Owned: %d", [[BTHopshopManager sharedHopshopManager] quantityForConsumable:toolClass_]] fontName:@"soupofjustice" fontSize:36];
        ownedLabel.position = ccp(175, 42);
        [self addChild:ownedLabel z:1 tag:kOwned];
    }

    CCMenuItemSprite *buyButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"buy-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"buy-pressed.png"] block:^(id sender){
        if (product){
            if ([SKPaymentQueue canMakePayments]){
                [[BTHopshopManager sharedHopshopManager] setToolPurchaseLayer:self];

                SKPayment *payment = [SKPayment paymentWithProduct:product];
                [[SKPaymentQueue defaultQueue] addPayment:payment];
                
                CCLayerColor *background = [CCLayerColor layerWithColor:ccc4(89, 89, 89, 230) width:480 height:320];
                [self addChild:background z:3 tag:kWaitingBackground];
                
                CCSprite *zekeWait1 = [CCSprite spriteWithSpriteFrameName:@"zeke-wait-1.png"];
                zekeWait1.position = ccp(130, 125);
                [self addChild:zekeWait1 z:4 tag:kZekeWaiting1];
                
                CCSprite *zekeWait2 = [CCSprite spriteWithSpriteFrameName:@"zeke-wait-2.png"];
                zekeWait2.position = ccp(130, 125);
                zekeWait2.visible = NO;
                [self addChild:zekeWait2 z:4 tag:kZekeWaiting2];
                
                CCSequence *changeZeke = [CCSequence actions:[CCDelayTime actionWithDuration:2.0], [CCCallBlock actionWithBlock:^(void){
                    if ([self getChildByTag:kZekeWaiting1]){
                        [self removeChildByTag:kZekeWaiting1 cleanup:YES];
                    }
                    
                    if ([self getChildByTag:kZekeWaiting2]){
                        [self getChildByTag:kZekeWaiting2].visible = YES;
                    }
                }], nil];
                changeZeke.tag = kChangeZekeTag;
                [self runAction:changeZeke];
                
                CCSprite *pleaseWait = [CCSprite spriteWithSpriteFrameName:@"please-wait.png"];
                pleaseWait.position = ccp(342, 274);
                [self addChild:pleaseWait z:4 tag:kWaitingForTransaction];
                
                CCSprite *thanksForPurchase = [CCSprite spriteWithSpriteFrameName:@"thanks.png"];
                thanksForPurchase.position = ccp(339, 272);
                thanksForPurchase.visible = NO;
                [self addChild:thanksForPurchase z:4 tag:kThanksForPurchase];
                
                [self lostProminence];
            } else {
                UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"In-App Purchases Disabled" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] autorelease];
                [alertView show];
            }

        } else if ([[BTHopshopManager sharedHopshopManager] flyTokens] >= [price intValue]){
            // Spend the money
            [[BTHopshopManager sharedHopshopManager] spendFlyTokens:[price intValue]];

            // Get the thing
            if (toolClass_ == [BTTool class]){
                if (level == 1){
                    [FlurryAnalytics logEvent:@"Purchased Tool Quantity" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:@"Mission Shuffle x1", @"Name", nil]];
                    [[[BTLeapManager sharedManager] currentLeaps] removeAllObjects];
                    [[[BTLeapManager sharedManager] currentLeaps] addObject:[[BTLeapManager sharedManager] newLeap]];
                    [[[BTLeapManager sharedManager] currentLeaps] addObject:[[BTLeapManager sharedManager] newLeap]];
                    [[[BTLeapManager sharedManager] currentLeaps] addObject:[[BTLeapManager sharedManager] newLeap]];
                    [[[toolSelectLayer_ hopshopLayer] hopshopScene] setHasCompletedMission:YES];
                }
            } else {
                [FlurryAnalytics logEvent:@"Purchased Tool Quantity" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@ x%d", [toolClass_ description], count], @"Item", nil]];
                for (int i = 1; i <= count; i++){
                    [[BTHopshopManager sharedHopshopManager] addConsumable:toolClass_];
                }
            }
            // Make the noise
            [[SimpleAudioEngine sharedEngine] playEffect:@"BuyInStore.m4a"];
            
            // Leaps!
            NSString *purchaseIdentifier = [NSString stringWithFormat:@"toolpurchase%d", level];
            [[BTLeapManager sharedManager] itemPurchasedWithIdentifier:purchaseIdentifier PenniesSpent:[price intValue]];
            
            [self setDisplayedLevel:level];
        } else {
            UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"You don't have enough Fly Pennies!" message:nil delegate:nil cancelButtonTitle:@"Darn..." otherButtonTitles: nil] autorelease];
            [alertView show];
            
        }
    }];
    buyButton.position = ccp(420, 40);
    [menu addChild:buyButton];
    
    if ([price intValue] > [[BTHopshopManager sharedHopshopManager] flyTokens]){
        buyButton.isEnabled = NO;
        CCSprite *cantAffordSprite = [CCSprite spriteWithSpriteFrameName:@"not-enough-FPs.png"];
        cantAffordSprite.position = ccp(420, 45);
        cantAffordSprite.scale = 0.60;
        [self addChild:cantAffordSprite z:2 tag:kLock];
    } else if (product != nil && [BTStorageManager levelForTag:@"PENNY.PYRAMID"] != 0){
        buyButton.isEnabled = NO;
        CCSprite *ownedSprite = [CCSprite spriteWithSpriteFrameName:@"You-own-it.png"];
        ownedSprite.position = ccp(420, 45);
        [self addChild:ownedSprite z:2 tag:kLock];
    } else if (toolClass_ == [BTPennyFrenzy class] && level == 5 && product == nil){
        buyButton.isEnabled = NO;
    }
    

}

- (void) lostProminence {
    if ([self getChildByTag:kMenu] != nil){
        [(CCMenu *)[self getChildByTag:kMenu] setIsTouchEnabled:NO];
    }
}

- (void) returnToProminenceWithSuccess:(bool) success {
    [self stopActionByTag:kChangeZekeTag];
    
    if (success){    
        if ([self getChildByTag:kWaitingForTransaction]){
            [self removeChildByTag:kWaitingForTransaction cleanup:YES];
        }
        
        if ([self getChildByTag:kThanksForPurchase]){
            [self getChildByTag:kThanksForPurchase].visible = YES;
        }
    }
    
    CCCallBlock *returnToProminence = [CCCallBlock actionWithBlock:^(void) {
        for (int i = kWaitingBackground; i <= kThanksForPurchase; i++){
            if ([self getChildByTag:i]){
                [self removeChildByTag:i cleanup:YES];
            }
        }
        
        if ([self getChildByTag:kMenu] != nil){
            [(CCMenu *)[self getChildByTag:kMenu] setIsTouchEnabled:YES];
        }
        
    }];
    
    [self setDisplayedLevel:5]; // If there's ever another tool that's paid for with dollars, it either has to be in the 5 slot or this has to change.
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.5], returnToProminence, nil]];
    [[BTHopshopManager sharedHopshopManager] setToolPurchaseLayer:nil];

}


@end