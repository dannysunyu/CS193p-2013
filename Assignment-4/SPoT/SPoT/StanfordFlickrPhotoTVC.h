//
//  StanfordFlickrPhotoTVC.h
//  SPoT
//
//  Created by 孙 昱 on 13-10-2.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "FlickrPhotoTVC.h"

@interface StanfordFlickrPhotoTVC : FlickrPhotoTVC

// the Model for this VC
// an array of dictionaries of Flickr information
// obtained using Flickr API
// (e.g. FlickrFetcher will obtain such an array of dictionaries)
@property (nonatomic, strong) NSMutableDictionary *tags; // of NSArray

@end
