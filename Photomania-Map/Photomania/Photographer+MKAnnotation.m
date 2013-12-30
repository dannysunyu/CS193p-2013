//
//  Photographer+MKAnnotation.m
//  Photomania
//
//  Created by 孙 昱 on 13-12-29.
//  Copyright (c) 2013年 Stanford University. All rights reserved.
//

#import "Photographer+MKAnnotation.h"


@implementation Photographer (MKAnnotation)

// part of the MKAnnotation protocol

- (NSString *)title
{
    return self.name;
}

// part of the MKAnnotation protocol

- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"%d photos", [self.photos count]];
}

// (required) part of the MKAnnotation protocol
// just picks the location of a random photo by this photographer

- (CLLocationCoordinate2D)coordinate
{
    return [[self.photos anyObject] coordinate];
}

// MapViewController likes annotations to implement this

- (UIImage *)thumbnail
{
    return [[self.photos anyObject] thumbnail];
}

@end
