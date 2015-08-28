//
//  OfferViewController.m
//  Vegan
//
//  Created by mithun ravi on 15/02/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import "OfferViewController.h"

@interface OfferViewController ()

@end

@implementation OfferViewController
@synthesize offerArray;
@synthesize restaurantID;

- (void)viewDidLoad
{
    [super viewDidLoad];
    offerTable.backgroundColor =[UIColor clearColor];
    offerArray=[[NSMutableArray alloc] init];
    [self gettingLoyality];
    lblTitle.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [lblTitle setFont: [lblTitle.font fontWithSize: 20.0]];


    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)clickOnCrossButton:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return offerArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"OfferTableViewCell";
    OfferTableViewCell *loyaltyCell = (OfferTableViewCell *)[offerTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (loyaltyCell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"OfferTableViewCell" owner:self options:nil];
        loyaltyCell = [cellArray objectAtIndex:0];
    }
    if (offerArray.count>0)
    {
        loyaltyCell.selectionStyle = UITableViewCellSelectionStyleNone;
        loyaltyCell.codeLebel.text=[NSString stringWithFormat:@"%@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"code"]];
        if ([[[offerArray objectAtIndex:indexPath.row] objectForKey:@"discount"] intValue]>0)
        {
            loyaltyCell.percentOffer.text=[NSString stringWithFormat:@"D: %@%s",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"discount"],"%"];
        }
        else
        {
            if ([[[offerArray objectAtIndex:indexPath.row] objectForKey:@"amount"] intValue]>0)
            {
                loyaltyCell.percentOffer.text=[NSString stringWithFormat:@"A: %@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"amount"]];
            }
            else
            {
                loyaltyCell.percentOffer.text=[NSString stringWithFormat:@"P: %@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"munch_points"]];
            }
        }
        
        NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/coupon/%@",ciboRestaurantId,[NSString stringWithFormat:@"%@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"image"]]]];
        NSLog(@"%@",imageurl);
        [loyaltyCell.logoImage setImageWithURL:imageurl];
        [loyaltyCell.detailLabel setText:[NSString stringWithFormat:@"%@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"coupon_name"]]];
    }
    loyaltyCell.percentOffer.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    
    loyaltyCell.detailLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [loyaltyCell.detailLabel setFont: [loyaltyCell.detailLabel.font fontWithSize: 12.0]];

    loyaltyCell.codeLebel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [loyaltyCell.codeLebel setFont: [loyaltyCell.codeLebel.font fontWithSize: 12.0]];
    return loyaltyCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *discount =nil;
    if ([[[offerArray objectAtIndex:indexPath.row] objectForKey:@"discount"] intValue]>0)
    {
        discount=[NSString stringWithFormat:@"Discount: %@%s",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"discount"],"%"];
        offerDiscount=[[offerArray objectAtIndex:indexPath.row] objectForKey:@"discount"];
    }
    else
    {
        if ([[[offerArray objectAtIndex:indexPath.row] objectForKey:@"amount"] intValue]>0)
        {
            discount=[NSString stringWithFormat:@"Amount: %@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"amount"]];
            offerAmount=[[offerArray objectAtIndex:indexPath.row] objectForKey:@"amount"];
            
        }
        else
        {
            discount=[NSString stringWithFormat:@"Points: %@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"munch_points"]];
            offerPoints=[[offerArray objectAtIndex:indexPath.row] objectForKey:@"munch_points"];
        }
    }
    selectedOfferID =[[offerArray objectAtIndex:indexPath.row] objectForKey:@"coupon_id"];
    NSString *offerName = nil;
    offerName = [NSString stringWithFormat:@"%@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"coupon_name"]];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:offerName message:[NSString stringWithFormat:@"You want %@ discount.",discount] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

-(void)gettingLoyality
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"munchPoints/munchPointsData/restId/%@",restaurantID];
    NSLog(@"%@",postString);
    
    [helper gettingLoyalityPunch:postString];
}

-(void)gettingLoyalityPunch:(NSString *)response
{
    [offerArray removeAllObjects];
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    offerArray =[dataDic objectForKey:@"pointInfo"];
    
    if (offerArray.count>0)
    {
        [offerTable reloadData];
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Loaded." :2.0];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"Please try again." :2.0];
    }
}
-(void)gettingFail:(NSString *)error
{
    [MyCustomeClass SVProgressMessageDismissWithError:@"Please try again." :2.0];
}

#pragma mark - alertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Yes"])
    {
        [[NSUserDefaults standardUserDefaults] setValue:offerDiscount forKey:@"OfferDiscount"];
        [[NSUserDefaults standardUserDefaults] setValue:offerAmount forKey:@"OfferAmounts"];
        [[NSUserDefaults standardUserDefaults] setValue:offerPoints forKey:@"OfferPoints"];
        [[NSUserDefaults standardUserDefaults] setValue:selectedOfferID forKey:@"selectedOfferID"];//
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self dismissViewControllerAnimated:true completion:nil];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"OfferDiscount"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"OfferAmounts"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"selectedOfferID"];//

        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"OfferPoints"];        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}



@end
