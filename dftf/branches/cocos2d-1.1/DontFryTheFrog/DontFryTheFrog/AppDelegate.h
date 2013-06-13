//
//  AppDelegate.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/2/11.
//  Copyright Blacktorch Games 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  BTGameScene;

typedef enum {
    kModeMainMenu,
    kModeHighScores,
    kModeGame,
    kModeHopShop,
} tMode;

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    tMode               mode;
    
    BTGameScene         *gameScene;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, assign) tMode mode;
@property (nonatomic, assign) BTGameScene *gameScene;

- (void) startGame;
- (void) openHopshop;
- (void) gameLayerLoaded;
- (void) exitToMainMenu;

@end
