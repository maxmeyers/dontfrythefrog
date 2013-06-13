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

@class BTFlyPennySelectLayer, BTToolPurchaseLayer, BTHopshopDetails;

@interface BTHopshopManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    BTHopshopDetails *hopshopDetails;
    NSArray *flyPennyProducts;
    NSArray *otherProducts;
    
    BTFlyPennySelectLayer *flyPennySelectLayer;
}

@property (nonatomic, assign) BTHopshopDetails *hopshopDetails;
@property (nonatomic, retain) NSArray *flyPennyProducts;
@property (nonatomic, retain) NSArray *otherProducts;

@property (nonatomic, assign) BTFlyPennySelectLayer *flyPennySelectLayer;
@property (nonatomic, assign) BTToolPurchaseLayer *toolPurchaseLayer;

+ (id) sharedHopshopManager;

- (void) reset;

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
