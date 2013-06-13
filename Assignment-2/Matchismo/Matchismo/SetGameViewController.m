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

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (nonatomic) int flipCount;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
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
        
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.0 : 1.0;
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.messageLabel.text = (self.game.lastFlipResult) ? [NSString stringWithFormat:@"%@", self.game.lastFlipResult] : @"";
}

- (UIColor *)colorOfSetCard:(SetCard *)setCard
{
    NSString *color = setCard.color;
    if ([color isEqualToString:@"green"]) {
        return [UIColor greenColor];
    } else if ([color isEqualToString:@"red"]) {
        return [UIColor redColor];
    } else if ([color isEqualToString:@"purple"]) {
        return [UIColor blueColor];
    } else {
        return nil;
    }
}

- (NSString *)titleOfSetCard:(SetCard *)setCard
{
    NSString *title = [[NSString alloc] init];
    
    for (int i = 1; i <= [setCard number]; i++) {
        title = [title stringByAppendingString:setCard.symbol];
    }
    return title;
}

- (NSAttributedString *)attributedTitleForSetCard:(SetCard *)setCard
{
    NSString *title = [self titleOfSetCard:setCard];
    NSRange titleRange = NSMakeRange(0, [title length]);
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:title];
    
    UIColor *color = [self colorOfSetCard:setCard];    
    if (color) {
        [attributedTitle addAttributes:@{ NSForegroundColorAttributeName : color } range:titleRange];
    }
    
    if ([setCard.shading isEqualToString:@"striped"]) {
        [attributedTitle addAttributes:@{ NSForegroundColorAttributeName : [color colorWithAlphaComponent:0.1],
           NSStrokeWidthAttributeName : @-5, NSStrokeColorAttributeName : color} range:titleRange];
    } else if ([setCard.shading isEqualToString:@"open"]) {
        [attributedTitle addAttributes:@{ NSForegroundColorAttributeName : [color colorWithAlphaComponent:0.0],
           NSStrokeWidthAttributeName : @-5, NSStrokeColorAttributeName : color} range:titleRange];
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
