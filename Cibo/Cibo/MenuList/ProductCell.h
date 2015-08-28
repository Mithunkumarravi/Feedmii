//
//  ProductCell.h
//  Boldo
//
//  Created by mithun ravi on 14/08/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell
{
    
}
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *modifierLabel;
@property (nonatomic, strong) IBOutlet UILabel *quantitiyLabel;



@end
