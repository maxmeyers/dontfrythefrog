//
//  HelloWorldLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/2/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "chipmunk.h"
#import "BTGameScene.h"
#import "BTPopup.h"

@class BTChipmunkManager, BTBugManager, BTBug, BTPuddle, BTFrog, BTPlayer, BTFrogEffectPuddled, BTFrogEffectFoilHat;

@interface BTGameLayer : CCLayer <BTPopupable> {
    int loadCount;
    
    ccTime totalTime;
    ccTime playTime;
    ccTime fingersDownTime;
    
    bool fingersDown;
    int fingersDownInstances;
    ccTime fingersDownAverageTime;
    
    BTPlayer *player;
    BTFrog *frog;
    
    NSArray *baseMilestones;
    NSMutableArray *frogMilestones;
    NSMutableDictionary *killDictionary;

    BTChipmunkManager *chipmunkManager;
    BTBugManager *bugManager;
    double seed;
    
    cpSpace *space;
    BTGameScene *scene;
    
    BTFrogEffectPuddled *puddleEffect;
    BTFrogEffectFoilHat *foilEffect;
    
    BTPopup *introPopup;
    bool playBeamBonus;
}

/**
 * Running time since the game started
 */
@property ccTime totalTime;
@property ccTime playTime;

@property (nonatomic, assign) BTPlayer *player;
@property (nonatomic, assign) BTFrog *frog;

@property (nonatomic, assign) BTChipmunkManager *chipmunkManager;
@property (nonatomic, assign) BTBugManager *bugManager;

/**
 * Fucking random generator seed
 */
@property double seed;

/**
 * Chipmunk Collision Space 
 */
@property (nonatomic, assign) cpSpace *space;

/**
 * Reference to parent scene
 */
@property (nonatomic, assign) BTGameScene *scene;

@property bool playBeamBonus;

- (void) update:(ccTime) dt;

- (void) load;
- (void) imageLoaded;
- (void) start;
- (void) startNewbieMode;
- (void) waddlingDidFinish;
- (void) signDidFall;
- (void) stopWithState:(tGameState) state;
- (void) reset;
- (void) milestoneCheck;
- (void) bugSprayCheck;

- (void) loadIntro;

- (void) flyZapped: (BTBug *) fly;
- (void) tongueZapped;
- (void) frogZapped;
- (void) frogTouchedPuddle:(BTPuddle *) puddle;
- (void) frogFinishedExploding;
- (void) frogFinishedZapping;
- (void) frogLifeLost;
- (bool) popFoilhat; // returns YES if there was a foil hat and it was popped
- (BTPuddle *) puddleByShape:(cpShape *) shape;

- (void) showPointsFadeawayString:(NSString *) string position:(CGPoint) position;
- (void) showPointsFadeawayString:(NSString *) string fontSize:(int) size color:(ccColor3B) fontColor position:(CGPoint) position;

- (void) AddToKillDictionaryBugClass:(NSString *) bugClass Method:(NSString *)method;

- (void) seedRandom;

@end
