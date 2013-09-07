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
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
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
    return ([self.symbol isEqualToString:setCardOne.symbol] &&
            [self.symbol isEqualToString:setCardTwo.symbol] &&
            [setCardOne.symbol isEqualToString:setCardTwo.symbol]) ||
    (![self.symbol isEqualToString:setCardOne.symbol] &&
     ![self.symbol isEqualToString:setCardTwo.symbol] &&
     ![setCardOne.symbol isEqualToString:setCardTwo.symbol]);
}

- (BOOL)hasSameOrDifferentShadings:(NSArray *)setCards
{
    SetCard *setCardOne = (SetCard *)setCards[0];
    SetCard *setCardTwo = (SetCard *)setCards[1];
    return ([self.shading isEqualToString:setCardOne.shading] &&
            [self.shading isEqualToString:setCardTwo.shading] &&
            [setCardOne.shading isEqualToString:setCardTwo.shading]) ||
    (![self.shading isEqualToString:setCardOne.shading] &&
     ![self.shading isEqualToString:setCardTwo.shading] &&
     ![setCardOne.shading isEqualToString:setCardTwo.shading]);
}

- (BOOL)hasSameOrDifferentColors:(NSArray *)setCards
{
    SetCard *setCardOne = (SetCard *)setCards[0];
    SetCard *setCardTwo = (SetCard *)setCards[1];
    return ([self.color isEqualToString:setCardOne.color] &&
            [self.color isEqualToString:setCardTwo.color] &&
            [setCardOne.color isEqualToString:setCardTwo.color]) ||
    (![self.color isEqualToString:setCardOne.color] &&
     ![self.color isEqualToString:setCardTwo.color] &&
     ![setCardOne.color isEqualToString:setCardTwo.color]);
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (NSString *)contents
{
    return [NSString stringWithFormat:@"%d %@ %@ %@", self.number, self.symbol, self.shading, self.color];
}

- (NSString *)description
{
    return [self contents];
}

@end
