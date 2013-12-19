//
//  Spot+Create.m
//  CoreDataSPoT
//
//  Created by 孙 昱 on 13-12-19.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "Spot+Create.h"

@implementation Spot (Create)

+ (Spot *)spotWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context
{
    Spot *spot = nil;
    
    // This is just like Photo(Flickr)'s method.  Look there for commentary.
    
    if (name.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Spot"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || [matches count] > 1) {
            // handle error
        } else if (![matches count]) {
            spot = [NSEntityDescription insertNewObjectForEntityForName:@"Spot" inManagedObjectContext:context];
            spot.name = name;
        } else {
            spot = [matches lastObject];
        }
    }
    
    return spot;
}

@end
