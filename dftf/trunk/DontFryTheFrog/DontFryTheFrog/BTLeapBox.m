//
//  BTLeapBox.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTLeapBox.h"
#import "BTIncludes.h"

@implementation BTLeapBox

@synthesize singleLeaps=singleLeaps_, state=state_;

- (id) initWithState:(tLeapBoxState) state {
    self = [super init];
    if (self){
        state_ = state;
        singleLeaps_ = [[NSMutableArray alloc] init];

        CGPoint backgroundPosition = ccp(330, 125);
        if (state_ == kPauseScreen){
            backgroundPosition = ccp(333, 160);
        }
        
        NSArray *currentLeaps = [[BTLeapManager sharedManager] currentLeaps];
        for (int i = 0; i < 3; i++){
            BTLeap *leap = nil;
            if (i < [currentLeaps count]){
                leap = (BTLeap *)[currentLeaps objectAtIndex:i];
            }
            BTSingleLeap *singleLeap = [[[BTSingleLeap alloc] initWithLeap:leap AtIndex:i+1 WithPosition:ccp(backgroundPosition.x, backgroundPosition.y + (i-1)*-79)] autorelease];
            [singleLeaps_ addObject:singleLeap];
            [self addChild:singleLeap z:1];
        }
        [self refresh];
    }
    
    return self;
}

- (void) onEnter {
    [super onEnter];
    
}

- (void) refresh {
    for (BTSingleLeap *singleLeap in singleLeaps_){
        [singleLeap refresh];
    }
}

- (bool) hasComplete {
    for (BTSingleLeap *singleLeap in singleLeaps_){
        if ([singleLeap completed]){
            return YES;
        }
    }
    return NO;
}

- (int) lilyPadsRemaining {
    int num = 0;
    for (BTSingleLeap *singleLeap in singleLeaps_){
        if ([singleLeap completed]) {
            num += [singleLeap lilyPadsRemaining];
        }
    }
    return num;
}

- (void) dealloc {
    [singleLeaps_ release];
    [super dealloc];
}

@end

@implementation BTSingleLeap

@synthesize leap=leap_, index=index_, completed=completed_, location=location_, state;

- (id) initWithLeap:(BTLeap *) leap AtIndex:(int) index WithPosition:(CGPoint) position {
    self = [super init];
    if (self){
        
        completed_ = NO;
        index_ = index;
        location_ = position;
        state = InProgress;
        
        if (leap != nil){
            leap_ = [leap retain];
            if ([leap achieved]){
                completed_ = YES;
                state = Complete;
            }
        }
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"missionpanel.png"];
        background.position = ccp(location_.x + 15, location_.y);
        [self addChild:background];
        
        NSString *badgeColor = @"red";
        if (index == 2){
            badgeColor = @"green";
        } else if (index == 3){
            badgeColor = @"blue";
        } 
        
        CCSprite *badge = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@levelingbadge.png", badgeColor]];
        badge.position = ccp(location_.x + -115, location_.y + -5);
        [self addChild:badge z:1];

        CCLabelTTF *progressLabel = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:14];
        progressLabel.position = ccp(location_.x + 50, location_.y + -27);
        [self addChild:progressLabel z:2 tag:kProgressLabelTag];
        
        CCLabelTTF *descriptionLabel = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(210, 35) alignment:UITextAlignmentLeft lineBreakMode:UILineBreakModeWordWrap fontName:@"Marker Felt" fontSize:14];
        descriptionLabel.position = ccp(location_.x + 32, location_.y + -7);
        [self addChild:descriptionLabel z:2 tag:kDescriptionLabelTag];
        
        CCLabelTTF *rewardsLabel = [CCLabelTTF labelWithString:@"" fontName:@"soupofjustice" fontSize:32];
        rewardsLabel.position = ccp(location_.x + -115, location_.y + -5);
        [self addChild:rewardsLabel z:2 tag:kRewardsLabelTag];

        CCLabelTTF *missionLabel = [CCLabelTTF labelWithString:@"" fontName:@"soupofjustice" fontSize:18];
        missionLabel.position = ccp(location_.x + -40, location_.y + 23);
        [self addChild:missionLabel z:2 tag:kMissionLabelTag];

        
        
        if (leap_){
//            CGPoint spawnPoints[] = { ccp(0, 32), ccp(27, 16), ccp(27, -16), ccp(0, -32), ccp(-27, -16), ccp(-27, 16) };
            CGPoint spawnPoints[] = { ccp(0, 32), ccp(27, -16), ccp(-27, -16), ccp(0, -32), ccp(27, 16), ccp(-27, 16) };

            for (int i = 0; i < MIN(6, [leap_ reward]); i++){
                CGPoint offset = spawnPoints[i];
                CCSprite *lilyPad = [CCSprite spriteWithSpriteFrameName:@"lillypad.png"];
                lilyPad.position = ccp(badge.position.x + offset.x, badge.position.y + offset.y);
                [self addChild:lilyPad z:2 tag:i+13];
            }
        }
    }
    
    return self;
}

