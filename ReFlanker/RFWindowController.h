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

- (id)initWithWindowNibName:(NSString *)windowNibName initialFileURL:(NSURL *)fileURL;
- (IBAction)next:(id)sender;
- (IBAction)previous:(id)sender;

- (IBAction)moveToTrash:(id)sender;
- (void)undoMovingToTrash:(id)dict;

- (NSURL *)currentImageURL;

@end
