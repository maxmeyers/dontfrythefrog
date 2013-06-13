//
//  BTTimeBasedLeap.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTTimeBasedLeap.h"

@implementation BTTimeBasedLeap

- (void) resetProgress {
    [super resetProgress];
    seconds = 0;
}

- (void) addTimeToProgress:(ccTime) time {
    seconds += time;
    if (identifier){
        if ([identifier isEqualToString:@"m"]){
            int minutes = floor(seconds/60);
            if (minutes > self.progress){
                self.progress = MIN(quantity, minutes);
            }
        } else if ([identifier isEqualToString:@"s"]){
            if (floor(seconds) > self.progress){
                self.progress = MIN(quantity, floor(seconds));
            }
        }
    }
}

- (NSString *) progressString { 
    
    int secondsToGo;
    int secondsInQuantity;
    
    if ([identifier isEqualToString:@"m"]){
        secondsToGo = quantity*60 - seconds;
        secondsInQuantity = quantity*60;
    } else if ([identifier isEqualToString:@"s"]){
        secondsToGo = quantity - seconds;
        secondsInQuantity = quantity;
    }
    
    int progressMinutes = MAX(0, floor(secondsToGo/60));
    int progressSeconds = MAX(0, fmod(secondsToGo, 60));
    
    int quantityMinutes = MAX(0, floor(secondsInQuantity/60));
    int quantitySeconds = MAX(0, fmod(secondsInQuantity, 60));
    
    NSString *progressSecondsString = [NSString stringWithFormat:@"%d", progressSeconds];
    if (progressSeconds < 10){
        progressSecondsString = [NSString stringWithFormat:@"0%d", progressSeconds];
    }
    
    NSString *quantitySecondsString = [NSString stringWithFormat:@"%d", quantitySeconds];
    if (quantitySeconds < 10){
        quantitySecondsString = [NSString stringWithFormat:@"0%d", quantitySeconds];
    }
    
    return [NSString stringWithFormat:@"%d:%@ of %d:%@ to go!", progressMinutes, progressSecondsString, quantityMinutes, quantitySecondsString];
}

@end
