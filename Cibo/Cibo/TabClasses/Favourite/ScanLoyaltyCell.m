//
//  ScanLoyaltyCell.m
//  Cibo
//
//  Created by mithun ravi on 01/05/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "ScanLoyaltyCell.h"

@implementation ScanLoyaltyCell
@synthesize foodImage;
@synthesize scanButton,phoneButton,mapButton;
@synthesize addressLable,phonenoLabel,distanceLabel;

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
