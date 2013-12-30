//
//  Photo.h
//  Photomania
//
//  Created by 孙 昱 on 13-12-29.
//  Copyright (c) 2013年 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * thumbnailURLString;
@property (nonatomic, retain) Photographer *whoTook;

@end
