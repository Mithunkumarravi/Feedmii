//
//  MyOpenOrderViewController.h
//  Boldo
//
//  Created by mithun ravi on 13/08/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderListCell.h"
#import "MyCustomeClass.h"
#import "CardViewController.h"
#import "ProductCell.h"

@interface MyOpenOrderViewController : UIViewController<WebServiceHelperDelegate>
{
    IBOutlet UITableView *orderTable;
    IBOutlet UIView *itemView;
    IBOutlet UITableView *itemTable;
    MyOrderListCell *orderCell;
    IBOutlet UILabel *orderNameLabel;
    IBOutlet UILabel *lblMyWallet;
    IBOutlet UILabel *lblPrice;
    IBOutlet UILabel *lblSelect;
    NSUserDefaults *openDefault;
    NSString *move,*orderId;
    NSString *temprestaurantID;
}

@property (nonatomic, strong) NSMutableArray *orderArrayList,*productListArray;
@property (nonatomic, strong) NSMutableArray *resturantArray;
@property (nonatomic, strong) NSMutableArray *sortedArray;
@property (nonatomic, strong) NSString *temprestaurantID;


@end
