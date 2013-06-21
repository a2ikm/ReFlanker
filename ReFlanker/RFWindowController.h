//
//  RFWindowController.h
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/06/15.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RFWindow;

@interface RFWindowController : NSWindowController <NSWindowDelegate>
{
    NSURL *directoryURL;
    NSString *currentFileName;
    NSMutableArray *fileNames;
    NSSize maxSize;
    NSUndoManager *undoManager;
}

@property (strong) IBOutlet NSImageView *imageView;

- (id)initWithInitialFileURL:(NSURL *)fileURL;
- (IBAction)duplicate:(id)sender;

- (IBAction)next:(id)sender;
- (IBAction)previous:(id)sender;

- (IBAction)moveToTrash:(id)sender;
- (void)undoMovingToTrash:(id)dict;

- (IBAction)showInFinder:(id)sender;
- (IBAction)showTitleViaNotificationCenter:(id)sender;

- (IBAction)minimize:(id)sender;

- (NSURL *)currentImageURL;

@end
