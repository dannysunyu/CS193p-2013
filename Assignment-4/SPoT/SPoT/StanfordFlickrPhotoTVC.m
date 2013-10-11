//
//  StanfordFlickrPhotoTVC.m
//  SPoT
//
//  Created by 孙 昱 on 13-10-2.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "StanfordFlickrPhotoTVC.h"
#import "FlickrFetcher.h"

@interface StanfordFlickrPhotoTVC()

@end

@implementation StanfordFlickrPhotoTVC

@synthesize tags = _tags;

// sets the Model
// reloads the UITableView (since Model is changing)
- (void)setTags:(NSMutableDictionary *)tags
{
    _tags = tags;
    [self.tableView reloadData];
}

- (NSMutableDictionary *)tags {
    if (!_tags) {
        _tags = [[NSMutableDictionary alloc] init];
    }
    return _tags;
}

// purpose of this entire VC is just to set its Model by querying Flickr using FlickrFetcher

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *photos = [FlickrFetcher stanfordPhotos];
    
    for (NSDictionary *photo in photos) {
        NSString *tag = [self tagForPhoto:photo];
        if (self.tags[tag]) {
            NSMutableArray *spots = self.tags[tag];
            [spots addObject:photo];
        } else {
            NSMutableArray *spots = [[NSMutableArray alloc] init];
            [spots addObject:photo];
            self.tags[tag] = spots;
        }
    }
}

+ (NSArray *)ignoredTags
{
    return @[@"cs193pspot", @"portrait", @"landscape"];
}

- (NSString *)tagForPhoto:(NSDictionary *)photo
{
    NSArray *tags = [[photo objectForKey:FLICKR_TAGS] componentsSeparatedByString:@" "];
    for (NSString *tag in tags) {
        if (![[StanfordFlickrPhotoTVC ignoredTags] containsObject:tag]) {
            return tag;
        }
    }
    
    return nil;
}

#pragma mark - Segue

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
            if ([segue.identifier isEqualToString:@"Show Spots"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setSpots:)]) {
                    NSArray *spots = self.tags[[self.tags allKeys][indexPath.row]];
                    [segue.destinationViewController performSelector:@selector(setSpots:) withObject:spots];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                }
            }
        }
    }
    
}

// lets the UITableView know how many rows it should display
// in this case, just the count of dictionaries in the Model's array

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tags count];
}

// a helper method that looks in the Model for the photo dictionary at the given row
//  and gets the title out of it

- (NSString *)titleForRow:(NSUInteger)row
{
    return [[[self.tags allKeys][row] capitalizedString] description]; // description because could be NSNull
}

// a helper method that looks in the Model for the photo dictionary at the given row
//  and gets the owner of the photo out of it

- (NSString *)subtitleForRow:(NSUInteger)row
{
    NSArray *photos = [self.tags valueForKey:[self.tags allKeys][row]];
    if (photos) {
        return [NSString stringWithFormat:@"%d photos", [photos count]];
    } else {
        return @"No photos.";
    }
}



@end
