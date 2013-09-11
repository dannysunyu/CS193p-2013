//
//  SetGameViewController.m
//  Matchismo
//
//  Created by 孙 昱 on 13-6-8.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"

@interface SetGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation SetGameViewController

#define SET_CARD_GAME_FLIP_COST     1
#define SET_CARD_GAME_MATCH_BONUS   3
#define SET_CARD_GAME_MISMATCH_PENALTY  2
#define SET_CARD_GAME_NUMBER_OF_CARDS_TO_MATCH  3

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[SetCardDeck alloc] init]];
        _game.flipCost = SET_CARD_GAME_FLIP_COST;
        _game.matchBonus = SET_CARD_GAME_MATCH_BONUS;
        _game.mismatchPenalty = SET_CARD_GAME_MISMATCH_PENALTY;
        _game.numberOfCardsToMatch = SET_CARD_GAME_NUMBER_OF_CARDS_TO_MATCH;
    }
    return _game;
}

- (void)updateUI
{
    NSMutableAttributedString *descriptionOfLastFlip = [[NSMutableAttributedString alloc]
                                                        initWithString:self.game.lastFlipResult ? self.game.lastFlipResult : @""];
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        SetCard *setCard = (SetCard *)card;
        
        NSAttributedString *cardStyledTitle = [self attributedTitleForSetCard:setCard];
        
        [cardButton setAttributedTitle:cardStyledTitle forState:UIControlStateNormal];
        [cardButton setAttributedTitle:cardStyledTitle forState:UIControlStateSelected];
        [cardButton setAttributedTitle:cardStyledTitle forState:UIControlStateSelected|UIControlStateDisabled|UIControlStateNormal];
        
        cardButton.selected = card.isFaceUp;
        if (card.isFaceUp) {
            [cardButton setBackgroundColor:[UIColor lightGrayColor]];
        } else {
            [cardButton setBackgroundColor:[UIColor whiteColor]];
        }
        
        NSRange range = [[descriptionOfLastFlip string] rangeOfString:card.contents];
        if (range.location != NSNotFound) {
            [descriptionOfLastFlip replaceCharactersInRange:range withAttributedString:[self attributedTitleForSetCard:setCard]];            
        }

        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.0 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.messageLabel.attributedText = descriptionOfLastFlip;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    [self updateUI];
}

- (NSString *)getSymbolString:(NSUInteger)symbol
{
    switch (symbol) {
        case 1:
            return @"▲";
        case 2:
            return @"●";
        case 3:
            return @"■";
        default:
            return @"?";
    }
}

- (UIColor *)titleColorOfSetCard:(SetCard *)setCard
{
    NSUInteger color = setCard.color;
    switch (color) {
        case 1:
            return [UIColor greenColor];
        case 2:
            return [UIColor redColor];
        case 3:
            return [UIColor purpleColor];
            
        default:
            return nil;
    }
}

- (NSString *)titleOfSetCard:(SetCard *)setCard
{
    NSString *title = [[NSString alloc] init];
    
    for (int i = 1; i <= [setCard number]; i++) {
        title = [title stringByAppendingString:[self getSymbolString:setCard.symbol]];
    }
    return title;
}

- (UIColor *)titleFillColorOfSetCard:(SetCard *)setCard
{
    UIColor *color = [self titleColorOfSetCard:setCard];
    
    switch (setCard.shading) {
        case 1:
            return color;
        case 2:
            return [color colorWithAlphaComponent:0.1];
        case 3:
            return [color colorWithAlphaComponent:0.0];
        default:
            return nil;
    }
}

- (NSAttributedString *)attributedTitleForSetCard:(SetCard *)setCard
{
    NSString *title = [self titleOfSetCard:setCard];
    NSRange titleRange = NSMakeRange(0, [title length]);
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:title];
    
    UIColor *color = [self titleColorOfSetCard:setCard];
    if (color) {
        [attributedTitle addAttributes:@{ NSForegroundColorAttributeName : color } range:titleRange];
    }
    
    UIColor *alphaColor = [self titleFillColorOfSetCard:setCard];
    if (alphaColor) {
        [attributedTitle addAttributes:@{
            NSForegroundColorAttributeName : alphaColor,
            NSStrokeWidthAttributeName : @-5,
            NSStrokeColorAttributeName : color} range:titleRange];
    }
    
    return attributedTitle;
}



- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)deal
{
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

@end
