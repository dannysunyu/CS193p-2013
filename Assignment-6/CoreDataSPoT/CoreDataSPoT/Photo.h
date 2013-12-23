//
//  Photo.h
//  CoreDataSPoT
//
//  Created by 孙 昱 on 13-12-22.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Spot;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) NSString * thumbnailURL;
@property (nonatomic, retain) NSDate * lastViewed;
@property (nonatomic, retain) NSData * thumbnailData;
@property (nonatomic, retain) Spot *takenAt;

@end
