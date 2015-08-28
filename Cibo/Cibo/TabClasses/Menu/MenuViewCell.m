//
//  MenuViewCell.m
//  Cibo
//
//  Created by mithun ravi on 28/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "MenuViewCell.h"

@implementation MenuViewCell
@synthesize itemNameLabel,itemPriceLabel,itemImage;
@synthesize plusButton;
@synthesize priceBackground;
@synthesize descripLavel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
