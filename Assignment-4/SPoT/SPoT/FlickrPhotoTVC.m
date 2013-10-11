//
//  FlickrPhotoTVC.m
//  SPoT
//
//  Created by 孙 昱 on 13-10-1.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "FlickrPhotoTVC.h"
#import "FlickrFetcher.h"


@implementation FlickrPhotoTVC

- (NSString *)titleForRow:(NSUInteger)row
{
    return nil;
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
    return nil;
}

#pragma mark - UITableViewDataSource

// loads up a table view cell with the title and owner of the photo at the given row in the Model

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Flickr Photo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    
    return cell;
}

@end
