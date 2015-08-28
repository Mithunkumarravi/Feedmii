//
//  BillOverviewViewCell.m
//  Restaurant Cibo
//
//  Created by Naveen Rajput on 25/07/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import "BillOverviewViewCell.h"

@implementation BillOverviewViewCell
@synthesize lblItemName;
@synthesize lblItemPrice;
@synthesize lblsubItemName;
@synthesize lblCount;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
