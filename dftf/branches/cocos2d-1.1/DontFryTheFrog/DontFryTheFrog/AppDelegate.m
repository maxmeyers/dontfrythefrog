//
//  AppDelegate.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/2/11.
//  Copyright Blacktorch Games 2011. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameConfig.h"
#import "RootViewController.h"
#import "BTIncludes.h"

#import "GameKit/GameKit.h"
#import "SHKFacebook.h"
#import "TestFlight.h"

@implementation AppDelegate

@synthesize window, mode, gameScene;

BTMainMenuScene *mainMenuScene;

BTGameLayer *gameLayer;
BTLoadingScene *loadingScene;

- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

//	CC_ENABLE_DEFAULT_GL_STATES();
//	CCDirector *director = [CCDirector sharedDirector];
//	CGSize size = [director winSize];
//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
//	sprite.position = ccp(size.width/2, size.height/2);
//	sprite.rotation = -90;
//	[sprite visit];
//	[[director openGLView] swapBuffers];
//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}
- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
    if ([[UIDevice currentDevice].model isEqualToString:@"iPhone"]){
        if( ! [director enableRetinaDisplay:YES] )
            CCLOG(@"Retina Display Not supported");
    }
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeRight];
#endif
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:YES];
    
    // enable multitouch
	[glView setMultipleTouchEnabled:YES];
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
	
	[window makeKeyAndVisible];
    
    [TestFlight takeOff:@"a3e753ba6d9c0091f96833bc63ded373_OTU2MTIwMTEtMTAtMjQgMDA6MjI6MjEuNDk1Mzcy"];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	// Removes the startup flicker
	[self removeStartupFlicker];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:[BTHopshopManager sharedHopshopManager]];
    if ([SKPaymentQueue canMakePayments]){
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects: @"5000FP", @"10500FP", @"16500FP", @"28000FP", @"70000FP", nil]];
        request.delegate = [BTHopshopManager sharedHopshopManager];
        [request start];
    }
    
    loadingScene = [[BTLoadingScene node] retain];
    
    mainMenuScene = [[BTMainMenuScene node] retain];
    mode = kModeMainMenu;
    
    [[CCDirector sharedDirector] runWithScene:mainMenuScene];
    [BTGameCenterManager authenticateLocalPlayer];

}

- (void) startGame {
    if (mode == kModeMainMenu || mode == kModeHopShop){
        [[CCDirector sharedDirector] pushScene:loadingScene];
        mode = kModeGame;
        gameLayer = [[BTGameLayer alloc] init];
        [gameLayer load];
    }
}

- (void) gameLayerLoaded {
    gameScene = [[[BTGameScene alloc] initWithGameLayer:gameLayer] autorelease];
    [gameLayer release];
    [[CCDirector sharedDirector] replaceScene:gameScene];
}

- (void) openHopshop {
    BTHopshopScene *hopshopScene = [[[BTHopshopScene alloc] init] autorelease];
    [[CCDirector sharedDirector] pushScene:hopshopScene];
    mode = kModeHopShop;
}

- (void) exitToMainMenu {
    [[CCDirector sharedDirector] popScene];
    while ([[CCDirector sharedDirector] nextScene] != mainMenuScene){
        [[CCDirector sharedDirector] popScene];
    }
    
    if (mode == kModeGame){
        gameScene = nil;
        gameLayer = nil;
    }
    mode = kModeMainMenu;
    

    [[CCDirector sharedDirector] resume];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[BTLeapManager sharedManager] save];
	[[CCDirector sharedDirector] pause];
    if (mode == kModeGame){
        [[[gameScene gameLayer] player] setTouch0:nil];
        [[[gameScene gameLayer] player] setTouch1:nil];
    }

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
    if (mode == kModeGame && [gameScene gameState] == kGameStateStarted){
        [gameScene pauseGameWithState:kGameStatePaused];
    }
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
    if (mode == kModeGame){
        [[[gameScene gameLayer] player] setTouch0:nil];
        [[[gameScene gameLayer] player] setTouch1:nil];
    }
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {    
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [SHKFacebook handleOpenURL:url];
}


- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
	[super dealloc];
}

@end
