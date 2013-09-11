//
//  SetCard.h
//  Matchismo
//
//  Created by 孙 昱 on 13-6-9.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "Card.h"

typedef NS_ENUM(NSUInteger, SetSymbol) {
    SetSymbolDiamond,
    SetSymbolSquiggle,
    SetSymbolOval
};

typedef NS_ENUM(NSUInteger, SetShading) {
    SetShadingSolid,
    SetShadingStriped,
    SetShadingOpen
};

typedef NS_ENUM(NSUInteger, SetColor) {
    SetColorNone,
    SetColorRed,
    SetColorGreen,
    SetColorPurple
};

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;

+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

+ (NSUInteger)maxNumber;

@end
