//
//  CardGameViewController.h
//  Matchismo
//
//  Created by 孙 昱 on 13-9-8.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// all of the following methods must be overriden by concrete subclasses

- (Deck *)createDeck;

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card;

@property (readonly, nonatomic) NSUInteger startingCardCount;
@property (readonly, nonatomic) NSUInteger numberOfCardsToMatch;

@end
