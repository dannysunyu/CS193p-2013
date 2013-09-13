//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by 孙 昱 on 13-9-9.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "SetCardCollectionViewCell.h"

#define SET_GAME_STARTING_CARD_COUNT 12
#define SET_GAME_CARD_MATCH_COUNT 3
#define SET_GAME_FLIP_COST 1
#define SET_GAME_MATCH_BONUS 3
#define SET_GAME_MISMATCH_PENALTY 2

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSUInteger)startingCardCount
{
    return SET_GAME_STARTING_CARD_COUNT;
}

- (NSUInteger)numberOfCardsToMatch
{
    return SET_GAME_CARD_MATCH_COUNT;
}

- (NSUInteger)flipCost
{
    return SET_GAME_FLIP_COST;
}

- (NSUInteger)matchBonus
{
    return SET_GAME_MATCH_BONUS;
}

- (NSUInteger)mismatchPenalty
{
    return SET_GAME_MISMATCH_PENALTY;
}

- (NSString *)cellIdentifier
{
    return @"SetCard";
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]]) {
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            setCardView.number = setCard.number;
            setCardView.symbol = setCard.symbol;
            setCardView.shading = setCard.shading;
            setCardView.color = setCard.color;
            
            setCardView.faceUp = setCard.faceUp;
        }
        
    }
}

@end
