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
    NSUndoManager *undoManager;
}

@property (strong) IBOutlet NSImageView *imageView;

- (id)initWithInitialFileURL:(NSURL *)fileURL;
- (IBAction)duplicate:(id)sender;

- (IBAction)next:(id)sender;
- (IBAction)previous:(id)sender;

- (IBAction)move:(id)sender;
- (IBAction)moveToTrash:(id)sender;
- (void)undoFileMove:(id)dict;

- (IBAction)copy:(id)sender;

- (IBAction)showInFinder:(id)sender;
- (IBAction)showTitleViaNotificationCenter:(id)sender;

- (IBAction)minimize:(id)sender;

- (IBAction)resizeToFit:(id)sender;
- (IBAction)resizeToActualSize:(id)sender;
- (IBAction)resizeToHalfSize:(id)sender;
- (IBAction)resizeToThirdSize:(id)sender;
- (IBAction)resizeToQuarterSize:(id)sender;

- (NSURL *)currentImageURL;

@end
