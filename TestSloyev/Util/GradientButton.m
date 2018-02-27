//
//  GradientButton.m
//  TestSloyev
//
//  Created by Bodya on 21.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

#import "GradientButton.h"

@implementation GradientButton

- (void)drawRect:(CGRect)rect {
    [self addGradient];
}

- (void)addGradient {
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.frame = self.layer.bounds;
    gradientLayer.colors = @[
                             (id)[UIColor colorWithRed:81.0/255.0 green:122.0/255.0 blue:247.0/255.0 alpha:1].CGColor,
                             (id)[UIColor colorWithRed:73.0/255.0 green:221.0/255.0 blue:254.0/255.0 alpha:1].CGColor
                             ];
    gradientLayer.startPoint = CGPointMake(0.0,1.0);
    gradientLayer.endPoint = CGPointMake(1.0,0.0);
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
}


@end
