//
//  SPoTPhotoTVC.m
//  FastSPoT
//
//  Created by 孙 昱 on 13-11-24.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SPoTPhotoTVC.h"

@interface SPoTPhotoTVC ()

@end

@implementation SPoTPhotoTVC

- (NSString *)cellIdentifier
{
    return @"SPoT Photo";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    if (indexPath) {
        [self cacheRecentPhoto:self.photos[indexPath.row]];
    }
    
    [super prepareForSegue:segue sender:sender];
}

- (void)cacheRecentPhoto:(NSDictionary *)photo
{
    NSURL *urlForDocumentDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                             inDomains:NSUserDomainMask] lastObject];
    NSURL *urlForRecentsPlist = [urlForDocumentDirectory URLByAppendingPathComponent:@"recents_cache.plist"];
    NSMutableArray *recentsCache = [[NSMutableArray alloc] initWithContentsOfURL:urlForRecentsPlist];
    if (!recentsCache) {
        recentsCache = [[NSMutableArray alloc] init];
    }
    
    if ([recentsCache containsObject:photo]) {
        [recentsCache removeObject:photo];
    }
    [recentsCache insertObject:photo atIndex:0];
    [recentsCache writeToURL:urlForRecentsPlist atomically:NO];
}

@end
