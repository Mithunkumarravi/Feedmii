//
//  CardTableViewCell.m
//  Feedmii
//
//  Created by mithun ravi on 24/03/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import "CardTableViewCell.h"

@implementation CardTableViewCell
@synthesize nameLabel;
@synthesize priceLabel;
@synthesize modifire;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
