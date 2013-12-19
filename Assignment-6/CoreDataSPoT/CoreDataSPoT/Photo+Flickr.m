//
//  Photo+Flickr.m
//  CoreDataSPoT
//
//  Created by 孙 昱 on 13-12-19.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "Photo+Flickr.h"
#import "FlickrFetcher.h"
#import "Spot+Create.h"

@implementation Photo (Flickr)

+ (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photo *photo = nil;
    
    // Build a fetch request to see if we can find this Flickr photo in the database.
    // The "unique" attribute in Photo is Flickr's "id" which is guaranteed by Flickr to be unique.
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", [photoDictionary[FLICKR_PHOTO_ID] description]];
    
    // Execute the fetch
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    // Check what happend in the fetch
    
    if (!matches || ([matches count] > 1)) { // nil means fetch failed; more than one impossible (unique!)
        // handle error
    } else if (![matches count]) { // none found, so let's create a Photo for that Flickr photo
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        photo.unique = [photoDictionary[FLICKR_PHOTO_ID] description];
        photo.title = [photoDictionary[FLICKR_PHOTO_TITLE] description];
        photo.subtitle = [[photoDictionary valueForKeyPath:FLICKR_PHOTO_DESCRIPTION] description];
        photo.imageURL = [[FlickrFetcher urlForPhoto:photoDictionary format:FlickrPhotoFormatLarge] absoluteString];
        NSString *spotName = [Photo spotNameForFlickrPhoto:photoDictionary];
        Spot *spot = [Spot spotWithName:spotName inManagedObjectContext:context];
        photo.takenAt = spot;
    } else {
        photo = [matches lastObject];
    }
    
    return photo;
}

+ (NSString *)spotNameForFlickrPhoto:(NSDictionary *)photoDictionary
{
    NSArray *ignoredTags = @[@"cs193pspot", @"portrait", @"landscape"];
    
    NSArray *tags = [photoDictionary[FLICKR_TAGS] componentsSeparatedByString:@" "];
    if (tags && [tags count] > 0) {
        for (NSString *tag in tags) {
            if (![ignoredTags containsObject:tag]) {
                return tag;
            }
        }
    }
    
    return nil;
}


@end
