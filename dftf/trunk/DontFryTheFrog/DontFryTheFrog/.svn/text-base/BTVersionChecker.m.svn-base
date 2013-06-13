//
//  BTVersionChecker.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTVersionChecker.h"
#import "BTIncludes.h"

@implementation BTVersionChecker

- (id) init {
    self = [super init];
    
    if (self){
        NSURLRequest *versionRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.dontfrythefrog.com/version"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
        versionConnection = [NSURLConnection connectionWithRequest:versionRequest delegate:self];
        
        NSURLRequest *newsRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.dontfrythefrog.com/news"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
        newsConnection = [NSURLConnection connectionWithRequest:newsRequest delegate:self];
    }
    
    return self;
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data { 
    
    @try {
        if (connection == versionConnection){
            float newestVersion = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] floatValue];
            if (newestVersion - [BTStorageManager recentAppVersion] > 0.001){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Update your game!" message:@"We added new things to Don't Fry the Frog! Update your game!" delegate:self cancelButtonTitle:@"Not now" otherButtonTitles:@"Update", nil];
                [alertView show];
            } else if (fabs([BTStorageManager recentAppVersion] - newestVersion) < 0.001){
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            }            
        } else if (connection == newsConnection){
            NSString *news = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [BTStorageManager setNews:news];
            [[BTNewsLog sharedNewsLog] refreshNews];
        }

    }
    @catch (NSException *exception) {
        NSLog(@"Check for Newest Version Failed: %@", [exception description]);
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/dont-fry-the-frog!/id498175623?ls=1&mt=8"]];
    }
}

@end
