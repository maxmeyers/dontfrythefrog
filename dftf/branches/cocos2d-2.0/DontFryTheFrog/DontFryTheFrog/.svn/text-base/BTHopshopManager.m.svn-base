//
//  BTHopshopManager.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/24/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTHopshopManager.h"
#import "BTIncludes.h"

@implementation BTHopshopManager

@synthesize flyPennyProducts, otherProducts, flyPennySelectLayer;

- (id) init {
    self = [super init];
    if (self){
        
    }
    return self;
}

+ (id) sharedHopshopManager {
    static BTHopshopManager *sharedHopshopManager;
    @synchronized(self)
    {
        if (!sharedHopshopManager) {
            sharedHopshopManager = [[BTHopshopManager alloc] init];
        }
        return sharedHopshopManager;
    }
}

- (void) reset {
    [self setLevel:0 ForBug:[BTGreenFly class]];
    [self setLevel:0 ForBug:[BTIceBug class]];
    [self setLevel:0 ForBug:[BTFireBug class]];
    [self setLevel:0 ForBug:[BTSickBug class]];
    [self setFlyTokens:0];
}

- (bool) purchaseBugLevel:(int) level ForBug:(Class) bugClass AtTokens:(int) tokens {
    if (level > [self levelForBug:bugClass] && [self spendFlyTokens:tokens]){
        [self setLevel:level ForBug:bugClass];
        return YES;
    }
    return NO;
}
- (bool) purchaseTool:(Class) toolClass AtTokens:(int) tokens {
    if ([self spendFlyTokens:tokens]){
        [self addConsumable:toolClass];
        return YES;
    }
    return NO;
}

- (bool) purchaseBeam:(Class) beamClass AtTokens:(int) tokens {
    if ([self flyTokens] >= tokens){
        
    }
    return NO;
}

- (bool) purchaseBackground:(Class) backgroundClass AtTokens:(int) tokens {
    if ([self flyTokens] >= tokens){
        
    }
    return NO;
}

- (bool) purchaseFlyPennies:(int) flyPennies {

    return NO;
}

- (int) tokensForFliesFried:(int) fliesFried {
    return fliesFried;
}

- (int) flyTokens {
    return [BTStorageManager hopshopTokens];
}

- (void) addFlyTokens:(int) n {
    [self setFlyTokens:[self flyTokens]+n];
}

- (bool) spendFlyTokens:(int) n {
    if ([self flyTokens] >= n){
        [self setFlyTokens:[self flyTokens] - n];
        return YES;
    }
    return NO;
}

- (void) setFlyTokens:(int) n {
    [BTStorageManager setHopshopTokens:n];
}

- (int) levelForBug:(Class) bugClass {
    return [BTStorageManager levelForTag:[bugClass description]];
}

- (void) setLevel:(int) n ForBug:(Class) bugClass {
    [BTStorageManager setLevel:n ForTag:[bugClass description]];
}

// Consumables
- (NSArray *) consumables {
    NSArray *consumableClasses = [NSArray arrayWithObjects:@"BTFoilHat", @"BTPennyFrenzy", @"BTGustOfWind", nil];
    NSMutableArray *consumableArray = [NSMutableArray array];
    for (int i = 0; i < [consumableClasses count]; i++){
        Class tempClass = NSClassFromString([consumableClasses objectAtIndex:i]);
        for (int j = 0; j < [self quantityForConsumable:tempClass]; j++) {
            [consumableArray addObject:[[[tempClass alloc] init] autorelease]];
        }
    }
    return [NSArray arrayWithArray:consumableArray];
}

- (void) consumeConsumable:(Class) c {
    [self setQuantity:MAX(0, [self quantityForConsumable:c]-1) ForConsumable:c];
}

- (void) addConsumable:(Class) c {
    [self setQuantity:[self quantityForConsumable:c]+1 ForConsumable:c];
}

- (int) quantityForConsumable:(Class) c {
    return [BTStorageManager levelForTag:[c description]];
}

- (void) setQuantity:(int) q ForConsumable:(Class) c {
    [BTStorageManager setLevel:q ForTag:[c description]];
}


// StoreKit stuff
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *fails = response.invalidProductIdentifiers;
    for (int i = 0; i < [fails count]; i++){
        NSString *product = (NSString *)[fails objectAtIndex:i];
        NSLog(@"fail: %@", [product description]);
    }
    
    NSMutableArray *flyPennies = [NSMutableArray array];
    NSMutableArray *others = [NSMutableArray array];
    for (SKProduct *product in response.products){
        if ([[product productIdentifier] rangeOfString:@"FP"].location != NSNotFound){
            [flyPennies addObject:product];
        } else {
            [others addObject:product];
        }
    }
    
    self.flyPennyProducts = [NSArray arrayWithArray:flyPennies];
    self.otherProducts = [NSArray arrayWithArray:others];
    
    [request autorelease];
}

- (void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchasing:
                if (flyPennySelectLayer != nil){
                    [[self flyPennySelectLayer] setState:kTransactionProcessing];
                }
                break;
            case SKPaymentTransactionStatePurchased:
                NSLog(@"Payment completed for identifier: %@", transaction.payment.productIdentifier);
                int flyPenniesPurchased = [[transaction.payment.productIdentifier stringByReplacingOccurrencesOfString:@"FP" withString:@""] intValue];
                [self addFlyTokens:flyPenniesPurchased];
                [[SimpleAudioEngine sharedEngine] playEffect:@"BuyCoin.m4a"];
                if (flyPennySelectLayer != nil){
                    [[self flyPennySelectLayer] returnToProminenceWithSuccess:YES];
                    [[self flyPennySelectLayer] setState:kProductsLoaded];
                }
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"Failed Because: %@", transaction.error);
                if (flyPennySelectLayer != nil){
                    [[self flyPennySelectLayer] returnToProminenceWithSuccess:NO];
                    [[self flyPennySelectLayer] setState:kProductsLoaded];
                }
                UIAlertView *failAlert = [[[UIAlertView alloc] initWithTitle:@"Purchase Failed" message:[NSString stringWithFormat:@"You have not been charged. Please try again.\n\nError: %@", transaction.error.localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] autorelease];
                [failAlert show];
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:

            default:
                break;
        }
    }
}

- (void) dealloc {
    if (flyPennyProducts != nil){
        [flyPennyProducts release];
    }
    if (otherProducts != nil){
        [otherProducts release];
    }
    [super dealloc];
}

@end