- (void) refresh {
    if ([leap_ achieved]){
        state = Complete;
        completed_ = YES;
    }
    
    if ([self getChildByTag:kProgressLabelTag]){
        CCLabelTTF *progressLabel = (CCLabelTTF *)[self getChildByTag:kProgressLabelTag];
        NSString *progressString = @"";
        if (leap_){
            progressString = [leap_ progressString];
        }
        
        [progressLabel setString:progressString];
    }
    
    if ([self getChildByTag:kDescriptionLabelTag]){
        CCLabelTTF *descriptionLabel = (CCLabelTTF *)[self getChildByTag:kDescriptionLabelTag];
        NSString *description;
        if (leap_){
            description = [leap_ descriptionString];
        } else {
            description = @"MISSION NOT FOUND";
        }

        [descriptionLabel setString:description];
    }
    
    if ([self getChildByTag:kRewardsLabelTag]){
        CCLabelTTF *rewardsLabel = (CCLabelTTF *)[self getChildByTag:kRewardsLabelTag];
        NSString *reward = @"0";
        if (leap_){
            reward = [NSString stringWithFormat:@"%d", [leap_ reward]];
        }
        
        [rewardsLabel setString:reward];
    }
    
    if ([self getChildByTag:kMissionLabelTag]){
        CCLabelTTF *missionLabel = (CCLabelTTF *)[self getChildByTag:kMissionLabelTag];
        NSString *missionLabelString = [NSString stringWithFormat:@"Mission %d", index_];
        ccColor3B color = ccWHITE;
        if (state == New){
            missionLabelString = @"NEW MISSION";
            color = ccBLUE;
        } else if (state == Complete){
            missionLabelString = @"COMPLETED";
            color = ccGREEN;
        }
        [missionLabel setString:missionLabelString];
        [missionLabel setColor:color];
    }
}

- (int) lilyPadsRemaining {
    int num = 0;
    for (int i = kLilyPad1Tag; i <= kLilyPad6Tag; i++){
        if ([self getChildByTag:i]){
            num++;
        }
    }
    return num;
}

- (void) dealloc {
    [super dealloc];
    [leap_ release];
}

-(void) setColor:(ccColor3B)color {};
-(ccColor3B) color { return ccc3(0, 0, 0); };

-(GLubyte) opacity { return 255; };
-(void) setOpacity: (GLubyte) opacity {
    for (int i = kProgressLabelTag; i <= kLilyPad6Tag; i++){
        if ([self getChildByTag:i] && [[self getChildByTag:i] conformsToProtocol:@protocol(CCRGBAProtocol)]){
            id<CCRGBAProtocol> node = (id<CCRGBAProtocol>)[self getChildByTag:i];
            [node setOpacity:opacity];
        }
    }
}

@end