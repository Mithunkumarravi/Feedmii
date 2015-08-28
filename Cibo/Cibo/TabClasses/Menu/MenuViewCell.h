//
//  MenuViewCell.h
//  Cibo
//
//  Created by mithun ravi on 28/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewCell : UITableViewCell
{
    
}
@property (nonatomic, strong) IBOutlet UILabel *itemNameLabel,*itemPriceLabel,*descripLavel;
@property (nonatomic, strong) IBOutlet UIButton *plusButton;
@property (nonatomic, strong) IBOutlet UIImageView *itemImage;
@property (nonatomic, strong) IBOutlet UIImageView *priceBackground;

@end
