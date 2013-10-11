//
//  StanfordSpotFlickrPhotoTVC.m
//  SPoT
//
//  Created by 孙 昱 on 13-10-2.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "StanfordSpotFlickrPhotoTVC.h"
#import "FlickrFetcher.h"

@interface StanfordSpotFlickrPhotoTVC ()

@end

@implementation StanfordSpotFlickrPhotoTVC

- (NSString *)titleForRow:(NSUInteger)row
{
    NSDictionary *photo = self.spots[row];
    return [photo valueForKey:FLICKR_PHOTO_TITLE];
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
    NSDictionary *photo = self.spots[row];
    return [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

// lets the UITableView know how many rows it should display
// in this case, just the count of dictionaries in the Model's array

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.spots count];
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
                    NSDictionary *photo = self.spots[indexPath.row];
                    NSURL *url = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatLarge];
                    [segue.destinationViewController performSelector:@selector(setImageURL:) withObject:url];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                }
            }
        }
    }
    
}


@end
