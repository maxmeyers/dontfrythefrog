//
//  BTLeap.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTLeap.h"
#import "BTIncludes.h"

@implementation BTLeap

@synthesize name, description, reward, timePeriod, identifier, otherClass;
@synthesize quantity;

- (id) initWithQuantity:(int) q BugClass:(NSString *) c TimePeriod:(NSString *) t DictionaryNeeded:(bool) dict Identifier:(NSString *) ident Reward:(int) r Description:(NSString *) desc {
    self = [super init];
    if (self){
        quantity = q;
        progress_ = 0;
        bugClass = [c retain];
        self.description = desc;
        self.timePeriod = t;
        dictionaryNeeded = dict;
        self.identifier = ident;
        reward = r;
        otherClass = nil;
    }
    return self;
}

- (void) setProgress:(int)progress {
    // We just got to the maximum
    if (progress != progress_ && progress == quantity){
        // Notify Completion
        [[BTLeapManager sharedManager] notifyCompletionOfLeap:self];
    }
    progress_ = progress;
}

- (int) progress {
    return progress_;
}

- (void) resetProgress {
    self.progress = 0;
    
}

- (bool) achieved {
    if (quantity - progress_ <= 0){
        return YES;
    }
    
    return NO;
}

- (NSString *) descriptionString {
    return [description stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithFormat:@"%d", quantity]];
}

- (NSString *) progressString {
    return [NSString stringWithFormat:@"%d of %d to go!", (quantity - progress_), quantity];
}

- (void) bugFriedOfClass:(Class) c {}
- (void) stuckBugFriedOfClass:(Class) c {}
- (void) bugEatenOfClass:(Class) c {}
- (void) frogFriedAtTime:(ccTime) time {}
- (void) frogExplodedAtTime:(ccTime) time {}
- (void) beamBonusAtLevel:(int) level ForTime:(ccTime) time {}
- (void) beamBonusFullForTime:(ccTime) time {}
- (void) fingersDownForTime:(ccTime) time {}
- (void) gamePlayedForTime:(ccTime) time {}
- (void) gameEndedWithKillDictionary:(NSDictionary *) dictionary {}
- (void) itemPurchasedWithIdentifier:(NSString *) identifier PenniesSpent:(int) penniesSpent {}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [self initWithQuantity:[aDecoder decodeIntForKey:@"Quantity"] BugClass:(NSString *)[aDecoder decodeObjectForKey:@"BugClass"] TimePeriod:(NSString *)[aDecoder decodeObjectForKey:@"TimePeriod"] DictionaryNeeded:[aDecoder decodeBoolForKey:@"DictionaryNeeded"] Identifier:(NSString *)[aDecoder decodeObjectForKey:@"Identifier"] Reward:[aDecoder decodeIntForKey:@"Reward"] Description:(NSString *)[aDecoder decodeObjectForKey:@"Description"]];
    if (self){
        if ([aDecoder decodeObjectForKey:@"OtherClass"]){
            [self setOtherClass:(NSString *)[aDecoder decodeObjectForKey:@"OtherClass"]];
        }
        
        if ([aDecoder decodeObjectForKey:@"Name"]){
            [self setName:(NSString *)[aDecoder decodeObjectForKey:@"Name"]];
        }

        
        progress_ = [aDecoder decodeIntForKey:@"Progress"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:quantity forKey:@"Quantity"];
    [aCoder encodeInt:progress_ forKey:@"Progress"];
    [aCoder encodeObject:[bugClass description] forKey:@"BugClass"];
    [aCoder encodeObject:timePeriod forKey:@"TimePeriod"];
    [aCoder encodeBool:dictionaryNeeded forKey:@"DictionaryNeeded"];
    [aCoder encodeObject:identifier forKey:@"Identifier"];
    [aCoder encodeInt:reward forKey:@"Reward"];
    [aCoder encodeObject:description forKey:@"Description"];
    
    if (name){
        [aCoder encodeObject:name forKey:@"Name"];
    }
    
    if (otherClass){
        [aCoder encodeObject:otherClass forKey:@"OtherClass"];
    }
}

@end
