//
//  RFZipLoader.m
//  ReFlanker
//
//  Created by Masato IKEDA on 2013/09/04.
//  Copyright (c) 2013年 Aerialarts. All rights reserved.
//

#import "RFZipLoader.h"
#import "SSZipArchive.h"

@interface RFZipLoader ()
@property (nonatomic, retain) NSURL *fileURL;
@property (readonly, nonatomic, retain) NSURL *unarchivedDirectoryURL;
+ (NSURL *)unarchivedDirectoryURL;
- (void)unzipOnce;
- (NSURL *)determineInitialURL;
- (BOOL)alreadyUnarchived;
@end

@implementation RFZipLoader

@synthesize unarchivedDirectoryURL = _unarchivedDirectoryURL;

- (id)initWithURL:(NSURL *)fileURL
{
    self = [super init];
    if (self) {
        self.fileURL = fileURL;
        [self unzipOnce];
    }
    return self;
}

- (NSURL *)initialFileURL
{
    if (!_initialURL) {
        _initialURL = [self determineInitialURL];
    }
    return _initialURL;
}

+ (void)cleanup
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[[self unarchivedDirectoryURL] path]]) {
        [fileManager removeItemAtURL:[self unarchivedDirectoryURL] error:NULL];
    }
}

#pragma mark - PRIVATE

+ (NSURL *)unarchivedDirectoryURL
{
    return [[APP_DELEGATE cacheDirectory] URLByAppendingPathComponent:@"unarchived"];
}

- (NSURL *)unarchivedDirectoryURL
{
    if (!_unarchivedDirectoryURL) {
        NSString *dir1 = [[NSData dataWithContentsOfURL:self.fileURL] MD5Digest];
        NSString *dir2 = [[self.fileURL lastPathComponent] stringByDeletingPathExtension];
        
        _unarchivedDirectoryURL = [[[[self class] unarchivedDirectoryURL] URLByAppendingPathComponent:dir1] URLByAppendingPathComponent:dir2];
    }
    return _unarchivedDirectoryURL;
}

- (void)unzipOnce
{
    if ([self alreadyUnarchived]) {
        return;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:[[self unarchivedDirectoryURL] path]]) {
        [fileManager createDirectoryAtPath:[[self unarchivedDirectoryURL] path]
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:NULL];
    }
    
    [SSZipArchive unzipFileAtPath:[self.fileURL path]
                    toDestination:[[self unarchivedDirectoryURL] path]
                        overwrite:YES
                         password:nil error:NULL];
    
    NSArray *files = [fileManager contentsOfDirectoryAtPath:[[self unarchivedDirectoryURL] path] error:NULL];
    if ([files count] > 0) {
        NSURL *firstFileURL = [[self unarchivedDirectoryURL] URLByAppendingPathComponent:[files objectAtIndex:0]];
        BOOL isDirectory = NO;
        [fileManager fileExistsAtPath:[firstFileURL path] isDirectory:&isDirectory];
        if (isDirectory) {
            NSArray *subFiles = [fileManager contentsOfDirectoryAtPath:[firstFileURL path] error:NULL];
            for (NSString *subFile in subFiles) {
                NSURL *fromURL = [firstFileURL URLByAppendingPathComponent:subFile];
                NSURL *toURL   = [[self unarchivedDirectoryURL] URLByAppendingPathComponent:subFile];
                [fileManager moveItemAtPath:[fromURL path] toPath:[toURL path] error:NULL];
            }
            
            [fileManager removeItemAtPath:[firstFileURL path] error:NULL];
        }
    }
}

- (NSURL *)determineInitialURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *files = [fileManager contentsOfDirectoryAtPath:[[self unarchivedDirectoryURL] path] error:NULL];
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSString *extension = [[(NSString *)evaluatedObject pathExtension] lowercaseString];
        for (NSString *allowedFileType in ALLOWED_FILE_TYPES) {
            if([extension isEqualToString:allowedFileType]) {
                return YES;
            };
        }
        return NO;
        
    }];
    
    NSArray *filteredFiles = [files filteredArrayUsingPredicate:predicate];
    
    if ([filteredFiles count] > 0) {
        return [[self unarchivedDirectoryURL] URLByAppendingPathComponent:[filteredFiles objectAtIndex:0]];
    } else {
        return nil;
    }
}

- (BOOL)alreadyUnarchived
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[[self unarchivedDirectoryURL] path]];
}

@end
