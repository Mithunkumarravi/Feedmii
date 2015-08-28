//
//  BillOverviewController.h
//  Restaurant Cibo
//
//  Created by Naveen Rajput on 25/07/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillOverviewViewCell.h"
#import "MoveBillOverView_ViewController.h"

@interface BillOverviewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblBillOverview;
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnYES, *btnNo;
    IBOutlet UIImageView *imgBGPatti;
    IBOutlet UILabel *labelOrderName;
    IBOutlet UILabel *labelOrderAmount;
}

@property(strong,nonatomic)NSMutableArray *arrProductList;
@property(assign,nonatomic)int splitCount;
@property(assign,nonatomic)float orderAmount;
@property(strong,nonatomic)NSString *strOrderName;
@property(strong,nonatomic)NSString *order_location;
@property (strong, nonatomic)NSString *orderID;
@property (strong, nonatomic) NSDictionary *selectedOrderDetail;

@end
