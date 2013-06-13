//
//  BTBuyItemLeap.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTBuyItemLeap.h"
#import "BTIncludes.h"

@implementation BTBuyItemLeap

- (void) resetProgress {
    [super resetProgress];
    if ([identifier isEqualToString:@"flyupgrade4"] && quantity > 1){
        if ([[BTHopshopManager sharedHopshopManager] levelForBug:[BTGreenFly class]] >= 4)
            self.progress += 1;
        
        if ([[BTHopshopManager sharedHopshopManager] levelForBug:[BTIceBug class]] >= 4)
            self.progress += 1;
        
        if ([[BTHopshopManager sharedHopshopManager] levelForBug:[BTSickBug class]] >= 4)
            self.progress += 1;
        
        if ([[BTHopshopManager sharedHopshopManager] levelForBug:[BTFireBug class]] >= 4)
            self.progress += 1;
    }
}

- (void) itemPurchasedWithIdentifier:(NSString *)ident PenniesSpent:(int)penniesSpent {
    if ([identifier isEqualToString:@"bugupgrade4"]){
        if ([identifier isEqualToString:ident]){
            self.progress = MIN(quantity, self.progress+1);
        }
    } else if ([identifier isEqualToString:@""] || [ident rangeOfString:identifier].location != NSNotFound){
        self.progress = MIN(quantity, self.progress+1);
    }
}

@end
