//
//  MyOpenOrderViewController.m
//  Boldo
//
//  Created by mithun ravi on 13/08/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import "MyOpenOrderViewController.h"

@interface MyOpenOrderViewController ()

@end

@implementation MyOpenOrderViewController
@synthesize orderArrayList;
@synthesize productListArray;
@synthesize resturantArray;
@synthesize sortedArray;
@synthesize temprestaurantID;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    orderArrayList=[[NSMutableArray alloc] init];
    productListArray=[[NSMutableArray alloc] init];
    sortedArray =[[NSMutableArray alloc] init];
    itemView.hidden=YES;
    [MyCustomeClass drawBorder:itemView];
    [orderTable setSeparatorColor:[UIColor clearColor]];
    [itemTable setSeparatorColor:[UIColor brownColor]];
    openDefault=[NSUserDefaults standardUserDefaults];
    [self myOrderListRequest];
    
    lblMyWallet.font=[UIFont fontWithName:FONT_Ragular size:22.0];
    [lblMyWallet setFont: [lblMyWallet.font fontWithSize: 22.0]];
    orderNameLabel.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [orderNameLabel setFont: [orderNameLabel.font fontWithSize: 20.0]];
    
    itemView.layer.cornerRadius = 5;
    itemView.layer.masksToBounds= YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)clickONBackButton:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}
