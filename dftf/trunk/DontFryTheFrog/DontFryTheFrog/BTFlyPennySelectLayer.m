//
//  BTBackgroundSelectLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTFlyPennySelectLayer.h"
#import "BTIncludes.h"

#define kExitMenu 6
#define kOverlay 7
#define kBigWords 8

#define kDescription 15
#define kMenu 16
#define kPrice 17
#define kLock 18
#define kTitle 19

@implementation BTFlyPennySelectLayer

@synthesize state;

- (id) initWithHopshopLayer:(BTHopshopLayer *)hopshop {
    self = [super init];
    if (self){
        
        hopshopLayer_ = hopshop;        
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"purchase-box.png"];
        background.position = ccp(240, 160);
        [self addChild:background z:0 tag:4];
        
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        NSString *string = @"";
        if ([reachability currentReachabilityStatus] != NotReachable){
            string = @"Stocking the Shelves...";
            state = kProductsNotLoaded;
        } else {
            string = @"No Network Connection\n:-(";
            state = kNoInternetConnection;
        }
        CCLabelTTF *loadingLabel = [CCLabelTTF labelWithString:string dimensions:CGSizeMake(300, 150) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:50];
        loadingLabel.position = ccp(240, 160);
        loadingLabel.color = ccc3(153, 0, 0);
        [self addChild:loadingLabel z:2 tag:kBigWords];
        
        CCSprite *title = [CCSprite spriteWithSpriteFrameName:@"FP-title.png"];
        title.position = ccp(240, 282);
        [self addChild:title z:1 tag:5];
        
        CCMenu *menu = [CCMenu menuWithItems:nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:2 tag:kExitMenu];
        
        CCMenuItemSprite *exit = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"]selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
            [hopshopLayer_ returnToProminence];
            [self removeFromParent];
        }];
        exit.position = ccp(50, 35);
        [menu addChild:exit];

        
        [self scheduleUpdate];
    }
    return self;
}

- (void) update:(ccTime) dt {
    if (state == kProductsNotLoaded){
        if ([[BTHopshopManager sharedHopshopManager] flyPennyProducts] != nil && [[[BTHopshopManager sharedHopshopManager] flyPennyProducts] count] > 0){
            [self removeChildByTag:kBigWords cleanup:YES];
            [self displayJar:1];
            state = kProductsLoaded;
        } else {
            if ([SKPaymentQueue canMakePayments]){
                SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects: @"FP5000", @"FP10500", @"FP16500", @"FP28000", @"FP70000", @"PENNY.PYRAMID", nil]];
                request.delegate = [BTHopshopManager sharedHopshopManager];
                [request start];
            }
        }
    } else if (state == kProductsLoaded){
        
    } else if (state == kWaitingToPurchase){
        
    } else if (state == kTransactionProcessing){
        
    }
}

