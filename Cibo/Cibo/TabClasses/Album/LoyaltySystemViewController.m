//
//  LoyaltySystemViewController.m
//  Cibo
//
//  Created by mithun ravi on 30/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "LoyaltySystemViewController.h"

@interface LoyaltySystemViewController ()

@end

@implementation LoyaltySystemViewController
@synthesize loyaltyTable;
@synthesize pointListView;
@synthesize offerArray,userMunchPoints;
@synthesize totalPoints,qrCode,titleLabel;
@synthesize myTotalPoint,redemptionLabel;
@synthesize generatedQRCodeImage;
@synthesize userselectedOffter;
@synthesize collectionView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    lblTitle.font=[UIFont fontWithName:FONT_Ragular size:18.0];
    [lblTitle setFont: [lblTitle.font fontWithSize: 18.0]];


    UINib *cellNib = [UINib nibWithNibName:@"LoyalCollectionCell" bundle:nil];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:@"LoyalCollectionCell"];
    
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(135, 160)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [collectionView setCollectionViewLayout:flowLayout];
    loyaltyTable.hidden=NO;
    collectionView.hidden=YES;
    
    loyaltyDefault=[NSUserDefaults standardUserDefaults];
    offerArray=[[NSMutableArray alloc] init];
    userMunchPoints=[[NSMutableArray alloc] init];
    userselectedOffter=[[NSMutableArray alloc] init];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    moveupDown=true;
    moveLeftRight=true;
    [loyaltyTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [MyCustomeClass drawBorder:pointListView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     NSLog(@"Email=%lu",(unsigned long)[[loyaltyDefault objectForKey:@"Email"] length]);
    titleLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Munch points"];
    myTotalPoint.text=[MyCustomeClass languageSelectedStringForKey:@"My Total Points"];
    redemptionLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Redemption"];
    if ([[loyaltyDefault objectForKey:@"Email"] length]>0)
    {
        [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Loading Spacial offer..."]];
        [self gettingUserMounchPoints];
        [appDelegate tabBarShow];
    }
    else
    {
        [appDelegate tabBarHide];
        ViewController *viewController=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [self presentViewController:viewController animated:true completion:nil];
    }
    [appDelegate tabBarHide];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - action method list
-(IBAction)clickOnHomeButton:(id)sender
{
    UIApplication *application=nil;
    NSDictionary *dic=nil;
    [loyaltyDefault setValue:@"Home" forKey:@"RootView"];
    [loyaltyDefault setValue:@"Home" forKey:@"Logout"];
    [appDelegate application:application didFinishLaunchingWithOptions:dic];
}
-(IBAction)clickOnCrossCornerButton:(id)sender
{
    [self moveViewUp:YES];
    moveupDown=true;
}
-(IBAction)clickOnRightUpperConrnerButton:(id)sender
{
    if(offerArray.count<=0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Offer not available now." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil,nil] show];
    }
    else
    {
        if(moveupDown==true)
        {
            moveupDown=false;
            [self moveViewUp:NO];
        }
        else
        {
            [self moveViewUp:YES];
            moveupDown=true;
        }
    }
}

-(IBAction)clickOnCellPhoneButton:(id)sender
{
   
}

-(IBAction)clickOnYellowButton:(id)sender event:(id)event
{
    if (IS_IOS8)
        loyaltyCell = (LoyaltyCell *)[[sender superview] superview] ;
    else
        loyaltyCell = (LoyaltyCell *)[[[sender superview] superview] superview] ;
    
    NSIndexPath *clickedButtonPath = [loyaltyTable indexPathForCell:loyaltyCell];
    cellValue=(int)clickedButtonPath.row;
    
    if ([[[offerArray objectAtIndex:cellValue] objectForKey:@"discount"] intValue]>0)
    {
        discountCoupenId=[[[offerArray objectAtIndex:cellValue] objectForKey:@"discount"] intValue];
        if ([[[offerArray objectAtIndex:cellValue] objectForKey:@"amount"] intValue]>0)
        {
            discountCoupenId=[[[offerArray objectAtIndex:cellValue] objectForKey:@"amount"] intValue];
        }
    }
    else
    {
        choosedMunchPoint=[[offerArray objectAtIndex:cellValue] objectForKey:@"munch_points"];
    }
    
    NSLog(@"%@",[[offerArray objectAtIndex:cellValue] objectForKey:@"munch_points"]);
    if (choosedMunchPoint.length>0 && ![choosedMunchPoint isEqualToString:@"0"])
    {
        if ([[[userMunchPoints objectAtIndex:0] objectForKey:@"points"] intValue] >[[NSString stringWithFormat:@"%@",[[offerArray objectAtIndex:cellValue] objectForKey:@"munch_points"]] intValue] )
        {
            UIAlertView *alert=[[UIAlertView alloc]  initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"You want to redem"] message:[MyCustomeClass languageSelectedStringForKey:@"from points"] delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"NO"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"Confirm"], nil];
            [alert show];
            redeemingPointsID=[[offerArray objectAtIndex:cellValue] objectForKey:@"coupon_id"];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]  initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"You have not enough points"] message:[MyCustomeClass languageSelectedStringForKey:@"to get this item"] delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"Cancel"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"OK"], nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]  initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"You want to redem"] message:[MyCustomeClass languageSelectedStringForKey:@"from this spetial offer"] delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"NO"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"YES"], nil];
        [alert show];
        
    }
    
    
}

