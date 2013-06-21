//
//  RFAboutPanelController.h
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/22.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

//
// An siingleton class, implemented like
// http://yakuyakuyaku.blogspot.jp/2012/07/arc.html
//

#import <Cocoa/Cocoa.h>

@interface RFAboutPanelController : NSWindowController <NSWindowDelegate>

@property IBOutlet NSTextField *versionField;

+ (RFAboutPanelController *)sharedController;

@end