-(void)listOfRestaurant
{
    for (int j = 0; j<resturantArray.count; j++)
    {
        NSMutableDictionary *dataDic =[[NSMutableDictionary alloc] init];
        [dataDic setValue:[[[resturantArray objectAtIndex:j] objectForKey:@"Value"] objectForKey:@"rname"] forKey:@"Restaurant"];
        NSMutableArray *innerArray = [[NSMutableArray alloc] init];
        for (int i=0; i<orderArrayList.count; i++)
        {
            if ([[[[resturantArray objectAtIndex:j] objectForKey:@"Value"] objectForKey:@"restaurant_id"] isEqualToString:[[orderArrayList objectAtIndex:i] objectForKey:@"restaurant_id"]])
            {
                [innerArray addObject:[orderArrayList objectAtIndex:i]];
            }
        }
        if (innerArray.count>0)
        {
            [dataDic setValue:innerArray forKey:@"OrderData"];
            [sortedArray addObject:dataDic];
        }
    }
    [orderTable reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView== orderTable)
    {
        return sortedArray.count;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(tableView== orderTable)
    {
        int count =[[[sortedArray objectAtIndex:section] objectForKey:@"OrderData"] count];
        return count;
    }
    else
    {
        return productListArray.count;
    }
    tableView.separatorColor=[UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView== orderTable)
    {
        return 44;
    }
    else
    {
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView== orderTable)
    {
        static NSString *CellIdentifier=@"MyOrderListCell";
        orderCell = (MyOrderListCell *)[orderTable dequeueReusableCellWithIdentifier:CellIdentifier];
        if (orderCell == nil)
        {
            NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"MyOrderListCell" owner:self options:nil];
            
            orderCell = [cellArray objectAtIndex:0];
        }
        
        NSArray *orderListArray = [[sortedArray objectAtIndex:indexPath.section] objectForKey:@"OrderData"];
       
        [orderCell.itemListButton addTarget:self action:@selector(clickOnItemButton:) forControlEvents:UIControlEventTouchUpInside];
        orderCell.OrderNameLable.text=[NSString stringWithFormat:@"Order %d",(indexPath.row+1)];
        
        orderCell.priceLable.text=[NSString stringWithFormat:@"%.2f",[[[orderListArray objectAtIndex:indexPath.row ] objectForKey:@"grand_total"] floatValue]];
        
        orderCell.OrderNameLable.font=[UIFont fontWithName:FONT_Ragular size:10.0];
        orderCell.priceLable.font=[UIFont fontWithName:FONT_Ragular size:10.0];
        return orderCell;
    }
    else
    {
        static NSString *CellIdentifier=@"ProductCell";
        ProductCell *itemCell = (ProductCell *)[itemTable dequeueReusableCellWithIdentifier:CellIdentifier];
        if (itemCell == nil)
        {
            NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
            
            itemCell = [cellArray objectAtIndex:0];
        }
        itemCell.nameLabel.text=[[[productListArray objectAtIndex:indexPath.row]objectForKey:@"p" ] objectForKey:@"name"];
       
        NSArray *fm_om_Array=[[productListArray objectAtIndex:indexPath.row ]objectForKey:@"fm" ];
        NSArray *om_Array=[[productListArray objectAtIndex:indexPath.row ]objectForKey:@"om"];
        NSString *modifier=@"";
        for (int i=0; i<fm_om_Array.count; i++)
        {
            modifier=[modifier stringByAppendingString:[NSString stringWithFormat:@",%@",[[fm_om_Array objectAtIndex:i] objectForKey:@"fm_item_name"]]];
        }
        for (int i=0; i<om_Array.count; i++)
        {
            modifier=[modifier stringByAppendingString:[NSString stringWithFormat:@",%@",[[om_Array objectAtIndex:i] objectForKey:@"om_item_name"]]];
        }
        if ([modifier hasPrefix:@","])
        {
            modifier = [modifier substringFromIndex:1];
        }
        
        float priceIn=([[[[productListArray objectAtIndex:indexPath.row ]objectForKey:@"p" ] objectForKey:@"sub_total"] floatValue] + [[NSString stringWithFormat:@".%2d",fm_om_Array.count] floatValue]);
        itemCell.priceLabel.text=[NSString stringWithFormat:@"%.2f", priceIn];
        itemCell.priceLabel.hidden=YES;
       
        itemCell.modifierLabel.text=modifier;
        itemCell.quantitiyLabel.text=[NSString stringWithFormat:@"Quantity: %@",[[[productListArray objectAtIndex:indexPath.row ] objectForKey:@"p" ] objectForKey:@"quantity"]];        
        itemCell.priceLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
        [itemCell.priceLabel setFont: [itemCell.priceLabel.font fontWithSize: 12.0]];

        itemCell.modifierLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
        [itemCell.modifierLabel setFont: [itemCell.modifierLabel.font fontWithSize: 12.0]];

        itemCell.quantitiyLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
        [itemCell.modifierLabel setFont: [itemCell.modifierLabel.font fontWithSize: 12.0]];


        return itemCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if(tableView== orderTable)
    {
        NSArray *orderListArray = [[sortedArray objectAtIndex:indexPath.section] objectForKey:@"OrderData"];

        [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Moving..."];
        move=@"NewClass";
        orderId = [[orderListArray objectAtIndex:indexPath.row] objectForKey:@"order_id"];
        [[NSUserDefaults standardUserDefaults] setValue:[[orderListArray objectAtIndex:indexPath.row ]objectForKey:@"grand_total"] forKey:@"FinalPrice"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self productDetailRequest:[[orderListArray objectAtIndex:indexPath.row] objectForKey:@"order_id"] restaurantId:[[orderListArray objectAtIndex:indexPath.row] objectForKey:@"restaurant_id"]];
    }
    else
    {
        
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView== orderTable)
    {
        tableView.sectionIndexColor = [UIColor blackColor];
        return [[sortedArray objectAtIndex:section] objectForKey:@"Restaurant"];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
    // If you are not using ARC:
    // return [[UIView new] autorelease];
}
-(IBAction)clickOnItemButton:(id)sender
{
    move=@"OldClass";
    orderCell = (MyOrderListCell *)[[[sender superview] superview] superview] ;
    
    if (IS_IOS8)
    {
        orderCell = (MyOrderListCell *)[[sender superview] superview] ;
    }
    else
    {
        orderCell = (MyOrderListCell *)[[[sender superview] superview] superview] ;
    }

    NSIndexPath *clickedButtonPath = [orderTable indexPathForCell:orderCell];
    orderNameLabel.text=[NSString stringWithFormat:@"Order %d",(clickedButtonPath.row+1)];
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
    
    NSArray *orderListArray = [[sortedArray objectAtIndex:clickedButtonPath.section] objectForKey:@"OrderData"];

    [self productDetailRequest:[[orderListArray objectAtIndex:clickedButtonPath.row] objectForKey:@"order_id"] restaurantId:[[orderListArray objectAtIndex:clickedButtonPath.row] objectForKey:@"restaurant_id"]];
    [[NSUserDefaults standardUserDefaults] setValue:[[orderListArray objectAtIndex:clickedButtonPath.row ]objectForKey:@"grand_total"] forKey:@"FinalPrice"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    orderId = [[orderListArray objectAtIndex:clickedButtonPath.row] objectForKey:@"order_id"];
    itemView.hidden=NO;

}
-(IBAction)clickOnHideItemView:(id)sender
{
    itemView.hidden=YES;

}

-(void)myOrderListRequest
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];

    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    helper.delegate=self;
    [helper myOpenOrderList:[NSString stringWithFormat:@"memberId/%@",[openDefault valueForKey:@"Member"]]];
}
-(void)myOpenOrderList:(NSString *)response
{
    NSLog(@"%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    orderArrayList=[dataDic objectForKey:@"orderInfo"];
    
    if (orderArrayList.count>0)
    {
        [self listOfRestaurant];
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Done." :1.0];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"No Order." :1.0];
    }
}

-(void)gettingFail:(NSString *)error
{
    [MyCustomeClass SVProgressMessageDismissWithError:@"Please try again" :1.0];
    NSLog(@"%@",error);
}

-(void)productDetailRequest:(NSString *)orderID restaurantId:(NSString *)restaurantID
{
    temprestaurantID = restaurantID;
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    helper.delegate=self;
    [helper orderProductList:[NSString stringWithFormat:@"restId/%@/oid/%@",restaurantID,orderID]];
}

-(void)orderProductList:(NSString *)response
{
    [productListArray removeAllObjects];
    NSLog(@"%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    productListArray=[dataDic objectForKey:@"orderDetailInfo"] ;
    
    if (productListArray.count)
    {
        [itemTable reloadData];
    }
    if ([move isEqualToString:@"NewClass"])
    {
        [self orderSendingPackage:0];
    }
   
    [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Done." :1.0];
}
-(IBAction)clickOnCheckOut:(id)sender
{
    [self orderSendingPackage:0];
}

-(void)orderSendingPackage:(int ) productId
{
    NSMutableArray *finalArray=[[NSMutableArray alloc] init];
    for (int i=0; i<productListArray.count; i++)
    {
        productId=i;
        NSMutableDictionary *datDic=[[NSMutableDictionary alloc] init];
        
        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p" ] objectForKey:@"type"] forKeyPath:@"type"];

        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p" ] objectForKey:@"price"] forKeyPath:@"price"];
        
        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p"]objectForKey:@"name" ] forKeyPath:@"name"];
        
        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p"]objectForKey:@"quantity" ] forKeyPath:@"quantity"];

        
        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p"]objectForKey:@"vat" ] forKeyPath:@"is_vat"];
        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p" ] objectForKey:@"local_tax"] forKeyPath:@"is_localtax"];
        
        [datDic setValue:[[[productListArray objectAtIndex:productId]   objectForKey:@"p" ] objectForKey:@"other_tax"] forKeyPath:@"is_othertax"];
        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p" ] objectForKey:@"service_tax"] forKeyPath:@"is_servicetax"];
        [datDic setValue:[[[productListArray objectAtIndex:productId]  objectForKey:@"p" ] objectForKey:@"pizza_base_id"] forKeyPath:@"pizza_base_id"];
        
        [datDic setValue:[[[productListArray objectAtIndex:productId]  objectForKey:@"p" ] objectForKey:@"quantity"] forKeyPath:@"count"];
        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p" ] objectForKey:@"id"] forKeyPath:@"id"];
        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p" ] objectForKey:@"topping_id_x1"] forKeyPath:@"id"];
        
        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p" ] objectForKey:@"topping_id_x2"] forKeyPath:@"id"];
        
        [datDic setValue:[[[productListArray objectAtIndex:productId]  objectForKey:@"p" ] objectForKey:@"tax_total"] forKeyPath:@"tax_total"];
        
        [datDic setValue:[[[productListArray objectAtIndex:productId]  objectForKey:@"p" ] objectForKey:@"product_id"] forKeyPath:@"id"];
        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p" ] objectForKey:@"optional_modifier_ids"] forKeyPath:@"OptionModifier"];
        
        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p" ] objectForKey:@"forced_modifier_ids"] forKeyPath:@"ForceModifier"];
        
        [datDic setValue:[[[productListArray objectAtIndex:productId] objectForKey:@"p" ] objectForKey:@"size"] forKeyPath:@"size"];
        [finalArray addObject:datDic];
    }
    
     NSData* data=[NSKeyedArchiver archivedDataWithRootObject:finalArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"WalletOrderArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    CardViewController *card=[[CardViewController alloc] initWithNibName:@"CardViewController" bundle:nil];
    [card setOrderId:orderId];
    card.ciboRestauantID = temprestaurantID;
    [card setOrderTypeCheckding:@"OpenOrder"];
    [self presentViewController:card animated:true completion:nil];
}


@end
