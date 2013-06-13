//
//  BTLeap.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface BTLeap : NSObject <NSCoding> {
    NSString *name;
    int progress_;
    int reward;
    NSString *description;

    int quantity;
    NSString *bugClass;
    NSString *timePeriod;
    bool dictionaryNeeded;
    NSString *identifier;
    
    NSString *otherClass; // optional
}

@property int reward;

@property int quantity;
@property int progress;

@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *timePeriod;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *otherClass;

- (id) initWithQuantity:(int) q BugClass:(NSString *) c TimePeriod:(NSString *) t DictionaryNeeded:(bool) dict Identifier:(NSString *) ident Reward:(int) r Description:(NSString *) desc;
- (void) resetProgress;
- (bool) achieved;
- (NSString *) descriptionString;
- (NSString *) progressString;

- (void) bugFriedOfClass:(Class) c;
- (void) stuckBugFriedOfClass:(Class) c;
- (void) bugEatenOfClass:(Class) c;
- (void) frogFriedAtTime:(ccTime) time;
- (void) frogExplodedAtTime:(ccTime) time;
- (void) beamBonusFullForTime:(ccTime) time;
- (void) fingersDownForTime:(ccTime) time;
- (void) gamePlayedForTime:(ccTime) time;
- (void) gameEndedWithKillDictionary:(NSDictionary *) dictionary;
- (void) itemPurchasedWithIdentifier:(NSString *) identifier PenniesSpent:(int) penniesSpent;

@end
