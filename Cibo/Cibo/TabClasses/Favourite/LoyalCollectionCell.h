//
//  LoyalCollectionCell.h
//  BBQ
//
//  Created by mithun ravi on 29/08/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoyalCollectionCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UIImageView *foodImage;
@property (nonatomic, strong) IBOutlet UIButton *yellowRebanButton,*locationButton,*purchageButton;
@property (nonatomic, strong) IBOutlet UILabel *loyaltreeLabel,*numberLable,*distancLable,*codeLabel,*discountLabel,*discountPersent,*descriptionLabel;
@property (nonatomic, strong) IBOutlet UIButton *sliderCell;

@end
