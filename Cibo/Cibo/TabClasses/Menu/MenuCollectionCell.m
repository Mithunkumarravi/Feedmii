//
//  MenuCollectionCell.m
//  BBQ
//
//  Created by mithun ravi on 29/08/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import "MenuCollectionCell.h"

@implementation MenuCollectionCell

@synthesize itemNameLabel,itemPriceLabel,itemImage;
@synthesize plusButton;
@synthesize priceBackground;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
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
