//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by 孙 昱 on 13-6-6.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck matchCount:(int)matchCount matchBonus:(int)matchBonous mismatchPenalty:(int)mismatchPenalty flipCost:(int)flipCost;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)removeCardsAtIndexes:(NSIndexSet *)indexSet;

- (Card *)putRandomCardInPlay;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSUInteger numberOfCardsToMatch;
@property (nonatomic, readonly) NSUInteger currentlyCardCount;
@property (nonatomic, readonly) int flipCost;
@property (nonatomic, readonly) int matchBonus;
@property (nonatomic, readonly) int mismatchPenalty;
@property (strong, nonatomic, readonly) NSString *lastFlipResult;
//@property (strong, nonatomic, readonly) NSArray *unplayableCards;

@end
