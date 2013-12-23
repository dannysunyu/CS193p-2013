//
//  StanfordSpotCDTVC.m
//  CoreDataSPoT
//
//  Created by 孙 昱 on 13-12-19.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "StanfordSpotCDTVC.h"
#import "FlickrFetcher.h"
#import "Photo+Flickr.h"
#import "SPoTAppDelegate.h"

@implementation StanfordSpotCDTVC

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.managedObjectContext) [self useSPoTDocument];
}


// Either creates, opens or just uses the SPoT document
//
- (void)useSPoTDocument
{
    SPoTAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.managedDocument) {
        appDelegate.managedDocument = [[UIManagedDocument alloc] initWithFileURL:appDelegate.managedDocumentURL];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[appDelegate.managedDocumentURL path]]) {
        [appDelegate.managedDocument saveToURL:appDelegate.managedDocumentURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                self.managedObjectContext = appDelegate.managedDocument.managedObjectContext;
                [self refresh];
            }
        }];
    } else if (appDelegate.managedDocument.documentState == UIDocumentStateClosed) {
        [appDelegate.managedDocument openWithCompletionHandler:^(BOOL success) {
            if (success) {
                self.managedObjectContext = appDelegate.managedDocument.managedObjectContext;
            }
        }];
    } else {
        self.managedObjectContext = appDelegate.managedDocument.managedObjectContext;
    }
}

#pragma mark - Refreshing

// Fires off a block

- (void)refresh
{
    NSLog(@"refresh");
    [self.refreshControl beginRefreshing];
    
    dispatch_queue_t fetchQ = dispatch_queue_create("Flickr Fetch", NULL);
    dispatch_async(fetchQ, ^{
        NSArray *photos = [FlickrFetcher stanfordPhotos];
        // put the photos in Core Data
        [self.managedObjectContext performBlock:^{
            for (NSDictionary *photo in photos) {
                [Photo photoWithFlickrInfo:photo inManagedObjectContext:self.managedObjectContext];
            }            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.refreshControl endRefreshing];
            });
        }];
    });
}


@end
