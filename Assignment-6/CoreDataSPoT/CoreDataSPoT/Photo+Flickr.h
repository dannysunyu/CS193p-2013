//
//  Photo+Flickr.h
//  CoreDataSPoT
//
//  Created by 孙 昱 on 13-12-19.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)


+ (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSString *)spotNameForFlickrPhoto:(NSDictionary *)photoDictionary;

@end
