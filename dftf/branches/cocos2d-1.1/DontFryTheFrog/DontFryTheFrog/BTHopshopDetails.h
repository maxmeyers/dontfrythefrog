//
//  BTHopshopDetails.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTHopshopDetails : NSObject <NSCoding> {
    NSDictionary *bugUpgrades;
}

@property (nonatomic, retain) NSDictionary *bugUpgrades;

@end
