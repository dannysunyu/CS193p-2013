//
//  SetCard.m
//  Matchismo
//
//  Created by 孙 昱 on 13-6-9.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()
- (BOOL)hasSameOrDifferentNumbers:(NSArray *)setCards;
- (BOOL)hasSameOrDifferentSymbols:(NSArray *)setCards;
- (BOOL)hasSameOrDifferentShadings:(NSArray *)setCards;
- (BOOL)hasSameOrDifferentColors:(NSArray *)setCards;
@end

@implementation SetCard

@synthesize color = _color;
@synthesize shading = _shading;
@synthesize symbol = _symbol;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 2 &&
        [otherCards[0] isKindOfClass:[SetCard class]] &&
        [otherCards[1] isKindOfClass:[SetCard class]]) {
        
        if ([self hasSameOrDifferentNumbers:otherCards] &&
            [self hasSameOrDifferentSymbols:otherCards] &&
            [self hasSameOrDifferentShadings:otherCards] &&
            [self hasSameOrDifferentColors:otherCards]) {
            score = 3;
        }
    }
    
    return score;
}

+ (NSArray *)validSymbols
{
//    return @[@"diamond", @"squiggle", @"oval"];
//    return @[@"▲", @"●", @"■"];
    return @[@(1), @(2), @(3)];
}

+ (NSArray *)validShadings
{
//    return @[@"solid", @"striped", @"open"];
    return @[@(1), @(2), @(3)];
}

+ (NSArray *)validColors
{
    return @[@(1), @(2), @(3)];
}

+ (NSUInteger) maxNumber
{
    return 3;
}

- (BOOL)hasSameOrDifferentNumbers:(NSArray *)setCards
{
    SetCard *setCardOne = (SetCard *)setCards[0];
    SetCard *setCardTwo = (SetCard *)setCards[1];
    return (self.number == setCardOne.number && self.number == setCardTwo.number) ||
    (self.number != setCardOne.number && self.number != setCardTwo.number && setCardOne.number != setCardTwo.number);
}

- (BOOL)hasSameOrDifferentSymbols:(NSArray *)setCards
{
    SetCard *setCardOne = (SetCard *)setCards[0];
    SetCard *setCardTwo = (SetCard *)setCards[1];
    return (self.symbol == setCardOne.symbol &&
            self.symbol == setCardTwo.symbol &&
            setCardOne.symbol == setCardTwo.symbol) ||
           (self.symbol != setCardOne.symbol &&
            self.symbol != setCardTwo.symbol &&
            setCardOne.symbol != setCardTwo.symbol);
}

- (BOOL)hasSameOrDifferentShadings:(NSArray *)setCards
{
    SetCard *setCardOne = (SetCard *)setCards[0];
    SetCard *setCardTwo = (SetCard *)setCards[1];
    return (self.shading == setCardOne.shading &&
            self.shading == setCardTwo.shading &&
            setCardOne.shading == setCardTwo.shading) ||
           (self.shading != setCardOne.shading &&
            self.shading != setCardTwo.shading &&
            setCardOne.shading != setCardTwo.shading);
}

- (BOOL)hasSameOrDifferentColors:(NSArray *)setCards
{
    SetCard *setCardOne = (SetCard *)setCards[0];
    SetCard *setCardTwo = (SetCard *)setCards[1];
    return (self.color == setCardOne.color &&
            self.color == setCardTwo.color &&
            setCardOne.color == setCardTwo.color) ||
           (self.color != setCardOne.color &&
            self.color != setCardTwo.color &&
            setCardOne.color != setCardTwo.color);
}

- (void)setSymbol:(NSUInteger)symbol
{
    if ([[SetCard validSymbols] containsObject:@(symbol)]) {
        _symbol = symbol;
    }
}

- (NSUInteger)symbol
{
    return _symbol ? _symbol : 0;
}

- (void)setShading:(NSUInteger)shading
{
    if ([[SetCard validShadings] containsObject:@(shading)]) {
        _shading = shading;
    }
}

- (NSUInteger)shading
{
    return _shading ? _shading : 0;
}

- (void)setColor:(NSUInteger)color
{
    if ([[SetCard validColors] containsObject:@(color)]) {
        _color = color;
    }
}

- (NSUInteger)color
{
    return _color ? _color : 0;
}

- (NSString *)contents
{
    return [NSString stringWithFormat:@"%d %d %d %d", self.number, self.symbol, self.shading, self.color];
}

- (NSString *)description
{
    return [self contents];
}

@end