-(IBAction)clickOnScanCellButton:(id)sender
{
    ScanViewController *scanVC=[[ScanViewController alloc]  initWithNibName:@"ScanViewController" bundle:nil];
    [self presentViewController:scanVC animated:true completion:nil];
    
}

-(IBAction)sliderUpdate:(UISlider *)sender
{
    if (IS_IOS8)
    {
        loyaltyCell = (LoyaltyCell *)[[sender superview] superview];
    }
    else
    {
        loyaltyCell = (LoyaltyCell *)[[[sender superview] superview] superview];
    }
    NSIndexPath *clickedButtonPath = [self.loyaltyTable indexPathForCell:loyaltyCell];
    
    if (clickedButtonPath.row>=0)
     {
           // loyaltyCell.numberLable.text=[NSString stringWithFormat:@"%.f",sender.value];
     }
   // NSLog(@"%.f",sender.value);
           
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
    return 114;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier1=@"LoyaltyCell";
    static NSString *CellIdentifier2=@"NoRebanLoyaltyCell";
   loyaltyCell = (LoyaltyCell *)[loyaltyTable dequeueReusableCellWithIdentifier:CellIdentifier1];
   noRebanLoyaltyCell = (NoRebanLoyaltyCell *)[loyaltyTable dequeueReusableCellWithIdentifier:CellIdentifier2];

    if (loyaltyCell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"LoyaltyCell" owner:self options:nil];
        loyaltyCell = [cellArray objectAtIndex:0];
    }
    if (offerArray.count>0)
    {
        //loyaltyCell.selectionStyle = UITableViewCellSelectionStyleNone;
        loyaltyCell.codeLabel.text=[NSString stringWithFormat:@"  (Code: %@)",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"code"]];
        if ([[[offerArray objectAtIndex:indexPath.row] objectForKey:@"discount"] intValue]>0)
        {
            loyaltyCell.discountPersent.text=[NSString stringWithFormat:@"%@ %s",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"discount"],"%"];
        }
        else
        {
            if ([[[offerArray objectAtIndex:cellValue] objectForKey:@"amount"] intValue]>0)
            {
                loyaltyCell.discountPersent.text=[NSString stringWithFormat:@"%@ %s",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"amount"],"%"];
            }
            else
            {
                loyaltyCell.discountPersent.text=[NSString stringWithFormat:@"%@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"munch_points"]];

            }
        }
        
        [loyaltyCell.sliderCell addTarget:self action:@selector(clickOnYellowButton: event:) forControlEvents:UIControlEventTouchUpInside];
        [loyaltyCell.sliderCell addTarget:self action:@selector(sliderUpdate:) forControlEvents:UIControlEventTouchUpInside];
       
        [loyaltyCell.loyaltreeLabel setText:[NSString stringWithFormat:@"  %@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"coupon_name"]]];
        loyaltyCell.descriptionLabel.text = @"  No Description";
        [MyCustomeClass drawBorder:loyaltyCell.cellSubView];
        
    }
    loyaltyCell.descriptionLabel.font=[UIFont fontWithName:FONT_Ragular size:13.0];
    [loyaltyCell.descriptionLabel setFont: [loyaltyCell.loyaltreeLabel.font fontWithSize: 13.0]];

    loyaltyCell.loyaltreeLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [loyaltyCell.loyaltreeLabel setFont: [loyaltyCell.loyaltreeLabel.font fontWithSize: 12.0]];
    
    loyaltyCell.codeLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [loyaltyCell.codeLabel setFont: [loyaltyCell.loyaltreeLabel.font fontWithSize: 12.0]];
    
    loyaltyCell.discountPersent.font=[UIFont fontWithName:FONT_Ragular size:25.0];
    [loyaltyCell.discountPersent setFont: [loyaltyCell.loyaltreeLabel.font fontWithSize: 25.0]];
    
    [loyaltyCell.discountPersent setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
    //


    return loyaltyCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


#pragma  mark - move view upper and lower side

-(void) moveViewUp:(BOOL)up
{
    CGRect viewFrame = self.pointListView.frame;
    viewFrame.origin.y -= +425 * (up? 1: -1);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:1.00];

    self.pointListView.frame = viewFrame;
    [UIView commitAnimations];

}
#pragma mark - Webservics Request classes
-(void)addingRedeemingPointsRequest
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"munchPoints/munch_pointsredeem_add/restaurant_id/%@/member_id/%@",[loyaltyDefault objectForKey:@"Restaurantid"],[loyaltyDefault objectForKey:@"Member"]];
    NSLog(@"%@",postString);
    NSString *postData=[NSString stringWithFormat:@"coupon_id=%@",redeemingPointsID];
    
    NSLog(@"%@",postData);
    [helper addingRedeemingPoints:postData:postString];
}
-(void)redemmingMunchPointse
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Redeeming your points..."]];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"munchPoints/redeemPoints/restId/%@/memberId/%@",[loyaltyDefault objectForKey:@"Restaurantid"],[loyaltyDefault objectForKey:@"Member"]];
    NSLog(@"%@",postString);
    NSString *postData=[NSString stringWithFormat:@"points=%@",choosedMunchPoint];
    
    NSLog(@"%@",postData);
    [helper redemmingMunchPoints:postData :postString];

}
-(void)gettingLoyality
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"munchPoints/munchPointsData/restId/%@",[loyaltyDefault objectForKey:@"Restaurantid"]];
    NSLog(@"%@",postString);
    
    [helper gettingLoyalityPunch:postString];
}

