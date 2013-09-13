//
//  SetCardView.m
//  Matchismo
//
//  Created by 孙 昱 on 13-9-10.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#pragma mark - Properties

- (void)setNumber:(NSUInteger)number
{
    _number = number;
    [self setNeedsDisplay];
}

- (void)setSymbol:(NSUInteger)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setShading:(NSUInteger)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setColor:(NSUInteger)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)isFaceUp
{
    _faceUp = isFaceUp;
    [self setNeedsDisplay];
}


#pragma mark - Drawing

#define CORNER_RADIUS 12.0
#define SYMBOL_WIDTH_SCALE_FACTOR 0.6
#define SYMBOL_HEIGHT_SCALE_FACTOR 0.2
#define SYMBOL_VERTICAL_DISTANCE_FACTOR 0.1

#define SHADING_ALPHA_COMPONENT 0.1

- (NSArray *)validSymbolColors
{
    return @[[UIColor clearColor], [UIColor greenColor], [UIColor redColor], [UIColor purpleColor]];
}

- (UIColor *)translateColor
{
    return [self validSymbolColors][self.color];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    
    [roundedRect addClip];
    
    if (self.faceUp) {
        [[UIColor lightGrayColor] setFill];
        UIRectFill(self.bounds);
    } else {
        [[UIColor whiteColor] setFill];
        UIRectFill(self.bounds);
    }
    
    [self drawSet];
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

- (void)drawSet
{
    CGSize symbolSize = CGSizeMake(self.bounds.size.width * SYMBOL_WIDTH_SCALE_FACTOR, self.bounds.size.height * SYMBOL_HEIGHT_SCALE_FACTOR);
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat verticalDistanceBetweenSymbols = self.bounds.size.height * SYMBOL_VERTICAL_DISTANCE_FACTOR;
    
    switch (self.number) {
        case 1: {
            CGPoint singleOrigin = CGPointMake(center.x - symbolSize.width * 0.5, center.y - symbolSize.height * 0.5);
            if (self.symbol == 1) {
                [self drawDiamondWithOrigin:singleOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
            } else if (self.symbol == 2) {
                [self drawOvalWithOrigin:singleOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
            } else if (self.symbol == 3) {
                [self drawSquiggleWithOrigin:singleOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
            }
            break;
        }
        case 2: {
            CGPoint upperOrigin = CGPointMake(center.x - symbolSize.width * 0.5, center.y - symbolSize.height - 0.5 *  verticalDistanceBetweenSymbols);
            CGPoint lowerOrigin = CGPointMake(center.x - symbolSize.width * 0.5, center.y + verticalDistanceBetweenSymbols * 0.5);
            if (self.symbol == 1) {
                [self drawDiamondWithOrigin:upperOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
                [self drawDiamondWithOrigin:lowerOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
            } else if (self.symbol == 2) {
                [self drawOvalWithOrigin:upperOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
                [self drawOvalWithOrigin:lowerOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
            } else if (self.symbol == 3) {
                [self drawSquiggleWithOrigin:upperOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
                [self drawSquiggleWithOrigin:lowerOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
            }
            break;
        }
            
        case 3: {
            CGPoint middleOrigin = CGPointMake(center.x - symbolSize.width * 0.5 , center.y - symbolSize.height * 0.5);
            CGPoint firstOrigin = CGPointMake(center.x - symbolSize.width * 0.5, center.y - symbolSize.height * 0.5 - verticalDistanceBetweenSymbols - symbolSize.height);
            CGPoint lastOrigin = CGPointMake(center.x - symbolSize.width * 0.5, center.y + symbolSize.height * 0.5 + verticalDistanceBetweenSymbols);
            if (self.symbol == 1) {
                [self drawDiamondWithOrigin:firstOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
                [self drawDiamondWithOrigin:middleOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
                [self drawDiamondWithOrigin:lastOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
            } else if (self.symbol == 2) {
                [self drawOvalWithOrigin:firstOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
                [self drawOvalWithOrigin:middleOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
                [self drawOvalWithOrigin:lastOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
            } else if (self.symbol == 3) {
                [self drawSquiggleWithOrigin:firstOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
                [self drawSquiggleWithOrigin:middleOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
                [self drawSquiggleWithOrigin:lastOrigin size:symbolSize color:[self translateColor] shading:[self shading]];
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)drawSymbol:(NSUInteger)symbol withColor:(UIColor *)color origin:(CGPoint)origin size:(CGSize)size
{
    
}

- (void)drawDiamondWithOrigin:(CGPoint)origin size:(CGSize)size color:(UIColor *)color shading:(NSUInteger)shading
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(origin.x + size.width * 0.5, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x, origin.y + size.height * 0.5)];
    [path addLineToPoint:CGPointMake(origin.x + size.width * 0.5, origin.y + size.height)];
    [path addLineToPoint:CGPointMake(origin.x + size.width, origin.y + size.height * 0.5)];
    
    [path closePath];
    
    if (shading == 1) { // solid
        [color setFill];
        [path fill];
    } else if (shading == 2) { // striped
        [color setStroke];
        UIColor *shadingColor = [color colorWithAlphaComponent:SHADING_ALPHA_COMPONENT];
        [shadingColor setFill];
        [path fill];
        [path stroke];
    } else if (shading == 3) { // open
        [color setStroke];
        [path stroke];
    }
}



- (void)drawOvalWithOrigin:(CGPoint)origin size:(CGSize)size color:(UIColor *)color shading:(NSUInteger)shading
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(origin.x, origin.y, size.width, size.height) cornerRadius:CORNER_RADIUS];
    
    if (shading == 1) { // solid
        [color setFill];
        [path fill];
    } else if (shading == 2) { // striped
        [color setStroke];
        UIColor *shadingColor = [color colorWithAlphaComponent:SHADING_ALPHA_COMPONENT];
        [shadingColor setFill];
        [path fill];
        [path stroke];
    } else if (shading == 3) { // open
        [color setStroke];
        [path stroke];
    }
}

- (void)drawSquiggleWithOrigin:(CGPoint)origin size:(CGSize)size color:(UIColor *)color shading:(NSUInteger)shading
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(origin.x, origin.y, size.width, size.height)];
    
    if (shading == 1) { // solid
        [color setFill];
        [path fill];
    } else if (shading == 2) { // striped
        [color setStroke];
        UIColor *shadingColor = [color colorWithAlphaComponent:SHADING_ALPHA_COMPONENT];
        [shadingColor setFill];
        [path fill];
        [path stroke];
    } else if (shading == 3) { // open
        [color setStroke];
        [path stroke];
    }
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    // do initialization here
}

@end
