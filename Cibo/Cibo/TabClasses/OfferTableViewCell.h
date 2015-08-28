//
//  OfferTableViewCell.h
//  Vegan
//
//  Created by mithun ravi on 15/02/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferTableViewCell : UITableViewCell
{
    
}
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImage,*logoImage;
@property (nonatomic, strong) IBOutlet UILabel *detailLabel,*codeLebel,*percentOffer;

@end
