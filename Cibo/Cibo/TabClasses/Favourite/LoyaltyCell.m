//
//  LoyaltyCell.m
//  Cibo
//
//  Created by mithun ravi on 30/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "LoyaltyCell.h"

@implementation LoyaltyCell
@synthesize foodImage;
@synthesize yellowRebanButton,locationButton,purchageButton;
@synthesize loyaltreeLabel,numberLable,distancLable;
@synthesize sliderCell;
@synthesize codeLabel;
@synthesize descriptionLabel;
@synthesize cellSubView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}





@end
