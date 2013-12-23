//
//  SpotCDTVC.m
//  CoreDataSPoT
//
//  Created by 孙 昱 on 13-12-19.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SpotCDTVC.h"
#import "Spot.h"
#import "PhotosBySpotCDTVC.h"

@implementation SpotCDTVC

#pragma mark - Properties

// The model for this class.
//
// When it gets set, we create an NSFetchRequest to get all Spots in the database associated with it.
// Then we hook that NSFetchRequest up to the table view using an NSFetchedResultController.
- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Spot"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = nil; // all Spots
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
    } else {
        self.fetchedResultsController = nil;
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Spot"];
    
    Spot *spot = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = spot.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu photos", (unsigned long)[spot.photos count]];

    return cell;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = nil;

    if ([sender isKindOfClass:[UITableViewCell class]]) {
        indexPath = [self.tableView indexPathForCell:sender];
    }
    
    if (indexPath) {
        if ([segue.identifier isEqualToString:@"setSpot:"]) {
            Spot *spot = [self.fetchedResultsController objectAtIndexPath:indexPath];
            if ([segue.destinationViewController respondsToSelector:@selector(setSpot:)]) {
                [segue.destinationViewController performSelector:@selector(setSpot:) withObject:spot];
            }
        }
    }
}


@end