-(void)gettingUserMounchPoints
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"munchPoints/memberPoints/restId/%@/memberId/%@",[loyaltyDefault objectForKey:@"Restaurantid"],[loyaltyDefault objectForKey:@"Member"]];
    NSLog(@"%@",postString);
    [helper gettingUserMounchPoints:postString];
}
-(void)getUserRedeemingItemList:(NSString *) couponid
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Special offer..."];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"restaurant_id/%@/member_id/%@/coupon_id/%@",[loyaltyDefault objectForKey:@"Restaurantid"],[loyaltyDefault objectForKey:@"Member"],couponid];
    NSLog(@"%@",postString);
    [helper userRedeemingPoint:@"" :postString];
}

//////////////////////// response /////


#pragma mark - Webservics Response classes
-(void)addingRedeemingPoints:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%d",increasePoint);
    if(dataDic.count<=0)
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"" :0.0];
        return;
    }
    
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
         NSString *code = [NSString stringWithFormat:@"Couponid:%@\nRestaurant id:%@\nUserId:%@\nOffer:%@",couponID,[loyaltyDefault objectForKey:@"Restaurantid"],[loyaltyDefault objectForKey:@"Member"],@""];
           self.generatedQRCodeImage.image = [UIImage QRCodeGenerator:code
                                  andLightColour:[UIColor yellowColor]
                                   andDarkColour:[UIColor redColor]
                                    andQuietZone:1
                                         andSize:150];
        
        qrCode.text=[NSString stringWithFormat:@"Code:%@",[[offerArray objectAtIndex:cellValue] objectForKey:@"code"]];
        [self clickOnRightUpperConrnerButton:self];
        [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Loading Spacial offer..."]];
        [self gettingUserMounchPoints];
    }
    else
    {
        
    }

}
-(void)userRedeemingPoint:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
   
    NSLog(@"%d",increasePoint);
    if(dataDic.count<=0)
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"" :0.0];
    }

    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
        
    }
    else
    {
        [offerArray addObject:[userselectedOffter objectAtIndex:increasePoint]];
        //NSLog(@"%@",offerArray);
    }
    increasePoint++;
    if (redeemingPoints==increasePoint)
    {
        if ([offerArray count] >0)
        {
            [loyaltyTable reloadData];
            [collectionView reloadData];
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Successfully done."] :1.0];
        }
        else
        {
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Offer is not available."] :2.0];
        }
    }
    else
    {
        couponID=[[userselectedOffter objectAtIndex:increasePoint] objectForKey:@"coupon_id"];
        [self getUserRedeemingItemList:[[userselectedOffter objectAtIndex:increasePoint] objectForKey:@"coupon_id"]];
    }
   
}
-(void)redemmingMunchPoints:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    if(dataDic.count<=0)
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"" :0.0];
        return;
    }
    
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCESS"])
    {
        [self addingRedeemingPointsRequest];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Please try again." :1.0];
    }
}

