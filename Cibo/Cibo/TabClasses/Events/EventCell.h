//
//  EventCell.h
//  Cibo
//
//  Created by mithun ravi on 21/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell
{
    
}
@property (nonatomic,strong) IBOutlet UILabel *titleLable;
@property (nonatomic, strong) IBOutlet UIImageView *foodImage;
@property (nonatomic, strong) IBOutlet UIButton *plusButton;
@property (nonatomic, strong) IBOutlet UITextView *descriptionLabel;

@end
