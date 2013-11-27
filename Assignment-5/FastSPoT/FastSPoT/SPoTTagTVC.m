//
//  SPoTPhotoTVC.m
//  FastSPoT
//
//  Created by 孙 昱 on 13-11-23.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SPoTTagTVC.h"
#import "FlickrFetcher.h"

@interface SPoTTagTVC ()
@property (strong, nonatomic) NSArray *spots;
@property (strong, nonatomic) NSMutableDictionary *tags;

@end

@implementation SPoTTagTVC

- (void)setSpots:(NSArray *)spots
{
    _spots = spots;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadStanfordPhotosFromFlickr];
    // add target/action manually (ctrl-drag from UIRefreshControl broken in Xcode)
    [self.refreshControl addTarget:self
                            action:@selector(loadStanfordPhotosFromFlickr)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)loadStanfordPhotosFromFlickr
{
    // start the animation if it's not already going
    [self.refreshControl beginRefreshing];
    
    dispatch_queue_t loaderQ = dispatch_queue_create("flickr stanford loader", NULL);
    dispatch_async(loaderQ, ^{
        // call Flickr
        NSArray *rawPhotos = [FlickrFetcher stanfordPhotos];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tags = [self filteredPhotos:rawPhotos exceptTags:@[@"cs193pspot", @"portrait", @"landscape"]] ;
            self.spots = [[self.tags allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        });
    });
}

- (NSMutableDictionary *)filteredPhotos:(NSArray *)rawPhotos exceptTags:(NSArray *)tags
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *photo in rawPhotos) {
        NSString *tag = [self tagForPhoto:photo ignoredTags:tags];
        if (tag) {
            if (result[tag]) {
                NSMutableArray *photos = result[tag];
                [photos addObject:photo];
            } else {
                NSMutableArray *photos = [[NSMutableArray alloc] init];
                [photos addObject:photo];
                result[tag] = photos;
                
                [self.refreshControl endRefreshing];  // stop the animation
            }
        }
    }
//    [result ]
    return result;
}

- (NSString *)tagForPhoto:(NSDictionary *)photo ignoredTags:(NSArray *)badTags
{
    NSArray *tags = [[photo objectForKey:FLICKR_TAGS] componentsSeparatedByString:@" "];
    for (NSString *tag in tags) {
        if (![badTags containsObject:tag]) {
            return tag;
        }
    }
    return nil;
}

#pragma mark - UITableViewDataSource

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
    return [[self.spots[row] capitalizedString] description]; // description
}

// a helper method that looks in the Model for the photo dictionary at the given row
//  and gets the owner of the photo out of it

- (NSString *)subtitleForRow:(NSUInteger)row
{
    NSArray *photos = [self.tags valueForKey:self.spots[row]];
    if (photos) {
        return [NSString stringWithFormat:@"%d photos", [photos count]];
    } else {
        return @"No photos.";
    }
}

// loads up a table view cell with the title and owner of the photo at the given row in the Model

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SPoT Tag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Show Photos"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setPhotos:)]) {
                    NSArray *photos = self.tags[self.spots[indexPath.row]];
                    // sort photos alphabetically
                    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:FLICKR_PHOTO_TITLE ascending:YES];
                    NSArray *sortedPhotos = [photos sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
                    [segue.destinationViewController performSelector:@selector(setPhotos:) withObject:sortedPhotos];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                }
            }
        }
    }
}


@end