-(void)gettingLoyalityPunch:(NSString *)response
{
    [offerArray removeAllObjects];
    //[];
    [userselectedOffter removeAllObjects];
  //  NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    //offerInfo
    userselectedOffter =[dataDic objectForKey:@"pointInfo"];
    NSLog(@"%@",userselectedOffter);
    redeemingPoints=(int )userselectedOffter.count;
    increasePoint=0;
    if (userselectedOffter.count>0)
    {
        [self getUserRedeemingItemList:[[userselectedOffter objectAtIndex:increasePoint] objectForKey:@"coupon_id"]];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"" :0.10];
    }
}
-(void)gettingUserMounchPoints:(NSString *)response
{
   // NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    //offerInfo
    if(dataDic.count<=0)
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"" :0.0];
        return;
    }
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
        userMunchPoints =[dataDic objectForKey:@"pointInfo"];
        if (discountCoupenId<=0)
        {
            [self gettingLoyality];
        }
        NSLog(@"%@",userMunchPoints);
        if (userMunchPoints.count>0)
        {
            totalPoints.text=[[userMunchPoints objectAtIndex:0] objectForKey:@"points"];
        }
        else
        {
            
        }

    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"" :1.0];
    }

}
-(void)gettingFail:(NSString*)error
{
    NSLog(@"%@",error);
    [MyCustomeClass SVProgressMessageDismissWithSuccess:error :2.00];
}

#pragma mark - alertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"Cancel"]] || [title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"OK"]])
    {
        //[loyaltyCell.sliderCell setContinuous:NO];
        //[loyaltyCell.sliderCell setValue:loyaltyCell.sliderCell.minimumValue animated:NO];
        //loyaltyCell.numberLable.text=[NSString stringWithFormat:@"%.f",loyaltyCell.sliderCell.maximumValue];
    }
    else if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"Confirm"]])
    {
        [self redemmingMunchPointse];

    }
    else if([title isEqualToString:@"YES"])
    {
        [self redemFromDiscount];
    }
}

