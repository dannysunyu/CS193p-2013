//
//  Spot+Create.h
//  CoreDataSPoT
//
//  Created by 孙 昱 on 13-12-19.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "Spot.h"

@interface Spot (Create)

+ (Spot *)spotWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

@end
