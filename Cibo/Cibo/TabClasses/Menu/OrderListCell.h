//
//  OrderListCell.h
//  Cibo
//
//  Created by mithun ravi on 28/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCell : UITableViewCell
{
    
}
@property (nonatomic, strong) IBOutlet UILabel *itemLabel,*counterLabel,*priceLabel;
@property (nonatomic, strong) IBOutlet UIButton *crossButton;
@property (nonatomic, strong) IBOutlet UIImageView *itemImage;
@property (nonatomic, strong) IBOutlet UILabel *forceModifierLabel;
@property (nonatomic, strong) IBOutlet UILabel *optionModifierLabel;
@property (nonatomic, strong) IBOutlet UIButton *orderPlusButton;

@end
