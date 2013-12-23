//
//  FlickrCache.h
//  FastSPoT
//
//  Created by 孙 昱 on 13-11-30.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FLICKR_CACHE_MAXSIZE_IPHONE 1024 * 1024 * 3
#define FLICKR_CACHE_MAXSIZE_IPAD 1024 * 1024 * 10
#define FLICKR_CACHE_FOLDER @"FlickrCache"

@interface FlickrCache : NSObject

// Get file url of the disk-cached file if there is any, otherwise return nil
+ (NSURL *)cachedFileURLforURL:(NSURL *)url;

// Save the data to the cache. The cache will a use a folder of its own,
// and will be limited to different sizes depending on the device.
// Note that the cache mechanism has been optimized so that an cached file will
// not be cached twice
+ (void)cacheData:(NSData *)data forURL:(NSURL *)url;

@end
