//
//  FlickrCache.m
//  SPoT
//
//  Created by Martin Mandl on 04.03.13.
//  Copyright (c) 2013 m2m server software gmbh. All rights reserved.
//

#import "FlickrCache.h"

@interface FlickrCache()

@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) NSURL *cacheFolder;

@end

@implementation FlickrCache

- (NSFileManager *)fileManager
{
    if (!_fileManager) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}

- (NSURL *)cacheFolder
{
    if (!_cacheFolder) {
        _cacheFolder = [[[self.fileManager URLsForDirectory:NSCachesDirectory
                                                  inDomains:NSUserDomainMask] lastObject]
                        URLByAppendingPathComponent:FLICKR_CACHE_FOLDER
                        isDirectory:YES];
        BOOL isDir = NO;
        if (![self.fileManager fileExistsAtPath:[_cacheFolder path]
                                    isDirectory:&isDir]) {
            [self.fileManager createDirectoryAtURL:_cacheFolder
                       withIntermediateDirectories:YES
                                        attributes:nil
                                             error:nil];
        }
    }
    return _cacheFolder;
}

- (NSURL *)buildCachedFileURLforURL:(NSURL *)url
{
    return [self.cacheFolder URLByAppendingPathComponent:[[url path] lastPathComponent]];
}

- (void)cleanupOldFiles
{
    NSDirectoryEnumerator *dirEnumerator =
    [self.fileManager enumeratorAtURL:self.cacheFolder
           includingPropertiesForKeys:@[NSURLAttributeModificationDateKey]
                              options:NSDirectoryEnumerationSkipsHiddenFiles
                         errorHandler:nil];
    NSNumber *fileSize;
    NSDate *fileDate;
    NSMutableArray *files = [NSMutableArray array];
    __block NSUInteger dirSize = 0;
    for (NSURL *url in dirEnumerator) {
        [url getResourceValue:&fileSize forKey:NSURLFileSizeKey error:nil];
        [url getResourceValue:&fileDate forKey:NSURLAttributeModificationDateKey error:nil];
        dirSize += [fileSize integerValue];
        [files addObject:@{@"url":url, @"size":fileSize, @"date":fileDate}];
    }
    int maxCacheSize = FLICKR_CACHE_MAXSIZE_IPHONE;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        maxCacheSize = FLICKR_CACHE_MAXSIZE_IPAD;
    }
    if (dirSize > maxCacheSize) {
        NSArray *sorted = [files sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1[@"date"] compare:obj2[@"date"]];
        }];
        [sorted enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            dirSize -= [obj[@"size"] integerValue];
            NSError *error;
            [self.fileManager removeItemAtURL:obj[@"url"] error:&error];
            *stop = error || (dirSize < maxCacheSize);
        }];
    }
}

+ (NSURL *)cachedFileURLforURL:(NSURL *)url
{
    FlickrCache *cache = [[FlickrCache alloc] init];
    NSURL *cachedFileURL = [cache buildCachedFileURLforURL:url];    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[cachedFileURL path]]) {
        return cachedFileURL;
    }
    return nil;
}

+ (void)cacheData:(NSData *)data forURL:(NSURL *)url
{
    if (!data) return;
    FlickrCache *cache = [[FlickrCache alloc] init];
    NSURL *cachedFileURL = [cache buildCachedFileURLforURL:url];

    if ([[NSFileManager defaultManager] fileExistsAtPath:[cachedFileURL path]]) {
        [cache.fileManager setAttributes:@{NSFileModificationDate:[NSDate date]}
                            ofItemAtPath:[cachedFileURL path] error:nil];
    } else {
        [cache.fileManager createFileAtPath:[cachedFileURL path]
                                   contents:data attributes:nil];
        [cache cleanupOldFiles];
    }
}

@end