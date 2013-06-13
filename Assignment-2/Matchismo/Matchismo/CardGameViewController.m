//
//  CardGameViewController.m
//  Matchismo
//
//  Created by 孙 昱 on 13-6-4.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@end

@implementation CardGameViewController

#define PLAYING_CARD_GAME_FLIP_COST 1
#define PLAYING_CARD_GAME_MATCH_BONUS 4
#define PLAYING_CARD_GAME_MISMATCH_PENALTY 2

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
        _game.flipCost = PLAYING_CARD_GAME_FLIP_COST;
        _game.matchBonus = PLAYING_CARD_GAME_MATCH_BONUS;
        _game.mismatchPenalty = PLAYING_CARD_GAME_MISMATCH_PENALTY;
        _game.numberOfCardsToMatch = 2;
    }
    return _game;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
//    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        
        UIImage *cardFrontImage = [[UIImage alloc] init];
        [cardButton setImage:cardFrontImage forState:UIControlStateSelected];
        [cardButton setImage:cardFrontImage forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.imageEdgeInsets = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.messageLabel.text = self.game.lastFlipResult;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateUI];
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
