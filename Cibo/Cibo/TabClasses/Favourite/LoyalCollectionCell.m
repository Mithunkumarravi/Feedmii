//
//  LoyalCollectionCell.m
//  BBQ
//
//  Created by mithun ravi on 29/08/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import "LoyalCollectionCell.h"

@implementation LoyalCollectionCell
@synthesize foodImage;
@synthesize yellowRebanButton,locationButton,purchageButton;
@synthesize loyaltreeLabel,numberLable,distancLable;
@synthesize sliderCell;
@synthesize codeLabel;
@synthesize descriptionLabel;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
