//
//  OptionModifierCell.m
//  Cibo Digital Menu
//
//  Created by mithun ravi on 16/09/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "OptionModifierCell.h"

@implementation OptionModifierCell
@synthesize nameLabel,chackBoxbutton;
@synthesize priceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
