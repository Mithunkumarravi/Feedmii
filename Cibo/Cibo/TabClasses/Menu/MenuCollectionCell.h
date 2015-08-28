//
//  MenuCollectionCell.h
//  BBQ
//
//  Created by mithun ravi on 29/08/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCollectionCell : UICollectionViewCell
{
    
}
@property (nonatomic, strong) IBOutlet UILabel *itemNameLabel,*itemPriceLabel;
@property (nonatomic, strong) IBOutlet UIButton *plusButton;
@property (nonatomic, strong) IBOutlet UIImageView *itemImage;
@property (nonatomic, strong) IBOutlet UIImageView *priceBackground;

@end
