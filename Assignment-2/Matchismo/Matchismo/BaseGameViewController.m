//
//  BaseGameViewController.m
//  Matchismo
//
//  Created by 孙 昱 on 13-8-29.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "BaseGameViewController.h"

@interface BaseGameViewController ()

@end

@implementation BaseGameViewController

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
}

@end
