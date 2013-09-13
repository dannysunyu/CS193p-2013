//
//  SetCardView.h
//  Matchismo
//
//  Created by 孙 昱 on 13-9-10.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger symbol;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger color;

@property (nonatomic) BOOL faceUp;

@end
