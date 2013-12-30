//
//  Photo+MKAnnotation.m
//  Photomania
//
//  Created by 孙 昱 on 13-12-29.
//  Copyright (c) 2013年 Stanford University. All rights reserved.
//

#import "Photo+MKAnnotation.h"

@implementation Photo (MKAnnotation)

// Photo already implements two of the MKAnnotation methods
//   title and subtitle
// this is the implementation of the third (required) method

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.latitude doubleValue];
    coordinate.longitude = [self.longitude doubleValue];
    return coordinate;
}

// MapViewController likes annotations to implement this

- (UIImage *)thumbnail
{
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.thumbnailURLString]]];
}

@end
