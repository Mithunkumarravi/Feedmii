//
//  LoyaltyCell.h
//  Cibo
//
//  Created by mithun ravi on 30/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoyaltyCell : UITableViewCell<UIScrollViewDelegate>
@property (nonatomic, strong) IBOutlet UIImageView *foodImage;
@property (nonatomic, strong) IBOutlet UIButton *yellowRebanButton,*locationButton,*purchageButton;
@property (nonatomic, strong) IBOutlet UILabel *loyaltreeLabel,*numberLable,*distancLable,*codeLabel,*discountLabel,*discountPersent,*descriptionLabel;
@property (nonatomic, strong) IBOutlet UIButton *sliderCell;
@property (nonatomic, strong) IBOutlet UIView *cellSubView;


@end