-(NSString *)dicountToPointCalculation:(NSString *)discount
{
  return @"";
}

-(void)redemFromDiscount
{
     NSString *code = [NSString stringWithFormat:@"Couponid:%@\nRestaurant id:%@\nUserId:%@\noffer:%d",couponID,[loyaltyDefault objectForKey:@"Restaurantid"],[loyaltyDefault objectForKey:@"Member"],discountCoupenId];
    
    self.generatedQRCodeImage.image = [UIImage QRCodeGenerator:code
                                                andLightColour:[UIColor yellowColor]
                                                 andDarkColour:[UIColor redColor]
                                                  andQuietZone:1
                                                       andSize:150];
    
    qrCode.text=[NSString stringWithFormat:@"Code:%@",[[offerArray objectAtIndex:cellValue] objectForKey:@"code"]];
    //[MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Generating code..."]];

    [self gettingUserMounchPoints];
    [self moveViewUp:NO];


}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LoyalCollectionCell *loyalCell1 = (LoyalCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LoyalCollectionCell" forIndexPath:indexPath];
    
    if (offerArray.count>0)
    {
        loyalCell1.codeLabel.text=[NSString stringWithFormat:@"(Code:%@)",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"code"]];
        if ([[[offerArray objectAtIndex:indexPath.row] objectForKey:@"discount"] intValue]>0)
        {
            loyalCell1.discountPersent.text=[NSString stringWithFormat:@"%@ %s OFF",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"discount"],"%"];
            [loyalCell1.discountPersent setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];

        }
        else
        {
            if ([[[offerArray objectAtIndex:cellValue] objectForKey:@"amount"] intValue]>0)
            {
                loyalCell1.discountPersent.text=[NSString stringWithFormat:@"%@ %s OFF",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"amount"],"%"];
                [loyalCell1.discountPersent setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];

            }
            else
            {
                loyalCell1.discountPersent.text=[NSString stringWithFormat:@"Points: %@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"munch_points"]];
                [loyalCell1.discountPersent setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];

            }
        }
        //loyaltyCell.descriptionLabel.text=[[offerArray objectAtIndex:indexPath.row] objectForKey:@"image"];
        [loyalCell1.sliderCell addTarget:self action:@selector(clickOnYellowButton: event:) forControlEvents:UIControlEventTouchUpInside];
        //[loyaltyCell.sliderCell addTarget:self action:@selector(sliderUpdate:) forControlEvents:UIControlEventTouchUpInside];
        
        NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/coupon/%@",[loyaltyDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"image"]]]];
        NSLog(@"%@",imageurl);
        [loyalCell1.foodImage setImageWithURL:imageurl];
        [loyalCell1.loyaltreeLabel setText:[NSString stringWithFormat:@"%@",[[offerArray objectAtIndex:indexPath.row] objectForKey:@"coupon_name"]]];
        [MyCustomeClass drawBorder:loyaltyCell.foodImage];
    }
    
    loyalCell1.loyaltreeLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [loyalCell1.loyaltreeLabel setFont: [loyalCell1.loyaltreeLabel.font fontWithSize: 12.0]];

    loyalCell1.discountPersent.font=[UIFont fontWithName:FONT_Ragular size:25.0];
    [loyalCell1.discountPersent setFont: [loyalCell1.discountPersent.font fontWithSize: 22.0]];
    [loyalCell1.discountPersent setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];


  
    loyalCell1.codeLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [loyalCell1.codeLabel setFont: [loyalCell1.codeLabel.font fontWithSize: 12.0]];


    return loyalCell1;
}

- (void)collectionView:(UICollectionView *)collectionView1 didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}




@end
