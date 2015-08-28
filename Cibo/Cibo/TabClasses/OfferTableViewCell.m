//
//  OfferTableViewCell.m
//  Vegan
//
//  Created by mithun ravi on 15/02/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import "OfferTableViewCell.h"

@implementation OfferTableViewCell
@synthesize backgroundImage;
@synthesize logoImage;
@synthesize detailLabel;
@synthesize codeLebel;
@synthesize percentOffer;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
