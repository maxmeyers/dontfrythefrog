//
//  MySHKConfigurator.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MySHKConfigurator.h"

@implementation MySHKConfigurator

- (NSString*)appName {
	return @"Don't Fry the Frog";
}

- (NSString*)appURL {
	return @"http://itunes.apple.com/us/app/dont-fry-the-frog!/id498175623?ls=1&mt=8";
}

- (NSString *)facebookAppId {
    return @"158231894275259";
}

- (NSString *) twitterConsumerKey {
    return @"XfAEXus5U8sPrCECsBWoA";
}

- (NSString *) twitterSecret {
    return @"QSZiXOHefDqPIuG1yCELVoDlJ1b4O1RKA8bkz4vXM";
}

- (NSString *) twitterCallbackUrl {
    return @"http://dontfrythefrog.com/twitter_callback";
}

@end
