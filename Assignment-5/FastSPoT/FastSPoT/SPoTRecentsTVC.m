//
//  SPoTRecentsTVC.m
//  FastSPoT
//
//  Created by 孙 昱 on 13-11-24.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SPoTRecentsTVC.h"

#define RECENTS_URL @"file://recents"

@interface SPoTRecentsTVC ()

@end

@implementation SPoTRecentsTVC

- (NSString *)cellIdentifier
{
    return @"SPoT Photo";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.photos = [self recentsCache];
}

- (NSArray *)recentsCache
{
    NSURL *urlForDocumentDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *urlForRecentsPlist = [urlForDocumentDirectory URLByAppendingPathComponent:@"recents_cache.plist"];
    return [[NSArray alloc] initWithContentsOfURL:urlForRecentsPlist];
}

@end
