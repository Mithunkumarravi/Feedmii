//
//  ProductCell.m
//  Boldo
//
//  Created by mithun ravi on 14/08/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell
@synthesize priceLabel;
@synthesize nameLabel;
@synthesize modifierLabel;
@synthesize quantitiyLabel;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
