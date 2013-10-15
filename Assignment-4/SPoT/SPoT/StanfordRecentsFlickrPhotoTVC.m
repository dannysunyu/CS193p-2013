//
//  StanfordRecentsFlickrPhotoTVC.m
//  SPoT
//
//  Created by 孙 昱 on 13-10-13.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "StanfordRecentsFlickrPhotoTVC.h"
#import "FlickrFetcher.h"

#define RECENT_SPOTS_KEY @"RECENT_SPOTS_KEY"

@interface StanfordRecentsFlickrPhotoTVC ()
@end

@implementation StanfordRecentsFlickrPhotoTVC

- (NSArray *)recentSpots
{
    if (!_recentSpots) _recentSpots = [[NSMutableArray alloc] init];
    return _recentSpots;
}

- (NSString *)titleForRow:(NSUInteger)row
{
    NSDictionary *photo = self.recentSpots[row];
    return [photo valueForKey:FLICKR_PHOTO_TITLE];
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
    NSDictionary *photo = self.recentSpots[row];
    return [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.recentSpots = [[NSUserDefaults standardUserDefaults] arrayForKey:RECENT_SPOTS_KEY];
    [self.tableView reloadData];
}

// lets the UITableView know how many rows it should display
// in this case, just the count of dictionaries in the Model's array

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recentSpots count];
}

// prepares for the "Show Image" segue by seeing if the destination view controller of the segue
//  understands the method "setImageURL:"
// if it does, it sends setImageURL: to the destination view controller with
//  the URL of the photo that was selected in the UITableView as the argument
// also sets the title of the destination view controller to the photo's title

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Show Image"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setImageURL:)]) {
                    NSDictionary *photo = self.recentSpots[indexPath.row];
                    NSURL *url = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatLarge];
                    [segue.destinationViewController performSelector:@selector(setImageURL:) withObject:url];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                }
            }
        }
    }
    
}


@end
