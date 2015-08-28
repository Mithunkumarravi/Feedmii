//
//  MyOrderListCell.m
//  Boldo
//
//  Created by mithun ravi on 13/08/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import "MyOrderListCell.h"

@implementation MyOrderListCell
@synthesize priceLable;
@synthesize OrderNameLable;
@synthesize itemListButton;

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
