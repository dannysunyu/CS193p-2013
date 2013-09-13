//
//  SetCardCollectionViewCell.h
//  Matchismo
//
//  Created by 孙 昱 on 13-9-10.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCardView.h"

@interface SetCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet SetCardView *setCardView;
@end
