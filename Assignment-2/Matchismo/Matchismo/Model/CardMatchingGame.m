//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by 孙 昱 on 13-6-6.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (readwrite, nonatomic) int score;
@property (strong, readwrite, nonatomic) NSString *lastFlipResult;
@end

@implementation CardMatchingGame

#define DEFAULT_FLIP_COST 1
#define DEFAULT_MISMATCH_PENALTY 2
#define DEFAULT_MATCH_BONUS 4

- (int)matchBonus
{
    if (!_matchBonus) _matchBonus = DEFAULT_MATCH_BONUS;
    return _matchBonus;
}

- (int)flipCost
{
    if (!_flipCost) _flipCost = DEFAULT_FLIP_COST;
    return _flipCost;
}

- (int)mismatchPenalty
{
    if (!_mismatchPenalty) _mismatchPenalty = DEFAULT_MISMATCH_PENALTY;
    return _mismatchPenalty;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.lastFlipResult = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            NSArray *pendingCards = [self otherCardsPendingForMatch];
            if ([pendingCards count] == self.numberOfCardsToMatch - 1) {
                int matchScore = [card match:pendingCards];
                if (matchScore) {
                    for (id otherCard in pendingCards) {
                        Card *pendingCard = (Card *)otherCard;
                        pendingCard.unplayable = YES;
                    }
                    card.unplayable = YES;
                    
                    self.lastFlipResult = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, [pendingCards componentsJoinedByString:@" & "], (matchScore * self.matchBonus)];
                    
                    self.score += matchScore * self.matchBonus;
                } else {
                    for (id otherCard in pendingCards) {
                        Card *pendingCard = (Card *)otherCard;
                        pendingCard.faceUp = NO;
                    }
                    
                    self.lastFlipResult = [NSString stringWithFormat:@"%@ and %@ don't match! %d points penalty!", card.contents, [pendingCards componentsJoinedByString:@" & "], self.mismatchPenalty];
                    self.score -= self.mismatchPenalty;
                }
            }
            
            self.score -= self.flipCost;
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (NSArray *)otherCardsPendingForMatch
{
    NSMutableArray *pendingCards = [[NSMutableArray alloc] init];
    
    for (Card *otherCard in self.cards) {
        if (otherCard.isFaceUp && !otherCard.isUnplayable) {
            [pendingCards addObject:otherCard];
        }
    }
    
    return pendingCards;
}


@end
