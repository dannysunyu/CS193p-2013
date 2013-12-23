//
//  RecentPhotosCDTVC.m
//  CoreDataSPoT
//
//  Created by 孙 昱 on 13-12-19.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "RecentPhotosCDTVC.h"
#import "Photo.h"
#import "SPoTAppDelegate.h"

@implementation RecentPhotosCDTVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.managedObjectContext) [self useSPoTDocument];
}

// The model for this class.
//
// When it gets set, we create an NSFetchRequest to get all Spots in the database associated with it.
// Then we hook that NSFetchRequest up to the table view using an NSFetchedResultController.
- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"lastViewed" ascending:NO selector:@selector(compare:)]];
        request.predicate =
        [NSPredicate predicateWithFormat:@"lastViewed != nil"]; // all recent photos (with lastViewed attribute not being nil)
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
    } else {
        self.fetchedResultsController = nil;
    }
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


#pragma mark - UITableViewDataSource

// Loads up the cell for a given row by getting the associated Photo from our NSFetchedResultsController.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo"];
    
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.subtitle;
    
    return cell;
}

@end
