//
//  ScanLoyaltyCell.h
//  Cibo
//
//  Created by mithun ravi on 01/05/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanLoyaltyCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *foodImage;
@property (nonatomic, strong) IBOutlet UILabel * addressLable,*phonenoLabel,*distanceLabel;
@property (nonatomic, strong) IBOutlet UIButton *scanButton,*phoneButton,*mapButton;

@end
