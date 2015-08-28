//
//  BillOverviewController.m
//  Restaurant Cibo
//
//  Created by Naveen Rajput on 25/07/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import "BillOverviewController.h"

@interface BillOverviewController ()

@end

@implementation BillOverviewController
@synthesize arrProductList;
@synthesize splitCount;
@synthesize orderAmount;
@synthesize storyboard;
@synthesize strOrderName;
@synthesize orderID;
@synthesize selectedOrderDetail;
@synthesize order_location;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setViewLayout];
    
}
-(void)setViewLayout
{
    btnNo.layer.cornerRadius = 10;
    btnNo.layer.borderWidth = 2;
    btnNo.layer.borderColor = [[UIColor brownColor] CGColor];
    
    btnYES.layer.cornerRadius = 10;
    btnYES.layer.borderWidth = 2;
    btnYES.layer.borderColor = [[UIColor brownColor] CGColor];
    
    imgBGPatti.layer.cornerRadius = 10;
    imgBGPatti.layer.borderWidth = 2;
    imgBGPatti.layer.borderColor = [[UIColor brownColor] CGColor];
    
    tblBillOverview.layer.cornerRadius = 10;
    tblBillOverview.layer.borderWidth = 2;
    tblBillOverview.layer.borderColor = [[UIColor brownColor] CGColor];
    
    labelOrderAmount.text = [NSString stringWithFormat:@"%.2f",orderAmount];
    labelOrderName.text = [NSString stringWithFormat:@"%@",strOrderName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview delegate and datasource method list
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrProductList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"BillOverviewViewCell";
    BillOverviewViewCell *cell = (BillOverviewViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BillOverviewViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lblItemName.text =[[[arrProductList objectAtIndex:indexPath.row]objectForKey:@"p" ] objectForKey:@"name"];
    cell.lblItemPrice.text = [[[arrProductList objectAtIndex:indexPath.row]objectForKey:@"p" ] objectForKey:@"sub_total"];
    cell.lblCount.text =[NSString stringWithFormat:@"%@X",[[[arrProductList objectAtIndex:indexPath.row]objectForKey:@"p" ] objectForKey:@"quantity"]];
    
    return cell;
}

-(IBAction)tapped_btnYes:(id)sender
{
    NSMutableArray *tempArray =[[NSMutableArray alloc] init];
    for (int i=0; i<arrProductList.count; i++)
    {
        int qunatity = [[[[arrProductList objectAtIndex:i] objectForKey:@"p"] objectForKey:@"quantity"] intValue];
        if (qunatity==1)
        {
            [tempArray addObject:[arrProductList objectAtIndex:i]];
        }
        else
        {
            for (int j=0; j<qunatity; j++)
            {
                [self resetDataInSingalItem:i quantity:qunatity];
                [tempArray addObject:[self resetDataInSingalItem:i quantity:qunatity]];
            }
        }
    }
    
    MoveBillOverView_ViewController *order=[[MoveBillOverView_ViewController alloc] initWithNibName:@"MoveBillOverView_ViewController" bundle:nil];
    order.splitCount = splitCount;
    order.mainArray = tempArray;
    order.orderAmount = orderAmount;
    order.orderID = orderID;
    order.order_location = order_location;
    order.selectedOrderDetail=selectedOrderDetail;
    order.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:order animated:true completion:nil];
}
-(NSMutableDictionary *)resetDataInSingalItem:(int)index quantity:(int)quantity
{
    int count =(int)[[arrProductList objectAtIndex:index] count];
    BOOL is_FM = NO;
    BOOL is_OM = NO;
    BOOL is_product = NO;
    if (count==1)
    {
        is_product = YES;
    }
    else if (count==2)
    {
        NSArray *fm = [[arrProductList objectAtIndex:index] objectForKey:@"fm"];
        NSArray *om = [[arrProductList objectAtIndex:index] objectForKey:@"om"];
        if (om.count>0)
        {
            is_OM = YES;
        }
        if (fm.count>0)
        {
            is_FM = YES;
        }
        is_product = YES;
    }
    else
    {
        is_FM = YES;
        is_OM = YES;
        is_product = YES;
    }
    NSMutableDictionary *finalDic = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *datDic=[[NSMutableDictionary alloc] init];
    
    if (is_product)
    {
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"type"] forKeyPath:@"type"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"cooking_instruction"] forKeyPath:@"cooking_instruction"];
        
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"device_id"] forKeyPath:@"device_id"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"happy_hours_id"] forKeyPath:@"happy_hours_id"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"offer_amount"] forKeyPath:@"offer_amount"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"order_id"] forKeyPath:@"order_id"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"order_product_id"] forKeyPath:@"order_product_id"];
        [datDic setValue:@"1" forKeyPath:@"quantity"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"points"] forKeyPath:@"points"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"restaurant_id"] forKeyPath:@"restaurant_id"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"setmenu_dish_id"] forKeyPath:@"setmenu_dish_id"];
        
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"setmenu_drink_id"] forKeyPath:@"setmenu_drink_id"];
        
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"setmenu_pizza_id"] forKeyPath:@"setmenu_pizza_id"];
        
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"size"] forKeyPath:@"size"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"size_value"] forKeyPath:@"size_value"];
        
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"topping_serving_size"] forKeyPath:@"topping_serving_size"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"unique_id"] forKeyPath:@"unique_id"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"update_status"] forKeyPath:@"update_status"];
        
        float sub_total = [[[[arrProductList objectAtIndex:index]  objectForKey:@"p" ] objectForKey:@"sub_total"]floatValue];
        [datDic setValue:[NSString stringWithFormat:@"%0.2f",sub_total/quantity] forKeyPath:@"sub_total"];
        
        
        float price = [[[[arrProductList objectAtIndex:index]  objectForKey:@"p" ] objectForKey:@"price"]floatValue];
        [datDic setValue:[NSString stringWithFormat:@"%0.2f",price/quantity] forKeyPath:@"price"];
        
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p"]objectForKey:@"name" ] forKeyPath:@"name"];
        
        float vat = [[[[arrProductList objectAtIndex:index]  objectForKey:@"p" ] objectForKey:@"vat"]floatValue];
        [datDic setValue:[NSString stringWithFormat:@"%0.2f",vat/quantity] forKeyPath:@"vat"];
        
        float local_tax = [[[[arrProductList objectAtIndex:index]  objectForKey:@"p" ] objectForKey:@"local_tax"]floatValue];
        [datDic setValue:[NSString stringWithFormat:@"%0.2f",local_tax/quantity] forKeyPath:@"local_tax"];
        
        float other_tax = [[[[arrProductList objectAtIndex:index]  objectForKey:@"p" ] objectForKey:@"other_tax"]floatValue];
        [datDic setValue:[NSString stringWithFormat:@"%0.2f",other_tax/quantity] forKeyPath:@"other_tax"];
        
        float service_tax = [[[[arrProductList objectAtIndex:index]  objectForKey:@"p" ] objectForKey:@"service_tax"]floatValue];
        [datDic setValue:[NSString stringWithFormat:@"%0.2f",service_tax/quantity] forKeyPath:@"service_tax"];
        
        [datDic setValue:[[[arrProductList objectAtIndex:index]  objectForKey:@"p" ] objectForKey:@"pizza_base_id"] forKeyPath:@"pizza_base_id"];
        
        [datDic setValue:[[[arrProductList objectAtIndex:index]  objectForKey:@"p" ] objectForKey:@"quantity"] forKeyPath:@"count"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"topping_id_x1"] forKeyPath:@"topping_id_x1"];
        
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"topping_id_x2"] forKeyPath:@"topping_id_x2"];
        
        float tax_total = [[[[arrProductList objectAtIndex:index]  objectForKey:@"p" ] objectForKey:@"tax_total"]floatValue];
        [datDic setValue:[NSString stringWithFormat:@"%f",tax_total/quantity] forKeyPath:@"tax_total"];
        
        [datDic setValue:[[[arrProductList objectAtIndex:index]  objectForKey:@"p" ] objectForKey:@"product_id"] forKeyPath:@"product_id"];
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"optional_modifier_ids"] forKeyPath:@"optional_modifier_ids"];
        
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"forced_modifier_ids"] forKeyPath:@"forced_modifier_ids"];
        
        [datDic setValue:[[[arrProductList objectAtIndex:index] objectForKey:@"p" ] objectForKey:@"size"] forKeyPath:@"size"];
        
        [finalDic setValue:datDic forKey:@"p"];
    }
    if (is_OM)
    {
        [finalDic setValue:[[arrProductList objectAtIndex:index] objectForKey:@"om"] forKey:@"om"];
    }
    if (is_FM)
    {
        [finalDic setValue:[[arrProductList objectAtIndex:index] objectForKey:@"fm"] forKey:@"fm"];
    }
    return finalDic;
}

-(IBAction)tapped_btnNo:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)tapped_btnMenu:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
