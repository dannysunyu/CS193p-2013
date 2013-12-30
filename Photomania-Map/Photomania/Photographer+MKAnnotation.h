//
//  Photographer+MKAnnotation.h
//  Photomania
//
//  Created by 孙 昱 on 13-12-29.
//  Copyright (c) 2013年 Stanford University. All rights reserved.
//

#import "Photographer.h"
#import <MapKit/MapKit.h>

@interface Photographer (MKAnnotation)

// this is not part of the MKAnnotation protocol
// but we implement it at the urging of MapViewController's header file
// it just picks a random thumbnail from this photographer's photos

- (UIImage *)thumbnail;  // blocks!

@end
