//
//  SplitBillViewController.h
//  Restaurant Cibo
//
//  Created by Naveen Rajput on 27/07/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplitBillViewCell.h"

@interface SplitBillViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblSplitBill;
    IBOutlet UIImageView *imgBGPatti;
    IBOutlet UIButton *btnCheckOut;
    IBOutlet UILabel *lblTatalAmount;
}
@property (nonatomic, strong) NSMutableArray *arrItemOrder;
@property (nonatomic, strong) NSMutableArray *spliteBillArray;
@property(assign,nonatomic)float orderAmount;

@end
