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

#define PLAYING_CARD_GAME_STARTING_CARD_COUNT    22
#define PLAYING_CARD_GAME_NUMBER_OF_CARDS_TO_MATCH    2
#define PLAYING_CARD_GAME_FLIP_COST    1
#define PLAYING_CARD_GAME_MATCH_BONUS    4
#define PLAYING_CARD_GAME_MISMATCH_PENALTY    2

#define PLAYING_CARD_CELL_IDENTIFIER    @"PlayingCard"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)startingCardCount
{
    return PLAYING_CARD_GAME_STARTING_CARD_COUNT;
}

- (NSUInteger)numberOfCardsToMatch
{
    return PLAYING_CARD_GAME_NUMBER_OF_CARDS_TO_MATCH;
}

- (NSUInteger)flipCost
{
    return PLAYING_CARD_GAME_FLIP_COST;
}

- (NSUInteger)matchBonus
{
    return PLAYING_CARD_GAME_MATCH_BONUS;
}

- (NSUInteger)mismatchPenalty
{
    return PLAYING_CARD_GAME_MISMATCH_PENALTY;
}

- (NSString *)cellIdentifier
{
    return PLAYING_CARD_CELL_IDENTIFIER;
}

- (BOOL)shouldRemoveUnplayableCards
{
    return NO;
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
