//
//  Card.m
//  Matchismo
//
//  Created by 孙 昱 on 13-6-5.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
