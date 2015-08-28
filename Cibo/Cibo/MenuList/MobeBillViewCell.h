//
//  MobeBillViewCell.h
//  Restaurant Cibo
//
//  Created by Naveen Rajput on 25/07/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MobeBillViewCell : UITableViewCell
@property(strong,nonatomic)IBOutlet UILabel *lblItemName, *lblItemPrice;
@property (nonatomic,strong) IBOutlet UIButton *chackBoxbutton;
@property (nonatomic, strong) IBOutlet UILabel *lblCount;

@end
