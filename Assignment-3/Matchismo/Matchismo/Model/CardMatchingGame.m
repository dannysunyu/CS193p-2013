//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by 孙 昱 on 13-6-6.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) NSMutableArray *cards;
@property (readwrite, nonatomic) int score;
@property (strong, readwrite, nonatomic) NSString *lastFlipResult;
@end

@implementation CardMatchingGame

#define DEFAULT_FLIP_COST 1
#define DEFAULT_MISMATCH_PENALTY 2
#define DEFAULT_MATCH_BONUS 4
#define DEFAULT_CARD_MATCH_COUNT 2

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSUInteger)currentlyCardCount
{
    return [self.cards count];
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    return [self initWithCardCount:count usingDeck:deck matchCount:DEFAULT_CARD_MATCH_COUNT matchBonus:DEFAULT_MATCH_BONUS mismatchPenalty:DEFAULT_MISMATCH_PENALTY flipCost:DEFAULT_FLIP_COST];
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck matchCount:(int)matchCount matchBonus:(int)bonous mismatchPenalty:(int)penalty flipCost:(int)cost
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
        
        _deck = deck;
        _numberOfCardsToMatch = matchCount;
        _matchBonus = bonous;
        _mismatchPenalty = penalty;
        _flipCost = cost;
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
                        
                        NSLog(@"Matched %@", pendingCard);
                    }
                    card.unplayable = YES;
                    NSLog(@"Matched %@", card);
                    
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

- (void)removeCardsAtIndexes:(NSIndexSet *)indexSet
{
    [self.cards removeObjectsAtIndexes:indexSet];
}

- (Card *)addCardInPlay
{
    Card *card = [self.deck drawRandomCard];
    [self.cards addObject:card];
    return card;
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
