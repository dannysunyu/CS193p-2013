//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by 孙 昱 on 13-9-9.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSUInteger)startingCardCount
{
    return 12;
}

- (NSUInteger)numberOfCardsToMatch
{
    return 3;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    
}

@end
