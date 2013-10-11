//
//  FlickrPhotoTVC.h
//  SPoT
//
//  Created by 孙 昱 on 13-10-1.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface FlickrPhotoTVC : UITableViewController

- (NSString *)titleForRow:(NSUInteger)row;
- (NSString *)subtitleForRow:(NSUInteger)row;

@end