- (void) displayJar:(int) jarLevel {
    
    // If they're there, get rid of the old thing
    for (int i = kDescription; i <= kTitle; i++){
        if ([self getChildByTag:i] != nil){
            [self removeChildByTag:i cleanup:YES];
        }
    }
    
    CCMenu *menu = [CCMenu menuWithItems:nil];
    menu.position = ccp(0, 0);
    [self addChild:menu z:2 tag:kMenu];

    for (int i = 1; i <= 5; i++){
        NSString *pressed = [NSString stringWithFormat:@"FP-size-%d-unpressed.png", i];
        NSString *unpressed = [NSString stringWithFormat:@"FP-size-%d-pressed.png", i];
        if (jarLevel == i){
            unpressed = pressed;
        }
        
        CCMenuItemSprite *jar = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:unpressed] selectedSprite:[CCSprite spriteWithSpriteFrameName:pressed] block:^(id sender){
            if (state == kProductsLoaded){
                [self displayJar:i];
            }
        }];
        
        if (i == jarLevel){
            jar.isEnabled = NO;
        }

        // I couldn't figure out a neat formula for the position, so here it is.
        if (i == 1){
            jar.position = ccp(105, 215);
        } else if (i == 2){
            jar.position = ccp(160, 215);
        } else if (i == 3){
            jar.position = ccp(230, 215);
        } else if (i == 4){
            jar.position = ccp(310, 215);
        } else if (i == 5){
            jar.position = ccp(400, 215);
        }
        
        [menu addChild:jar];
    }
    
    NSArray *products = [[[BTHopshopManager sharedHopshopManager] flyPennyProducts] sortedArrayUsingComparator: ^(id a, id b){
        SKProduct *productA = a;
        SKProduct *productB = b;
        int flyPenniesA = [[productA.productIdentifier stringByReplacingOccurrencesOfString:@"FP" withString:@""] intValue];
        int flyPenniesB = [[productB.productIdentifier stringByReplacingOccurrencesOfString:@"FP" withString:@""] intValue];
        
        if ( flyPenniesA < flyPenniesB ) {
            return (NSComparisonResult)NSOrderedAscending;
        } else if ( flyPenniesA > flyPenniesB ) {
            return (NSComparisonResult)NSOrderedDescending;
        } else {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    if (jarLevel - 1 < [products count]) {
        SKProduct *product = [products objectAtIndex:jarLevel-1];
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setLocale:product.priceLocale];
        NSString *localizedPrice = [numberFormatter stringFromNumber:product.price];
        
        CCLabelTTF *priceLabel = [CCLabelTTF labelWithString:localizedPrice dimensions:CGSizeMake(150, 38) alignment:UITextAlignmentRight fontName:@"Marker Felt" fontSize:36];
        priceLabel.position = ccp(275, 45);
        [self addChild:priceLabel z:1 tag:kPrice];
        
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        int pennies = [[[product productIdentifier] stringByReplacingOccurrencesOfString:@"FP" withString:@""] intValue];
        
        CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@\n(%@)", product.localizedTitle, [numberFormatter stringFromNumber:[NSNumber numberWithInt:pennies]]] dimensions:CGSizeMake(350, 50) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"Marker Felt" fontSize:22];
        titleLabel.position = ccp(260, 140);
        [self addChild:titleLabel z:1 tag:kTitle];
        
        CCLabelTTF *descriptionLabel = [CCLabelTTF labelWithString:product.localizedDescription dimensions:CGSizeMake(325, 66) alignment:UITextAlignmentLeft lineBreakMode:UILineBreakModeWordWrap fontName:@"Marker Felt" fontSize:18];
        descriptionLabel.position = ccp(260, 80);
        [self addChild:descriptionLabel z:1 tag:kDescription];
        
        CCMenuItemSprite *buyButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"buy-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"buy-pressed.png"] block:^(id sender){
            if ([SKPaymentQueue canMakePayments]){
                [[BTHopshopManager sharedHopshopManager] setFlyPennySelectLayer:self];

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
                [self setState:kWaitingToPurchase];
            } else {
                UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"In-App Purchases Disabled" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] autorelease];
                [alertView show];
            }
        }];
        buyButton.position = ccp(420, 40);
        [menu addChild:buyButton];
        
        if (![SKPaymentQueue canMakePayments]){
            buyButton.isEnabled = NO;
            CCSprite *lockSprite = [CCSprite spriteWithSpriteFrameName:@"locked.png"];
            lockSprite.position = ccp(420, 60);
            [self addChild:lockSprite z:3 tag:kLock];
        }
    }
    
}

- (void) lostProminence {
    if ([self getChildByTag:kMenu] != nil){
        [(CCMenu *)[self getChildByTag:kMenu] setIsTouchEnabled:NO];
    }
    
    if ([self getChildByTag:kExitMenu] != nil){
        [(CCMenu *)[self getChildByTag:kExitMenu] setIsTouchEnabled:NO];
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
        
        if ([self getChildByTag:kExitMenu] != nil){
            [(CCMenu *)[self getChildByTag:kExitMenu] setIsTouchEnabled:YES];
        }
        
        while ([self getChildByTag:kOverlay] != nil){
            [self removeChildByTag:kOverlay cleanup:YES];
        }
    }];
    
    state = kProductsLoaded;
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.5], returnToProminence, nil]];
    [[BTHopshopManager sharedHopshopManager] setFlyPennySelectLayer:nil];

}

- (void) dealloc {
    [[BTHopshopManager sharedHopshopManager] setFlyPennySelectLayer:nil];
    [super dealloc];
}

@end
