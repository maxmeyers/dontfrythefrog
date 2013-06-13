//
//  BTConfigLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTConfigLayer.h"
#import "BTIncludes.h"
#import "CCTouchDispatcher.h"

@implementation BTConfigLayer

@synthesize configScene;

CCMenuItemFont *currentButton;

CCMenuItemFont *flyPenniesButton;
CCMenuItemFont *greenFlyLevelButton;
CCMenuItemFont *blueFlyLevelButton;
CCMenuItemFont *redFlyLevelButton;
CCMenuItemFont *yellowFlyLevelButton;
CCMenuItemFont *unlockButton;


- (id) initWithConfigScene: (BTConfigScene *) scene {
    if ((self = [super initWithColor:ccc4(0, 255, 0, 255)])){
        self.isTouchEnabled = YES;
        configScene = scene;
        
        [CCMenuItemFont setFontSize:24];
        
        flyPenniesButton = [CCMenuItemFont itemFromString:@"Fly Pennies" target:self selector:@selector(buttonPress:)];
        greenFlyLevelButton = [CCMenuItemFont itemFromString:@"Green Fly Level" target:self selector:@selector(buttonPress:)];
        blueFlyLevelButton = [CCMenuItemFont itemFromString:@"Blue Fly Level" target:self selector:@selector(buttonPress:)];
        redFlyLevelButton = [CCMenuItemFont itemFromString:@"Red Fly Level" target:self selector:@selector(buttonPress:)];
        yellowFlyLevelButton = [CCMenuItemFont itemFromString:@"Yellow Fly Level" target:self selector:@selector(buttonPress:)]; 
        unlockButton = [CCMenuItemFont itemFromString:@"Unlock Bugs" target:self selector:@selector(unlockBugs)];
   
        CCMenu *menu = [CCMenu menuWithItems:
                        flyPenniesButton, greenFlyLevelButton, blueFlyLevelButton, redFlyLevelButton, yellowFlyLevelButton, unlockButton, nil];
        [menu alignItemsVertically];
        [self addChild:menu];
    }
    
    return self;
}

- (void) buttonPress:(id) sender {
    currentButton = sender;
    NSString *title = [[currentButton label] string];
    NSString *current = @"";
    
    
    if (currentButton == flyPenniesButton) {
        current = [NSString stringWithFormat:@"%d", [[BTHopshopManager sharedHopshopManager] flyTokens]];
    } else if (currentButton == greenFlyLevelButton) {
        current = [NSString stringWithFormat:@"%d", [[BTHopshopManager sharedHopshopManager] levelForBug:[BTGreenFly class]]];
    } else if (currentButton == blueFlyLevelButton) {
        current = [NSString stringWithFormat:@"%d", [[BTHopshopManager sharedHopshopManager] levelForBug:[BTIceBug class]]];
    } else if (currentButton == redFlyLevelButton) {
        current = [NSString stringWithFormat:@"%d", [[BTHopshopManager sharedHopshopManager] levelForBug:[BTFireBug class]]];
    } else if (currentButton == yellowFlyLevelButton) {
        current = [NSString stringWithFormat:@"%d", [[BTHopshopManager sharedHopshopManager] levelForBug:[BTSickBug class]]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:@" " 
                                                       delegate:self 
                                              cancelButtonTitle:@"Okay" 
                                              otherButtonTitles: nil];
    UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 30.0, 260.0, 25.0)];
    [myTextField setText:current];
    [myTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [myTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [myTextField setBackgroundColor:[UIColor whiteColor]];
    [myTextField setDelegate:self];
    [alertView addSubview:myTextField];
    [myTextField release]; 
    
    [alertView show];
    [alertView release];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {    
    if (currentButton == flyPenniesButton){
        [[BTHopshopManager sharedHopshopManager] setFlyTokens:[[textField text] intValue]];
    } else if (currentButton == greenFlyLevelButton){
        [[BTHopshopManager sharedHopshopManager] setLevel:[[textField text] intValue] ForBug:[BTGreenFly class]];
    } else if (currentButton == blueFlyLevelButton) {
        [[BTHopshopManager sharedHopshopManager] setLevel:[[textField text] intValue] ForBug:[BTIceBug class]];
    } else if (currentButton == redFlyLevelButton) {
        [[BTHopshopManager sharedHopshopManager] setLevel:[[textField text] intValue] ForBug:[BTFireBug class]];
    } else if (currentButton == yellowFlyLevelButton) {
        [[BTHopshopManager sharedHopshopManager] setLevel:[[textField text] intValue] ForBug:[BTSickBug class]];
    }
}

- (void) unlockBugs {
    [BTStorageManager unlockBug:[BTGreenFly class]];
    [BTStorageManager unlockBug:[BTSickBug class]];
    [BTStorageManager unlockBug:[BTIceBug class]];
    [BTStorageManager unlockBug:[BTFireBug class]];
}

#pragma mark -
#pragma mark Touch Methods
//***************************************************
// TOUCH METHODS
//***************************************************

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];    
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    float distance = DISTANCE([self convertTouchToNodeSpace:touch], CGPointMake(480, 320));
    if (distance < 50){
        [configScene unPauseGame];
    }
	return NO;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
}

@end
