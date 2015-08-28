//
//  OfferViewController.h
//  Vegan
//
//  Created by mithun ravi on 15/02/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfferTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MyCustomeClass.h"

@interface OfferViewController : UIViewController<WebServiceHelperDelegate>
{
    IBOutlet UITableView *offerTable;
    IBOutlet UILabel *offerTitle;
    NSString *offerDiscount;
    NSString *offerAmount;
    NSString *offerPoints;
    NSString *selectedOfferID;
    IBOutlet UILabel *lblTitle;
}

@property (nonatomic, strong) NSMutableArray *offerArray;
@property (nonatomic, strong) NSString *restaurantID;

@end
