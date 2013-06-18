//
//  RFAppDelegate.h
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/15.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RFAppDelegate : NSObject <NSApplicationDelegate> {
    NSMutableArray *windowControllers;
}

- (IBAction)open:(id)sender;
- (IBAction)close:(id)sender;
- (IBAction)duplicate:(id)sender;

- (IBAction)nextWindow:(id)sender;
- (IBAction)previousWindow:(id)sender;

@end
