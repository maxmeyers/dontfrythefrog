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

@synthesize hopshopDetails, flyPennyProducts, otherProducts, flyPennySelectLayer, toolPurchaseLayer;

- (id) init {
    self = [super init];
    if (self){
        if ([[BTConfig sharedConfig] readFromPlist]){
            self.hopshopDetails = [[BTHopshopDetails alloc] init];
            [NSKeyedArchiver archiveRootObject:self.hopshopDetails toFile:@"/Users/mmeyers/Desktop/HopshopDetails.bin"];
        } else {
            self.hopshopDetails = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"HopshopDetails" ofType:@"bin"]] retain];
        }
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
    [BTStorageManager setLevel:0 ForTag:@"PENNY.PYRAMID"];
    [self setQuantity:0 ForConsumable:[BTFoilHat class]];
    [self setQuantity:0 ForConsumable:[BTPennyFrenzy class]];
    [self setQuantity:0 ForConsumable:[BTBugSpray class]];
    [self setFlyTokens:0];
    
}

- (int) tokensForFliesFried:(int) fliesFried {
    return fliesFried;
}

- (int) flyTokens {
    return [BTStorageManager hopshopTokens];
}

- (void) addFlyTokens:(int) n {
    [BTStorageManager addHopshopTokens:n];
}

- (bool) spendFlyTokens:(int) n {
    if ([self flyTokens] >= n){
        [FlurryAnalytics logEvent:@"Spent Tokens" withParameters:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", n] forKey:@"Number"]];
        [self setFlyTokens:[self flyTokens] - n];
        [[BTStatsManager sharedManager] setFlyPenniesSpent:[[BTStatsManager sharedManager] flyPenniesSpent] + n];
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
    NSArray *consumableClasses = [NSArray arrayWithObjects:@"BTFoilHat", @"BTPennyFrenzy", @"BTBugSpray", nil];
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
            NSLog(@"Other: %@", [product productIdentifier]);
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
                NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
                dateFormatter.dateStyle = NSDateFormatterShortStyle;
                if([transaction.payment.productIdentifier rangeOfString:@"FP"].location != NSNotFound){
                    int flyPenniesPurchased = [[transaction.payment.productIdentifier stringByReplacingOccurrencesOfString:@"FP" withString:@""] intValue];
                    [self addFlyTokens:flyPenniesPurchased];
                    if ([BTStorageManager levelForTag:@"EverSpentMoney"] == 0){
                        [BTStorageManager setLevel:1 ForTag:@"EverSpentMoney"];
                        [FlurryAnalytics logEvent:@"Spent Money for First Time" withParameters:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d Pennies", flyPenniesPurchased] forKey:@"Item"]];         
                    }
                    [FlurryAnalytics logEvent:@"Purchased Tokens" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", flyPenniesPurchased],@"Number", [dateFormatter stringFromDate:[NSDate date]], @"Date", nil]];
                    [FlurryAnalytics setGender:@"f"];
                    [[SimpleAudioEngine sharedEngine] playEffect:@"BuyCoin.m4a"];
                    if (flyPennySelectLayer != nil){
                        [[self flyPennySelectLayer] returnToProminenceWithSuccess:YES];
                        [[self flyPennySelectLayer] setState:kProductsLoaded];
                    }
                } else if ([transaction.payment.productIdentifier isEqualToString:@"PENNY.PYRAMID"]){
                    [BTStorageManager setLevel:1 ForTag:@"PENNY.PYRAMID"];
                    if ([BTStorageManager levelForTag:@"EverSpentMoney"] == 0){
                        [BTStorageManager setLevel:1 ForTag:@"EverSpentMoney"];
                        [FlurryAnalytics logEvent:@"Spent Money for First Time" withParameters:[NSDictionary dictionaryWithObject:@"Penny Pyramid" forKey:@"Item"]];         
                    }
                    [FlurryAnalytics logEvent:@"Purchased Penny Pyramid" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:[dateFormatter stringFromDate:[NSDate date]], @"Date", nil]];  
                    [FlurryAnalytics setGender:@"f"];
                    if (toolPurchaseLayer != nil){
                        [[self toolPurchaseLayer] returnToProminenceWithSuccess:YES];
                    }
                }
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"Failed Because: %@", transaction.error);
                if (flyPennySelectLayer != nil){
                    [[self flyPennySelectLayer] returnToProminenceWithSuccess:NO];
                    [[self flyPennySelectLayer] setState:kProductsLoaded];
                } else if ([transaction.payment.productIdentifier isEqualToString:@"PENNY.PYRAMID"]){
                    if (toolPurchaseLayer != nil){
                        [[self toolPurchaseLayer] returnToProminenceWithSuccess:NO];
                    }
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
