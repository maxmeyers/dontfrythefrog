//
//  BTOrder.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 7/9/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTOrder.h"

#define kOrderQuantity @"Quantity"
#define kOrderType @"Type"
#define kOrderTime @"Time"
#define kOrderReceived @"Received"

@implementation BTOrder

@synthesize quantity, type, time, received;

- (id)initWithQuantity:(int) n Type:(NSString *) c Time:(ccTime) t {
    if (( self = [super init])) {
        self.quantity = n;
        self.type = c;
        self.time = t;
        self.received = NO;
    }
    return self;
}

- (id) initWithDictionary:(NSDictionary *) dictionary {
    int n = 0;
    ccTime t = 0;
    NSString *ty = @"BTFly";
    
    if ([dictionary objectForKey:@"Number"] != nil){
        n = [(NSNumber *)[dictionary objectForKey:@"Number"] intValue];
    }
    
    if ([dictionary objectForKey:@"Time"] != nil){
        t = [(NSNumber *)[dictionary objectForKey:@"Time"] floatValue];
    }

    if ([dictionary objectForKey:@"Class"] != nil){
        ty = (NSString *)[dictionary objectForKey:@"Class"];
    }
    
    return [self initWithQuantity:n Type:ty Time:t];
}

- (Class) bugType {
    if (![BTStorageManager isUnlocked:NSClassFromString(type)]){
        NSLog(@"Type %@ not unlocked.", [type description]);
        return nil;
    }
    return NSClassFromString(type);
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    NSString *tempClass = @"BTFly";
    if ([aDecoder decodeObjectForKey:kOrderType] != nil){
        tempClass = [aDecoder decodeObjectForKey:kOrderType];
    }
    
    
    self = [self initWithQuantity:[aDecoder decodeIntForKey:kOrderQuantity] Type:tempClass Time:[aDecoder decodeFloatForKey:kOrderTime]];
    if (self){
        received = [aDecoder decodeBoolForKey:kOrderReceived];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:quantity forKey:kOrderQuantity];
    [aCoder encodeObject:type forKey:kOrderType];
    [aCoder encodeFloat:time forKey:kOrderTime];
    [aCoder encodeBool:received forKey:kOrderReceived];
}

@end

#define kRandomOrderQuantityLow @"Quantity Low"
#define kRandomOrderQuantityHigh @"Quantity High"
#define kRandomOrderTypes @"Types"

@implementation BTRandomOrder

- (id) initWithQuantityLow:(int) low QuantityHigh:(int) high CumulativeTypes:(NSDictionary *) dict Time:(ccTime) t {
    if ((self = [super init])){
        quantityLow = low;
        quantityHigh = high;
        time = t;
        types = [dict retain];
    }
    return self;
}

- (id) initWithQuantityLow:(int) low QuantityHigh:(int) high RawTypes:(NSDictionary *) dict Time:(ccTime) t {
    NSMutableDictionary *tempDict = [[NSMutableDictionary new] autorelease];
    int runningTotal = 0;
    
    NSArray *keys = [dict allKeys];
    for (int i = 0; i < [keys count]; i++) {
        NSNumber *num = [NSNumber numberWithFloat:runningTotal + 100*[(NSNumber *)[dict objectForKey:[keys objectAtIndex:i]] floatValue]];
        runningTotal = [num floatValue];
        [tempDict setObject:[keys objectAtIndex:i] forKey:num];
    }    
    
    return [self initWithQuantityLow:low QuantityHigh:high CumulativeTypes:tempDict Time:t];
}

- (id) initWithDictionary:(NSDictionary *)dictionary Types:(NSDictionary *) dict {
    int min = 0;
    int max = 0;
    ccTime t = 0;
    
    if ([dictionary objectForKey:@"Minimum"] != nil){
        min = [(NSNumber *)[dictionary objectForKey:@"Minimum"] floatValue];
    }
    
    if ([dictionary objectForKey:@"Maximum"] != nil){
        max = [(NSNumber *)[dictionary objectForKey:@"Maximum"] floatValue];
    }
    
    if ([dictionary objectForKey:@"Time"] != nil){
        t = [(NSNumber *)[dictionary objectForKey:@"Time"] floatValue];
    }
    
    return [self initWithQuantityLow:min QuantityHigh:max RawTypes:dict Time:t];
}

- (int) quantity {
    int q = arc4random()%(quantityHigh-quantityLow+1)+quantityLow;

    return q;
}

- (Class) bugType {
    NSArray *probabilities = [[types allKeys] sortedArrayUsingComparator: ^(id a, id b) {
        float first = [(NSNumber *)a intValue];
        float second = [(NSNumber *)b intValue];
        
        if ( first < second ) {
            return (NSComparisonResult)NSOrderedAscending;
        } else if ( first > second ) {
            return (NSComparisonResult)NSOrderedDescending;
        } else {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    NSEnumerator *e = [types objectEnumerator];
    Class c;
    bool allLocked = YES;
    while ((c = NSClassFromString((NSString *)[e nextObject]))){
        if ([BTStorageManager isUnlocked:c]){
            allLocked = NO;
        }
    }
    if (allLocked){
        NSLog(@"All bugs in this order are locked.");
        return nil;
    }

    bool foundUnlocked = NO;
    Class theType;
    while (!foundUnlocked){
        float pick = arc4random() % 100;
        for (int i = 0; i < [probabilities count]; i++){
            if (pick < [(NSNumber *)[probabilities objectAtIndex:i] intValue]){
                theType = NSClassFromString([types objectForKey:[probabilities objectAtIndex:i]]);
                if ([BTStorageManager isUnlocked:theType]){
                    foundUnlocked = YES;
                    break; // Stop looking through probabilities.
                }
            }
        }
    }
    return theType;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    int low = [aDecoder decodeIntForKey:kRandomOrderQuantityLow];
    int high = [aDecoder decodeIntForKey:kRandomOrderQuantityHigh];
    NSDictionary *tempTypes = [aDecoder decodeObjectForKey:kRandomOrderTypes];
    int tempTime = [aDecoder decodeFloatForKey:kOrderTime];
    bool tempReceived = [aDecoder decodeBoolForKey:kOrderReceived];
    
    self = [self initWithQuantityLow:low QuantityHigh:high CumulativeTypes:tempTypes Time:tempTime];
    if (self){
        self.received = tempReceived;
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeInt:quantityLow forKey:kRandomOrderQuantityLow];
    [aCoder encodeInt:quantityHigh forKey:kRandomOrderQuantityHigh];
    [aCoder encodeObject:types forKey:kRandomOrderTypes];
}

- (void) dealloc {
    [types release];
    [super dealloc];
}

@end