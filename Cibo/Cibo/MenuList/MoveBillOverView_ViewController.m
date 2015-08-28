//
//  MoveBillOverView_ViewController.m
//  EL3ezba
//
//  Created by Naveen Rajput on 25/07/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import "MoveBillOverView_ViewController.h"

@interface MoveBillOverView_ViewController ()

@end

@implementation MoveBillOverView_ViewController

@synthesize splitCount;
@synthesize fakeBillArray;
@synthesize mainArray;
@synthesize loadedArray;
@synthesize bill1Array;
@synthesize bill2Array;
@synthesize bill3Array;
@synthesize bill4Array;
@synthesize bill5Array;
@synthesize bill6Array;
@synthesize bill7Array;
@synthesize bill8Array;
@synthesize bill9Array;
@synthesize bill10Array;
@synthesize orderAmount;
@synthesize numberOfBillArray;
@synthesize orderID;
@synthesize selectedOrderDetail;
@synthesize taxArray;
@synthesize selectedOrderArray;
@synthesize finalOrderArray;
@synthesize order_location;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    taxArray = [[NSMutableArray alloc] init];
    selectedOrderArray = [[NSMutableArray alloc] init];
    finalOrderArray = [[NSMutableArray alloc] init];
    
    imgBGPatti.layer.cornerRadius = 10;
    imgBGPatti.layer.borderWidth = 2;
    imgBGPatti.layer.borderColor = [[UIColor brownColor] CGColor];
    
    imgBottomBG.layer.cornerRadius = 10;
    imgBottomBG.layer.borderWidth = 2;
    imgBottomBG.layer.borderColor = [[UIColor brownColor] CGColor];
    
    tblMoveBill.layer.cornerRadius = 10;
    tblMoveBill.layer.borderWidth = 2;
    tblMoveBill.layer.borderColor = [[UIColor brownColor] CGColor];
    
    checkoutButton.layer.cornerRadius = 10;
    checkoutButton.layer.borderWidth = 2;
    checkoutButton.layer.borderColor = [[UIColor brownColor] CGColor];
    
    bill1Array =[[NSMutableArray alloc] init];
    bill2Array =[[NSMutableArray alloc] init];
    bill3Array =[[NSMutableArray alloc] init];
    bill4Array =[[NSMutableArray alloc] init];
    bill5Array =[[NSMutableArray alloc] init];
    bill6Array =[[NSMutableArray alloc] init];
    bill7Array =[[NSMutableArray alloc] init];
    bill8Array =[[NSMutableArray alloc] init];
    bill9Array =[[NSMutableArray alloc] init];
    bill10Array =[[NSMutableArray alloc] init];
    loadedArray = [[NSMutableArray alloc] init];
    numberOfBillArray =[[NSMutableArray alloc] init];
    
    UINib *cellNib = [UINib nibWithNibName:@"MoveBillCollectionViewCell" bundle:nil];
    [collectionViewBill registerNib:cellNib forCellWithReuseIdentifier:@"MoveBillCollectionViewCell"];
    fakeBillArray = [[NSMutableArray alloc] initWithObjects:@"Bill 01",@"Bill 02",@"Bill 03",@"Bill 04",@"Bill 05",@"Bill 06",@"Bill 07",@"Bill 08",@"Bill 09",@"Bill 10",@"Bill 11", nil];
    selectedBill = [fakeBillArray objectAtIndex:0];
    
    for (int i=0; i<splitCount; i++)
    {
        [numberOfBillArray addObject:[fakeBillArray objectAtIndex:i]];
    }
    bill1Array =mainArray;
    
    lblOrderAmount.text = [NSString stringWithFormat:@"%@: %.2f",[fakeBillArray objectAtIndex:0],orderAmount];
    [loadedArray addObjectsFromArray:mainArray];
    
    [checkoutButton setTitle:[NSString stringWithFormat:@"Save Total: %.2f",orderAmount] forState:UIControlStateNormal];
    
    helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    moveBillDefault = [NSUserDefaults standardUserDefaults];
    customerDiscountInFloat=[[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDiscount"] floatValue];
    
    //[self taxRequest];
}

- (void)didReceiveMemoryWarning
{
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
    return loadedArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (loadedArray.count == 1)
    {
        NSString *rangeString = lblOrderAmount.text;
        if ([rangeString containsString:@"Bill 01"])
        {
            [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"You can not move this item. Minimum one item should be in the bill 01" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
            return;
        }
        
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Where you want to move?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    for (int i=0; i<splitCount; i++)
    {
        if (![[numberOfBillArray objectAtIndex:i] isEqualToString:selectedBill])
        {
            [actionSheet addButtonWithTitle:[numberOfBillArray objectAtIndex:i]];
        }
    }
    [actionSheet showInView:self.view];
    selectedIndex=indexPath;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MobeBillViewCell";
    MobeBillViewCell *cell = (MobeBillViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MobeBillViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lblItemName.text =[[[loadedArray objectAtIndex:indexPath.row]objectForKey:@"p" ] objectForKey:@"name"];
    cell.lblCount.text =[[[loadedArray objectAtIndex:indexPath.row]objectForKey:@"p" ] objectForKey:@"sub_total"];
    
    return cell;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return splitCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==collectionViewBill)
    {
        MoveBillCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MoveBillCollectionViewCell" forIndexPath:indexPath];
        
        cell.lblBillNo.layer.cornerRadius = 10;
        cell.lblBillNo.layer.borderWidth = 2;
        cell.lblBillNo.layer.borderColor = [[UIColor redColor] CGColor];
        cell.lblBillNo.text =[fakeBillArray objectAtIndex:indexPath.row];
        return cell;
    }
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedBill = [numberOfBillArray objectAtIndex:indexPath.row];
    [loadedArray removeAllObjects];
    if (indexPath.row==0)
        [loadedArray addObjectsFromArray:bill1Array];
    else if(indexPath.row==1)
        [loadedArray addObjectsFromArray:bill2Array];
    else if(indexPath.row==2)
        [loadedArray addObjectsFromArray:bill3Array];
    else if(indexPath.row==3)
        [loadedArray addObjectsFromArray:bill4Array];
    else if(indexPath.row==4)
        [loadedArray addObjectsFromArray:bill5Array];
    else if(indexPath.row==5)
        [loadedArray addObjectsFromArray:bill6Array];
    else if(indexPath.row==6)
        [loadedArray addObjectsFromArray:bill7Array];
    else if(indexPath.row==7)
        [loadedArray addObjectsFromArray:bill8Array];
    else if(indexPath.row==8)
        [loadedArray addObjectsFromArray:bill9Array];
    else if(indexPath.row==9)
        [loadedArray addObjectsFromArray:bill10Array];
    
    orderAmount = 0.0;
    for (int i=0; i<loadedArray.count; i++)
    {
        orderAmount = orderAmount + [[[[loadedArray objectAtIndex:i]objectForKey:@"p" ] objectForKey:@"sub_total"] floatValue];
    }
    lblOrderAmount.text = [NSString stringWithFormat:@"%@:- %.2f",[fakeBillArray objectAtIndex:indexPath.row],orderAmount];
    customerDiscountInFloat=[[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDiscount"] floatValue];
    
    
    [tblMoveBill reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - tableview delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *titleName =  [actionSheet buttonTitleAtIndex:buttonIndex];
    if (buttonIndex==0)
    {
        NSLog(@"Hi");
        return;
    }
    else if ([titleName isEqualToString:@"Bill 01"])
    {
        [bill1Array addObject:[loadedArray objectAtIndex:selectedIndex.row]];
        [loadedArray removeObjectAtIndex:selectedIndex.row];
    }
    else if ([titleName isEqualToString:@"Bill 02"])
    {
        [bill2Array addObject:[loadedArray objectAtIndex:selectedIndex.row]];
        [loadedArray removeObjectAtIndex:selectedIndex.row];
    }
    else if ([titleName isEqualToString:@"Bill 03"])
    {
        [bill3Array addObject:[loadedArray objectAtIndex:selectedIndex.row]];
        [loadedArray removeObjectAtIndex:selectedIndex.row];
    }
    else if ([titleName isEqualToString:@"Bill 04"])
    {
        [bill4Array addObject:[loadedArray objectAtIndex:selectedIndex.row]];
        [loadedArray removeObjectAtIndex:selectedIndex.row];
    }
    else if ([titleName isEqualToString:@"Bill 05"])
    {
        [bill5Array addObject:[loadedArray objectAtIndex:selectedIndex.row]];
        [loadedArray removeObjectAtIndex:selectedIndex.row];
    }
    else if ([titleName isEqualToString:@"Bill 06"])
    {
        [bill6Array addObject:[loadedArray objectAtIndex:selectedIndex.row]];
        [loadedArray removeObjectAtIndex:selectedIndex.row];
    }
    else if ([titleName isEqualToString:@"Bill 07"])
    {
        [bill7Array addObject:[loadedArray objectAtIndex:selectedIndex.row]];
        [loadedArray removeObjectAtIndex:selectedIndex.row];
    }
    else if ([titleName isEqualToString:@"Bill 08"])
    {
        [bill8Array addObject:[loadedArray objectAtIndex:selectedIndex.row]];
        [loadedArray removeObjectAtIndex:selectedIndex.row];
    }
    else if ([titleName isEqualToString:@"Bill 09"])
    {
        [bill9Array addObject:[loadedArray objectAtIndex:selectedIndex.row]];
        [loadedArray removeObjectAtIndex:selectedIndex.row];
    }
    else if ([titleName isEqualToString:@"Bill 10"])
    {
        [bill10Array addObject:[loadedArray objectAtIndex:selectedIndex.row]];
        [loadedArray removeObjectAtIndex:selectedIndex.row];
    }
    
    if ([selectedBill isEqualToString:@"Bill 01"])
    {
        [bill1Array removeObjectAtIndex:selectedIndex.row];
    }
    else if ([selectedBill isEqualToString:@"Bill 02"])
    {
        [bill2Array removeObjectAtIndex:selectedIndex.row];
    }
    else if ([selectedBill isEqualToString:@"Bill 03"])
    {
        [bill3Array removeObjectAtIndex:selectedIndex.row];
    }
    else if ([selectedBill isEqualToString:@"Bill 04"])
    {
        [bill4Array removeObjectAtIndex:selectedIndex.row];
    }
    else if ([selectedBill isEqualToString:@"Bill 05"])
    {
        [bill5Array removeObjectAtIndex:selectedIndex.row];
    }
    else if ([selectedBill isEqualToString:@"Bill 06"])
    {
        [bill6Array removeObjectAtIndex:selectedIndex.row];
    }
    else if ([selectedBill isEqualToString:@"Bill 07"])
    {
        [bill7Array removeObjectAtIndex:selectedIndex.row];
    }
    else if ([selectedBill isEqualToString:@"Bill 08"])
    {
        [bill8Array removeObjectAtIndex:selectedIndex.row];
    }
    else if ([selectedBill isEqualToString:@"Bill 09"])
    {
        [bill9Array removeObjectAtIndex:selectedIndex.row];
    }
    else if ([selectedBill isEqualToString:@"Bill 10"])
    {
        [bill10Array removeObjectAtIndex:selectedIndex.row];
    }
    [tblMoveBill reloadData];
}

-(IBAction)clickOnCheckoutButton:(id)sender
{
    BOOL spliteFlag = YES;
    for (int i=0; i<splitCount; i++)
    {
        if (i==0)
        {
            if (bill1Array.count<=0)
                spliteFlag = NO;
        }
        else if (i==1)
        {
            if (bill1Array.count<=0)
                spliteFlag = NO;
            if (bill2Array.count<=0)
                spliteFlag = NO;
        }
        else if (i==2)
        {
            if (bill1Array.count<=0)
                spliteFlag = NO;
            if (bill2Array.count<=0)
                spliteFlag = NO;
            if (bill3Array.count<=0)
                spliteFlag = NO;
        }
        else if (i==3)
        {
            if (bill1Array.count<=0)
                spliteFlag = NO;
            if (bill2Array.count<=0)
                spliteFlag = NO;
            if (bill3Array.count<=0)
                spliteFlag = NO;
        }
        else if (i==4)
        {
            if (bill1Array.count<=0)
                spliteFlag = NO;
            if (bill2Array.count<=0)
                spliteFlag = NO;
            if (bill3Array.count<=0)
                spliteFlag = NO;
            if (bill4Array.count<=0)
                spliteFlag = NO;
            if (bill5Array.count<=0)
                spliteFlag = NO;
        }
        else if (i==5)
        {
            if (bill1Array.count<=0)
                spliteFlag = NO;
            if (bill2Array.count<=0)
                spliteFlag = NO;
            if (bill3Array.count<=0)
                spliteFlag = NO;
            if (bill4Array.count<=0)
                spliteFlag = NO;
            if (bill5Array.count<=0)
                spliteFlag = NO;
            if (bill6Array.count<=0)
                spliteFlag = NO;
        }
        else if (i==6)
        {
            if (bill1Array.count<=0)
                spliteFlag = NO;
            if (bill2Array.count<=0)
                spliteFlag = NO;
            if (bill3Array.count<=0)
                spliteFlag = NO;
            if (bill4Array.count<=0)
                spliteFlag = NO;
            if (bill5Array.count<=0)
                spliteFlag = NO;
            if (bill6Array.count<=0)
                spliteFlag = NO;
            if (bill7Array.count<=0)
                spliteFlag = NO;
            
        }
        else if (i==7)
        {
            if (bill1Array.count<=0)
                spliteFlag = NO;
            if (bill2Array.count<=0)
                spliteFlag = NO;
            if (bill3Array.count<=0)
                spliteFlag = NO;
            if (bill4Array.count<=0)
                spliteFlag = NO;
            if (bill5Array.count<=0)
                spliteFlag = NO;
            if (bill6Array.count<=0)
                spliteFlag = NO;
            if (bill7Array.count<=0)
                spliteFlag = NO;
            if (bill8Array.count<=0)
                spliteFlag = NO;
        }
        else if (i==8)
        {
            if (bill1Array.count<=0)
                spliteFlag = NO;
            if (bill2Array.count<=0)
                spliteFlag = NO;
            if (bill3Array.count<=0)
                spliteFlag = NO;
            if (bill4Array.count<=0)
                spliteFlag = NO;
            if (bill5Array.count<=0)
                spliteFlag = NO;
            if (bill6Array.count<=0)
                spliteFlag = NO;
            if (bill7Array.count<=0)
                spliteFlag = NO;
            if (bill8Array.count<=0)
                spliteFlag = NO;
            if (bill9Array.count<=0)
                spliteFlag = NO;
        }
        else if (i==9)
        {
            if (bill1Array.count<=0)
                spliteFlag = NO;
            if (bill2Array.count<=0)
                spliteFlag = NO;
            if (bill3Array.count<=0)
                spliteFlag = NO;
            if (bill4Array.count<=0)
                spliteFlag = NO;
            if (bill5Array.count<=0)
                spliteFlag = NO;
            if (bill6Array.count<=0)
                spliteFlag = NO;
            if (bill7Array.count<=0)
                spliteFlag = NO;
            if (bill8Array.count<=0)
                spliteFlag = NO;
            if (bill9Array.count<=0)
                spliteFlag = NO;
            if (bill10Array.count<=0)
                spliteFlag = NO;
            
        }
        
    }
    if (spliteFlag == NO)
    {
        [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"You need to fill all bills before save." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Bill Spliting..."];
    NSMutableArray *finalTempArray = [[NSMutableArray alloc] init];
    
    [finalTempArray addObject:bill1Array];
    [finalTempArray addObject:bill2Array];
    [finalTempArray addObject:bill3Array];
    [finalTempArray addObject:bill4Array];
    [finalTempArray addObject:bill5Array];
    [finalTempArray addObject:bill6Array];
    [finalTempArray addObject:bill7Array];
    [finalTempArray addObject:bill8Array];
    [finalTempArray addObject:bill9Array];
    [finalTempArray addObject:bill10Array];
    
    if (finalTempArray.count>0)
    {
        [self PrepareOrderInJson:finalTempArray];
        NSMutableDictionary *jsonDictionary =[[NSMutableDictionary alloc] init];
        [jsonDictionary setValue:finalOrderArray forKey:@"MainOrder"];//
        NSString *jsonString = [MyCustomeClass jsonStringFromNormalDictionary:jsonDictionary];
        [self sendOrderByJSON:[NSString stringWithFormat:@"mainorder=%@",jsonString]];
    }
}

-(void)orderId
{
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];
    long int orderIDInInteger=(int )timeInMiliseconds;
    //if (orderID.length<=0)
    {
        orderID=[NSString stringWithFormat:@"17%@",[NSString stringWithFormat:@"%ld",orderIDInInteger]];
    }
}


#pragma mark - Webservics Response classes

-(IBAction)tapped_btnMenu:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)taxRequest
{
    helper.delegate=self;
    [helper taxList:ciboRestaurantId];
}

-(void)taxList:(NSString *)response
{
    NSLog(@"%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    taxArray = [dataDic objectForKey:@"taxInfo"];
    NSData* data=[NSKeyedArchiver archivedDataWithRootObject:taxArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"TaxArray"];
}

-(void)gettingFail:(NSString *)error
{
    
}

-(void)PrepareOrderInJson:(NSMutableArray *)itemArray
{
    for (int o = 0; o<itemArray.count; o++)
    {
        if (o!=0)
            [self orderId];
        
        NSMutableArray *productArray = [itemArray objectAtIndex:o];
        if (productArray.count>0)
        {
            float totalSevericeTax=0.0;
            float totalVatTax=0.0;
            float totalLocalTax =0.0;
            float totalOtherTax = 0.0;
            float totalTax = 0.0;
            float grandTotal =0.0;
            float savings = 0.0;
            float finalforceModifierPrice = 0.0;
            float finaloptionModifierPrice = 0.0;
            
            //update_status
            NSDictionary *priceDic = [self addTotalOnView:productArray];
            NSMutableArray *finalItamArray =[self finalItemArrayMethod:productArray];
            
            totalVatTax = [[priceDic valueForKey:@"finalvatTax"] floatValue];
            totalOtherTax = [[priceDic valueForKey:@"finalotherTax"] floatValue];
            totalSevericeTax = [[priceDic valueForKey:@"finalserviceTax"] floatValue];
            totalLocalTax = [[priceDic valueForKey:@"finallocalTax"] floatValue];
            finalforceModifierPrice = [[priceDic valueForKey:@"finalforceModifierPrice"] floatValue];
            finaloptionModifierPrice = [[priceDic valueForKey:@"finaloptionModifierPrice"] floatValue];
            grandTotal = [[priceDic valueForKey:@"finalPrice"] floatValue];
            savings =  [[priceDic valueForKey:@"savings"] floatValue];
            
            totalTax = totalSevericeTax+totalVatTax+totalLocalTax+totalOtherTax;
            subTotal =[NSString stringWithFormat:@"%2.f",grandTotal];
            
            NSString *pickupIS = @"0";
            NSString *transectionId=@"0";
            NSString *couponID = @"0";
            NSString *tipAmount =@"0";
            
            NSMutableDictionary *orderDic = [[NSMutableDictionary alloc] init];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *date = [formatter stringFromDate:[NSDate date]];
            
            
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateFormat:@"HH:mm:ss"];
            NSString *time = [formatter1 stringFromDate:[NSDate date]];
            
            [orderDic setValue:orderID forKey:@"order_id"];
            [orderDic setValue:@"" forKey:@"update_status"];
            if (o==0)
                [orderDic setValue:@"Changed" forKey:@"update_status"];
            
            [orderDic setValue:[moveBillDefault objectForKey:@"Member"] forKey:@"member_id"];
            [orderDic setValue:[moveBillDefault objectForKey:@"firstname"] forKey:@"delivery_firstname"];
            [orderDic setValue:[moveBillDefault objectForKey:@"lastname"] forKey:@"delivery_lastname"];
            [orderDic setValue:[moveBillDefault objectForKey:@"Email"] forKey:@"delivery_email"];
            [orderDic setValue:[moveBillDefault objectForKey:@"address"] forKey:@"delivery_address"];
            [orderDic setValue:[moveBillDefault objectForKey:@"city"] forKey:@"delivery_city"];
            [orderDic setValue:[moveBillDefault objectForKey:@"state"] forKey:@"delivery_state"];
            [orderDic setValue:time forKey:@"delivery_time"];
            [orderDic setValue:[moveBillDefault objectForKey:@"country"] forKey:@"delivery_country"];
            [orderDic setValue:[moveBillDefault objectForKey:@"zipcode"] forKey:@"delivery_zipcode"];
            [orderDic setValue:[moveBillDefault objectForKey:@"mobile"] forKey:@"delivery_phone"];
            [orderDic setValue:[moveBillDefault objectForKey:@"mobile"] forKey:@"delivery_mobile"];
            [orderDic setValue:subTotal forKey:@"total"];
            [orderDic setValue:[NSString stringWithFormat:@"%0.2f",customerDiscountInFloat] forKey:@"general_discount"];
            [orderDic setValue:@"0"forKey:@"promo_discount"];
            [orderDic setValue:date forKey:@"delivery_date"];
            [orderDic setValue:@"no comment" forKey:@"comments"];
            [orderDic setValue:time forKey:@"time_for_delivery"];
            [orderDic setValue:@"0" forKey:@"distance"];
            [orderDic setValue:@"1" forKey:@"payment_method"];
            [orderDic setValue:@"0" forKey:@"paid"];
            [orderDic setValue:@"open" forKey:@"order_status"];
            [orderDic setValue:date forKey:@"order_date"];
            [orderDic setValue:time forKey:@"order_time"];
            [orderDic setValue:@"0" forKey:@"points"];
            [orderDic setValue:@"0" forKey:@"pay_status"];
            
            [orderDic setValue:[NSString stringWithFormat:@"%0.2f",totalVatTax] forKey:@"vat"];
            [orderDic setValue:[NSString stringWithFormat:@"%0.2f",totalLocalTax] forKey:@"local_tax"];
            [orderDic setValue:[NSString stringWithFormat:@"%0.2f",totalOtherTax] forKey:@"other_tax"];
            
            [orderDic setValue:[NSString stringWithFormat:@"%0.2f",grandTotal] forKey:@"grand_total"];
            [orderDic setValue:@"0" forKey:@"delivery_option"];
            [orderDic setValue:@"street" forKey:@"street"];
            [orderDic setValue:[NSString stringWithFormat:@"%0.2f",totalTax] forKey:@"tax"];
            [orderDic setValue:[NSString stringWithFormat:@"%@",pickupIS] forKey:@"is_online"];
            [orderDic setValue:@"0" forKey:@"payment_status"];
            [orderDic setValue:@"mob" forKey:@"web"];
            [orderDic setValue:[NSString stringWithFormat:@"%@",ciboRestaurantId] forKey:@"restId"];
            [orderDic setValue:order_location forKey:@"order_location"];
            [orderDic setValue:[NSString stringWithFormat:@"%0.2f",savings] forKey:@"savings"];
            [orderDic setValue:tipAmount forKey:@"tip"];
            [orderDic setValue:@"1" forKey:@"mweb"];
            [orderDic setValue:transectionId forKey:@"transaction_id"];
            [orderDic setValue:couponID forKey:@"coupon_id"];
            [orderDic setValue:finalItamArray forKey:@"Items"];
            [orderDic setValue:@"open" forKey:@"type"];//
            [orderDic setValue:@"0" forKey:@"pickup"];
            [finalOrderArray addObject:orderDic];
        }
    }
}

-(void)sendOrderByJSON:(NSString *)jsonString
{
    [helper saveSpiltBill:jsonString];
}

-(void)saveSpiltBill:(NSString *)response
{
    NSLog(@"%@",response);
    
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKeyPath:@"OrderArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Thank You for Splite, Now you can pay from pos soon." :3.0];
    
    UIApplication *application=nil;
    NSDictionary *dic=nil;
    [moveBillDefault setValue:@"Home" forKey:@"RootView"];
    [moveBillDefault setValue:@"Home" forKey:@"Logout"];
    [[AppDelegate appDelegateDataAccess] application:application didFinishLaunchingWithOptions:dic];
}

-(NSMutableDictionary *)addTotalOnView:(NSMutableArray *)finalArray
{
    ///////////////////////////////
    float finalPrice=0.0;
    //float finalsinglePrice=0;
    float finalvatTax=0.0;
    float finalTotalTax =0.0;
    float finalotherTax=0.0;
    float finalserviceTax=0.0;
    float finallocalTax=0.0;
    float finalforceModifierPrice=0.0;
    float finaloptionModifierPrice=0.0;
    float savings = 0.0;
    
    for (int i=0; i<[finalArray count]; i++)
    {
        finalPrice = finalPrice + [[[[finalArray objectAtIndex:i] objectForKey:@"p" ] objectForKey:@"sub_total" ] floatValue];
        finalTotalTax =  finalTotalTax + [[[[finalArray objectAtIndex:i] objectForKey:@"p" ] objectForKey:@"tax_total" ] floatValue];
        
        finalvatTax =  finalvatTax + [[[[finalArray objectAtIndex:i] objectForKey:@"p" ] objectForKey:@"vat" ] floatValue];
        finalotherTax =  finalotherTax + [[[[finalArray objectAtIndex:i] objectForKey:@"p" ] objectForKey:@"other_tax" ] floatValue];
        finallocalTax =  finallocalTax + [[[[finalArray objectAtIndex:i] objectForKey:@"p" ] objectForKey:@"local_tax" ] floatValue];
        finalserviceTax =  finalserviceTax + [[[[finalArray objectAtIndex:i] objectForKey:@"p" ] objectForKey:@"service_tax" ] floatValue];
        
        // modifier calculation
        /* NSArray *fmLocalArray=[[[finalArray objectAtIndex:i]objectForKey:@"fm" ] objectForKey:@"ForceModifier"];
         for(int k=0; k<fmLocalArray.count;k++)
         {
         forceModifierPrice=forceModifierPrice+[[[fmLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
         finalforceModifierPrice = finalforceModifierPrice + forceModifierPrice;
         }
         NSArray *omLocalArray=[[[finalArray objectAtIndex:i] objectForKey:@"om" ] objectForKey:@"OptionModifier"];
         
         for(int k=0; k<omLocalArray.count;k++)
         {
         optionModifierPrice=optionModifierPrice+[[[omLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
         finaloptionModifierPrice = finaloptionModifierPrice + optionModifierPrice;
         }*/
        
    }
    
    NSMutableDictionary *priceDic =[[NSMutableDictionary alloc] init];
    [priceDic setValue:[NSString stringWithFormat:@"%f",finalforceModifierPrice] forKey:@"finalforceModifierPrice"];
    [priceDic setValue:[NSString stringWithFormat:@"%f",finaloptionModifierPrice] forKey:@"finaloptionModifierPrice"];
    [priceDic setValue:[NSString stringWithFormat:@"%f",finalvatTax] forKey:@"finalvatTax"];
    [priceDic setValue:[NSString stringWithFormat:@"%f",finalotherTax] forKey:@"finalotherTax"];
    [priceDic setValue:[NSString stringWithFormat:@"%f",finalserviceTax] forKey:@"finalserviceTax"];
    [priceDic setValue:[NSString stringWithFormat:@"%f",finallocalTax] forKey:@"finallocalTax"];
    [priceDic setValue:[NSString stringWithFormat:@"%f",finalPrice] forKey:@"finalPrice"];
    [priceDic setValue:[NSString stringWithFormat:@"%f",savings] forKey:@"savings"];
    
    return priceDic;
}
-(NSMutableArray *)finalItemArrayMethod:(NSMutableArray *)requestArray
{
    NSMutableArray *finalArray = [[NSMutableArray alloc] init];
    for (int i =0; i<requestArray.count; i++)
    {
        NSMutableDictionary *moreTampArray = [self setNewOrderIdWithProduct:[[requestArray objectAtIndex:i] objectForKey:@"p"]];
        [finalArray addObject:moreTampArray];
    }
    
    return finalArray;
}
-(NSMutableDictionary *)setNewOrderIdWithProduct:(NSMutableDictionary *)dataDic
{
    NSMutableDictionary *tempDic =[[NSMutableDictionary alloc] init];
    [tempDic setValue:[dataDic valueForKey:@"cooking_instruction"] forKey:@"cooking_instruction"];
    [tempDic setValue:[dataDic valueForKey:@"device_id"] forKey:@"device_id"];
    [tempDic setValue:[dataDic valueForKey:@"forced_modifier_ids"] forKey:@"forced_modifier_ids"];
    [tempDic setValue:[dataDic valueForKey:@"optional_modifier_ids"] forKey:@"optional_modifier_ids"];
    
    [tempDic setValue:[dataDic valueForKey:@"happy_hours_id"] forKey:@"happy_hours_id"];
    [tempDic setValue:[dataDic valueForKey:@"local_tax"] forKey:@"local_tax"];
    [tempDic setValue:[dataDic valueForKey:@"name"] forKey:@"name"];
    [tempDic setValue:[dataDic valueForKey:@"offer_amount"] forKey:@"offer_amount"];
    [tempDic setValue:orderID forKey:@"order_id"];
    [tempDic setValue:[dataDic valueForKey:@"order_product_id"] forKey:@"order_product_id"];
    [tempDic setValue:[dataDic valueForKey:@"other_tax"] forKey:@"other_tax"];
    [tempDic setValue:[dataDic valueForKey:@"pizza_base_id"] forKey:@"pizza_base_id"];
    [tempDic setValue:[dataDic valueForKey:@"points"] forKey:@"points"];
    [tempDic setValue:[dataDic valueForKey:@"pre_payment_flag"] forKey:@"pre_payment_flag"];
    [tempDic setValue:[dataDic valueForKey:@"price"] forKey:@"price"];
    [tempDic setValue:[dataDic valueForKey:@"product_id"] forKey:@"product_id"];
    [tempDic setValue:@"1" forKey:@"quantity"];
    [tempDic setValue:[dataDic valueForKey:@"restaurant_id"] forKey:@"restaurant_id"];
    [tempDic setValue:[dataDic valueForKey:@"setmenu_dish_id"] forKey:@"setmenu_dish_id"];
    [tempDic setValue:[dataDic valueForKey:@"service_tax"] forKey:@"service_tax"];
    [tempDic setValue:[dataDic valueForKey:@"setmenu_drink_id"] forKey:@"setmenu_drink_id"];
    [tempDic setValue:[dataDic valueForKey:@"setmenu_pizza_id"] forKey:@"setmenu_pizza_id"];
    [tempDic setValue:[dataDic valueForKey:@"size"] forKey:@"size"];
    [tempDic setValue:[dataDic valueForKey:@"size_value"] forKey:@"size_value"];
    [tempDic setValue:[dataDic valueForKey:@"sub_total"] forKey:@"sub_total"];
    [tempDic setValue:[dataDic valueForKey:@"size_value"] forKey:@"size_value"];
    [tempDic setValue:[dataDic valueForKey:@"tax_total"] forKey:@"tax_total"];
    [tempDic setValue:[dataDic valueForKey:@"topping_id_x1"] forKey:@"topping_id_x1"];
    [tempDic setValue:[dataDic valueForKey:@"topping_id_x2"] forKey:@"topping_id_x2"];
    [tempDic setValue:[dataDic valueForKey:@"topping_serving_size"] forKey:@"topping_serving_size"];
    [tempDic setValue:[dataDic valueForKey:@"type"] forKey:@"type"];
    [tempDic setValue:[dataDic valueForKey:@"topping_serving_size"] forKey:@"topping_serving_size"];
    [tempDic setValue:[dataDic valueForKey:@"unique_id"] forKey:@"unique_id"];
    [tempDic setValue:[dataDic valueForKey:@"update_status"] forKey:@"update_status"];
    [tempDic setValue:[dataDic valueForKey:@"vat"] forKey:@"vat"];
    
    return tempDic;
    
    //orderID // order_id
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
