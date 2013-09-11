//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by 孙 昱 on 13-9-9.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"
#import "PlayingCardCollectionViewCell.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)startingCardCount
{
    return 22;
}

- (NSUInteger)numberOfCardsToMatch
{
    return 2;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]]) {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            playingCardView.faceUp = playingCard.isFaceUp;
            playingCardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
        }
    }
}

@end
