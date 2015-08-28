//
//  EventCell.m
//  Cibo
//
//  Created by mithun ravi on 21/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell
@synthesize plusButton;
@synthesize titleLable,descriptionLabel;
@synthesize foodImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        descriptionLabel.backgroundColor=[UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
