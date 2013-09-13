//
//  CardGameViewController.m
//  Matchismo
//
//  Created by 孙 昱 on 13-9-8.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) GameResult *gameResult;

@end

@implementation CardGameViewController

#pragma mark - Properties

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                  usingDeck:[self createDeck]];
        _game.numberOfCardsToMatch = self.numberOfCardsToMatch;
        _game.flipCost = self.flipCost;
        _game.matchBonus = self.matchBonus;
        _game.mismatchPenalty = self.mismatchPenalty;
    }
    return _game;
}

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

// abstract
- (Deck *)createDeck
{
    return nil;
}

// abstract
- (NSUInteger)numberOfCardsToMatch
{
    return 0;
}

- (NSUInteger)matchBonus
{
    return 0;
}

- (NSUInteger)mismatchPenalty
{
    return 0;
}

- (NSString *)cellIdentifier
{
    return nil;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)asker
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

// abstract
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
  
}

#pragma mark - Updating the UI

- (void)updateUI
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

#define pragma mark - Target/Action/Gestures
- (IBAction)deal:(UIButton *)sender
{
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        self.flipCount++;
        [self updateUI];
        self.gameResult.score = self.game.score;
    }
}

@end
