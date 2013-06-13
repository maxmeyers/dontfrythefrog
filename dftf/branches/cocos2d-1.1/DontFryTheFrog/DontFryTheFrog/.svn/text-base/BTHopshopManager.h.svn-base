//
//  BTHopshopManager.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/24/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@class BTTool;

@class BTFlyPennySelectLayer;

@interface BTHopshopManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    NSArray *flyPennyProducts;
    NSArray *otherProducts;
    
    BTFlyPennySelectLayer *flyPennySelectLayer;
}

@property (nonatomic, retain) NSArray *flyPennyProducts;
@property (nonatomic, retain) NSArray *otherProducts;

@property (nonatomic, assign) BTFlyPennySelectLayer *flyPennySelectLayer;

+ (id) sharedHopshopManager;

- (void) reset;

// Purchases
- (bool) purchaseBugLevel:(int) level ForBug:(Class) bugClass AtTokens:(int) tokens;
- (bool) purchaseTool:(Class) toolClass AtTokens:(int) tokens;
- (bool) purchaseBeam:(Class) beamClass AtTokens:(int) tokens;
- (bool) purchaseBackground:(Class) backgroundClass AtTokens:(int) tokens;
- (bool) purchaseFlyPennies:(int) flyPennies;

// Fly Pennies
- (int) tokensForFliesFried:(int) fliesFried; // Fly Penny Conversion
- (int) flyTokens;
- (void) addFlyTokens:(int) n;
- (bool) spendFlyTokens:(int) n;
- (void) setFlyTokens:(int) n;

// Bug Upgrades
- (int) levelForBug:(Class) bugClass;
- (void) setLevel:(int) n ForBug:(Class) bugClass;

// Consumables
- (NSArray *) consumables;
- (void) consumeConsumable:(Class) c;
- (void) addConsumable:(Class) c;
- (int) quantityForConsumable:(Class) c;
- (void) setQuantity:(int) q ForConsumable:(Class) c;

@end
