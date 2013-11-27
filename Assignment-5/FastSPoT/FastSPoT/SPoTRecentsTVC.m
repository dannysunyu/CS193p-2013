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

    self.photos = [[NSArray alloc] initWithContentsOfURL:[self urlForRecentsPlist]];
}

- (NSURL *)urlForRecentsPlist
{
    NSURL *documentURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [documentURL URLByAppendingPathComponent:@"recents.plist"];
}

@end
