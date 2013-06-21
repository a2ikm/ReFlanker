//
//  RFAboutPanelController.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/22.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "RFAboutPanelController.h"

@interface RFAboutPanelController ()

@end

@implementation RFAboutPanelController

static RFAboutPanelController *_sharedController = nil;

+ (RFAboutPanelController *)sharedController
{
    @synchronized(self) {
        if (_sharedController == nil) {
            (void)[[self alloc] init];
        }
    }
    return _sharedController;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (_sharedController == nil) {
            _sharedController = [super allocWithZone:zone];
            return _sharedController;
        }
    }
    return nil;
}

- (id)init
{
    if (self = [super initWithWindowNibName:@"AboutPanel"]) {
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    [[self versionField] setStringValue:version];
}

@end
