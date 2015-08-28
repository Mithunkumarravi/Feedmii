//
//  NoRebanLoyaltyCell.m
//  Cibo
//
//  Created by mithun ravi on 01/05/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "NoRebanLoyaltyCell.h"

@implementation NoRebanLoyaltyCell
@synthesize foodImage;
@synthesize rewardLable;

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
