//
//  BTOrder.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 7/9/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTIncludes.h"

@interface BTOrder : NSObject <NSCoding> {
    int quantity;
    NSString *type;
    
    ccTime time;
    bool received;
}

@property int quantity;
@property (nonatomic, retain) NSString *type;
@property ccTime time;
@property bool received;

- (id) initWithQuantity:(int) n Type:(NSString *) c Time:(ccTime) t;
- (id) initWithDictionary:(NSDictionary *) dictionary;

- (Class) bugType;

@end

@interface BTRandomOrder : BTOrder {
    int quantityLow;
    int quantityHigh;
    
    NSDictionary *types;
}

- (id) initWithQuantityLow:(int) low QuantityHigh:(int) high CumulativeTypes:(NSDictionary *) dict Time:(ccTime) t;
- (id) initWithQuantityLow:(int) low QuantityHigh:(int) high RawTypes:(NSDictionary *) dict Time:(ccTime) t;
- (id) initWithDictionary:(NSDictionary *)dictionary Types:(NSDictionary *) dict;

@end