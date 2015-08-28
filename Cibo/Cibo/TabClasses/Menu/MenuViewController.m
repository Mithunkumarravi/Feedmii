//
//  MenuViewController.m
//  Cibo
//
//  Created by mithun ravi on 20/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize tabScrollView;
@synthesize coverflowView;
@synthesize coverImageArray;
@synthesize menuTable;
@synthesize menuArray;
@synthesize centerFlowImageNameLabel,selectedItemTitleList;

@synthesize orderListView,itempriceView;
@synthesize orderListTable;
@synthesize orderListArray;
@synthesize subTotal,servicesChargeLabel,totelLable;
@synthesize selectedItemLabel,TotalPriceList;
@synthesize titleLabel;
@synthesize categoryArray,subCategoryArray,itemFromSubCategory;
@synthesize priceList;
@synthesize finalArrayForDish,finalArrayForDrink;
@synthesize dishesButton,dirnkButton,pizzaButton,setMenuButton,offerButton,orderClear;
@synthesize covrflowbutton;
@synthesize subTotelLabelLabel,serviceschargeLabelLabel,totalLabelLabel;
@synthesize selectedOrderArray1,selectedOrderArray2,selectedOrderArray3,selectedOrderArray4,selectedOrderArray5;
@synthesize orderTitleLabel,orderView;
@synthesize cancelButton,nowOrderButton;
@synthesize firstNameText,surNameText,addrssNameText,emailAddressText, cityText,stateText,countryText,mobileText,postCodeText;
@synthesize scrollViewOrder;
@synthesize modifierSelectedItemsArray;
@synthesize selecetePizzaOption;
@synthesize taxArray;

///////////// order selection ////
@synthesize selectedOrderArray,finalArray;
@synthesize forceModifier,optionModifier;
@synthesize selectedFModifierList, selectedOModifierList;
@synthesize pizzaBaseArray,pizzaToppingArray,pizzaSizeArray,choosedPizzaDetail;

@synthesize pizzaTable;
@synthesize collectionView;
@synthesize happyHourArray;
@synthesize arrayForBool;

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
    /////////////////////////////
    modifierView.layer.cornerRadius = 8;
    modifierView.layer.masksToBounds = YES;
    
    orderListView.layer.cornerRadius = 8;
    orderListView.layer.masksToBounds = YES;
    
    submit1Button.layer.cornerRadius = 10;
    submit1Button.clipsToBounds = YES;
    
    submit2Button.layer.cornerRadius = 10;
    submit2Button.clipsToBounds = YES;
    
    
    UINib *cellNib = [UINib nibWithNibName:@"MenuCollectionCell" bundle:nil];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:@"MenuCollectionCell"];
    
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(150, 175)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [collectionView setCollectionViewLayout:flowLayout];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    menuTable.hidden=NO;
    menuTable.separatorColor=[UIColor clearColor];
    collectionView.hidden=YES;
    
    orderView.hidden=YES;
    
    _carousel.type = iCarouselTypeRotary;
    [_carousel setBackgroundColor:[UIColor clearColor]];
    _carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (IS_IPHONE5)
    {
        scrollViewOrder.frame=CGRectMake(0, 0, 320, 500);
        scrollViewOrder.contentSize = CGSizeMake(320, 680);
        _carousel.frame=CGRectMake(0, itempriceView.frame.origin.y+itempriceView.frame.size.height, 320, 100);
    }
    else
    {
        scrollViewOrder.frame=CGRectMake(0, 0, 320, 400);
        scrollViewOrder.contentSize = CGSizeMake(320, 550);
        _carousel.frame=CGRectMake(0, itempriceView.frame.origin.y+itempriceView.frame.size.height+30, 320, 100);
    }
    mkv = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(25,0, 25,25)];
    
    scrollViewOrder.backgroundColor=[UIColor clearColor];
    /////////////////////////////
    [coverflowView setBackgroundColor:[UIColor clearColor]];
    orderListTable.backgroundColor=[UIColor clearColor];
    menuDefault=[NSUserDefaults standardUserDefaults];
    selectedOrderArray=[[NSMutableArray alloc] init];
    finalArray=[[NSMutableArray alloc] init];
    finalArrayForDish=[[NSMutableArray alloc] init];
    finalArrayForDrink=[[NSMutableArray alloc] init];
    //////////////////////
    categoryArray=[[NSMutableArray alloc] init];
    subCategoryArray=[[NSMutableArray alloc] init];
    arrayForBool =[[NSMutableArray alloc] init];
    selectedOrderArray1=[[NSMutableArray alloc] init];
    selectedOrderArray2=[[NSMutableArray alloc] init];
    selectedOrderArray3=[[NSMutableArray alloc] init];
    selectedOrderArray4=[[NSMutableArray alloc] init];
    selectedOrderArray5=[[NSMutableArray alloc] init];
    forceModifier=[[NSMutableArray alloc] init];
    optionModifier=[[NSMutableArray alloc] init];
    modifierSelectedItemsArray=[[NSMutableArray alloc] init];
    selectedFModifierList=[[NSMutableArray alloc] init];
    selectedOModifierList=[[NSMutableArray alloc] init];
    pizzaBaseArray = [[NSMutableArray alloc] init];
    pizzaSizeArray = [[NSMutableArray alloc] init];
    pizzaToppingArray = [[NSMutableArray alloc] init];
    selecetePizzaOption=[[NSMutableArray alloc] init];
    choosedPizzaDetail=[[NSMutableArray alloc] init];
    taxArray=[[NSMutableArray alloc] init];
    happyHourArray =[[NSMutableArray alloc] init];
    
    [MyCustomeClass drawBorder:itempriceView];
    
    modiferTable.backgroundColor=[UIColor clearColor];
    pizzaTable.backgroundColor=[UIColor clearColor];
    
    /* modifierTitle.font=[UIFont fontWithName:FONT size:30.0];
     pizzaTitle.font=[UIFont fontWithName:FONT size:30.0];
     selectedItemLabel.font=[UIFont fontWithName:FONT size:15.0];
     TotalPriceList.font=[UIFont fontWithName:FONT size:15.0];
     centerFlowImageNameLabel.font=[UIFont fontWithName:FONT size:15.0];
     selectedItemTitleList.font=[UIFont fontWithName:FONT size:15.0];
     subTotal.font=[UIFont fontWithName:FONT size:15.0];
     
     servicesChargeLabel.font=[UIFont fontWithName:FONT size:15.0];
     totelLable.font=[UIFont fontWithName:FONT size:15.0];
     titleLabel.font=[UIFont fontWithName:FONT size:15.0];
     serviceschargeLabelLabel.font=[UIFont fontWithName:FONT size:15.0];
     subTotelLabelLabel.font=[UIFont fontWithName:FONT size:15.0];
     totalLabelLabel.font=[UIFont fontWithName:FONT size:15.0];
     orderTitleLabel.font=[UIFont fontWithName:FONT size:15.0];
     
     badgeButton.titleLabel.font=[UIFont fontWithName:FONT size:10.0];
     dishesButton.titleLabel.font=[UIFont fontWithName:FONT size:17.0];
     dirnkButton.titleLabel.font=[UIFont fontWithName:FONT size:17.0];
     pizzaButton.titleLabel.font=[UIFont fontWithName:FONT size:17.0];
     offerButton.titleLabel.font=[UIFont fontWithName:FONT size:17.0];
     orderClear.titleLabel.font=[UIFont fontWithName:FONT size:17.0];
     covrflowbutton.titleLabel.font=[UIFont fontWithName:FONT size:17.0];
     cancelButton.titleLabel.font=[UIFont fontWithName:FONT size:17.0];
     nowOrderButton.titleLabel.font=[UIFont fontWithName:FONT size:17.0];
     submit1Button.titleLabel.font=[UIFont fontWithName:FONT size:25.0];
     submit2Button.titleLabel.font=[UIFont fontWithName:FONT size:25.0];
     checkoutButton.titleLabel.font=[UIFont fontWithName:FONT size:25.0];
     orderLabelTitle.font=[UIFont fontWithName:FONT size:30.0];
     fmItam.font=[UIFont fontWithName:FONT size:25.0];
     fmPrice.font=[UIFont fontWithName:FONT size:25.0];
     setMenuButton.titleLabel.font=[UIFont fontWithName:FONT size:20.0];*/
    
    [self fillsplitArray];
    modifierView.hidden=YES;
    pizzaView.hidden=YES;
    [self taxRequest];
    
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"RestaurantDetail"];
    
    NSDictionary *restaurantDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (restaurantDic.count<=0)
    {
        [self restaurentLatiLongRequest];
    }
    else
    {
        latitude1=[[NSString stringWithFormat:@"%@",[restaurantDic objectForKey:@"lat"]] floatValue];
        longitude1=[[NSString stringWithFormat:@"%@",[restaurantDic objectForKey:@"lon"]] floatValue];
        //latitude1=24.4607833;
        //longitude1=54.3807539;
    }
    
    selectedItemLabel.text=@"Items:0";
    TotalPriceList.text=@"0";
    centerFlowImageNameLabel.text=@"";
    itemFromSubCategory=[[NSMutableArray alloc] init];
    
    //////////////////////
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (IS_IPHONE5)
    {
        tabScrollView.frame=CGRectMake(-5, 50, 330, 40);
        coverflowView.frame=CGRectMake(0, 85, 320, 378);
        itempriceView.frame=CGRectMake(-5, itempriceView.frame.origin.y, 330, itempriceView.frame.size.height);
    }
    else
    {
        tabScrollView.frame=CGRectMake(-5, 135, 330, 40);
        coverflowView.frame=CGRectMake(0, 0, 320, 376);
        itempriceView.frame=CGRectMake(-5, 320,330, itempriceView.frame.size.height);
        centerFlowImageNameLabel.frame=CGRectMake(110, 410, 101, 21);
        //covrflowbutton.frame=CGRectMake(140, 360, 80, 10);
    }
    orderListView.hidden=YES;
    orderListShowAndHide=true;
    // orderListView.backgroundColor= [UIColor clearColor];
    tabScrollView.scrollEnabled=YES;
    tabScrollView.pagingEnabled=YES;
    tabScrollView.showsVerticalScrollIndicator=YES;
    // tabScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 69, 320, 29)];
    tabScrollView.contentSize = CGSizeMake(600, 29);
    loadImageOpreteion = [[NSOperationQueue alloc] init];
    orderListArray =[[NSMutableArray alloc] init];;
    //////////// array memory allocation ///////
    menuArray=[[NSMutableArray alloc] init];
    ////////////////////////////////////////////
    coverImageArray=[[NSMutableArray alloc] initWithObjects:@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png", nil];
    //tabScrollView.backgroundColor=[UIColor clearColor];
    orderListArray =[[NSMutableArray alloc] initWithObjects:@"order list ek",@"order list do",@"order number teen",@"order number Four", nil];
    
    NSString *postData=[NSString stringWithFormat:@"category/viewCategory/restId/%@",[menuDefault objectForKey:@"Restaurantid"]];
    CategoryString=@"Dishes";
    
    [self gettingCategoryListLocal:postData];
    menuTable.backgroundColor=[UIColor clearColor];
    modiferTable.separatorStyle=UITableViewCellSelectionStyleNone;
    [dishesButton setBackgroundImage:[UIImage imageNamed:@"hot dog.png"] forState:UIControlStateNormal];
    [dishesButton setTitleColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(0/255.f) alpha:1.0 ]forState: UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
    
    if ([appDelegate.openandPaymentWay isEqualToString:@"Menu" ])
    {
        [checkoutButton setTitle:@"Send" forState:UIControlStateNormal];
    }
    else
    {
        [checkoutButton setTitle:@"Checkout" forState:UIControlStateNormal];
    }
}
-(void)fillsplitArray
{
    [arrayForBool removeAllObjects];
    if (arrayForBool)
    {
        arrayForBool    = [NSMutableArray arrayWithObjects:
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - action method list
-(IBAction)clickOnHomeButton:(id)sender
{
    [self homeButton];
}
-(void)homeButton
{
    UIApplication *application=nil;
    NSDictionary *dic=nil;
    [menuDefault setValue:@"Home" forKey:@"RootView"];
    [menuDefault setValue:@"Home" forKey:@"Logout"];
    [appDelegate application:application didFinishLaunchingWithOptions:dic];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setLanguageOnObject];
    
    if (appDelegate.bookedTable.length>0)
    {
        [self orderWithDefaultAddrss];
        return;
    }
    
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"OrderArray"];
    if (data.length<=0)
        return;
    
    NSArray *countArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (countArray.count>=1)
    {
        UIAlertView *selectedOrderAlert=[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"You want to continue with selected order?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [selectedOrderAlert show];
    }
    else
    {
        [finalArray removeAllObjects];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"OrderArray"];
    }
    [appDelegate tabBarHide];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [appDelegate tabBarHide];
}

-(void)setLanguageOnObject
{
    [dishesButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"DISHES"] forState:UIControlStateNormal];
    [dirnkButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"DRINKS"] forState:UIControlStateNormal];
    [pizzaButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"PIZZA"] forState:UIControlStateNormal];
    [offerButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"SPECIAL OFFER"] forState:UIControlStateNormal];
    [setMenuButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"SET MENU"] forState:UIControlStateNormal];
    [orderClear setTitle:[MyCustomeClass languageSelectedStringForKey:@"Order Clear"] forState:UIControlStateNormal];
    subTotelLabelLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Sub Total:"];
    serviceschargeLabelLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Services charge(10%):"];
    
    totalLabelLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Total:"];
    [setMenuButton.titleLabel setFont:[UIFont fontWithName:FONT_Ragular size:14.0]];
    [dirnkButton.titleLabel setFont:[UIFont fontWithName:FONT_Ragular size:14.0]];
    [dishesButton.titleLabel setFont:[UIFont fontWithName:FONT_Ragular size:14.0]];
    [pizzaButton.titleLabel setFont:[UIFont fontWithName:FONT_Ragular size:14.0]];
    [setMenuButton.titleLabel setFont:[UIFont fontWithName:FONT_Ragular size:14.0]];

    //titleLabel.text=[MyCustomeClass languageSelectedStringForKey:[NSString stringWithFormat:@"%@",[menuDefault objectForKey:@"Restaurantname"]]];
    //titleLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Demoshop"];
    titleLabel.text=ciboRestaurantName;
    
}
-(IBAction)clickOnOrderCrossButton:(id)sender
{
    orderListShowAndHide=true;
    orderListView.hidden=YES;
}

-(IBAction)clickOnOrderClearButton:(id)sender
{
    [finalArray removeAllObjects];
    [selectedOrderArray removeAllObjects];
    orderListShowAndHide=true;
    orderListView.hidden=YES;
    pizzaString=nil;
    [self addRedBadge:NO];
    [self dishdrinkpizzaisNotShow:NO];
    selectedItemLabel.text=[NSString stringWithFormat:@"Items:0"];
    TotalPriceList.text=[NSString stringWithFormat:@"0"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKeyPath:@"OrderArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    itemCountLabel.text=@"0";
}

-(IBAction)clickOnListButton:(id)sender
{
    if (finalArray.count>0)
    {
        if (orderListShowAndHide == true)
        {
            orderListShowAndHide=false;
            orderListView.hidden=NO;
        }
        else
        {
            orderListShowAndHide=true;
            orderListView.hidden=YES;
        }
    }
    else
    {
        UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Please Choose some item before open order list." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

-(IBAction)clickOnScrollingButton:(id)sender
{
    NSString *postData=nil;
    _carousel.hidden=YES;
    covrflowbutton.hidden=YES;
    
    if ([sender tag]==1000)
    {
        postData=[NSString stringWithFormat:@"category/viewDishCategory/restId/%@/",[menuDefault objectForKey:@"Restaurantid"]];
        CategoryString=@"Dishes";
        NSLog(@"dish");
        [dishesButton setBackgroundImage:[UIImage imageNamed:@"hot dog.png"] forState:UIControlStateNormal];
        [dirnkButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [pizzaButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [setMenuButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [offerButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        
        [dishesButton setTitleColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(0/255.f) alpha:1.0 ]forState: UIControlStateNormal];
        [dirnkButton setTitleColor:ScrollColor forState: UIControlStateNormal];
        [pizzaButton setTitleColor:ScrollColor forState: UIControlStateNormal];
        
        [setMenuButton setTitleColor:ScrollColor forState: UIControlStateNormal];
        
        [offerButton setTitleColor:ScrollColor forState: UIControlStateNormal];
        
        _carousel.hidden=NO;
        covrflowbutton.hidden=NO;
        
    }
    else if ([sender tag]==1001)
    {
        postData=[NSString stringWithFormat:@"/menu/viewDrinksCat/restId/%@/",[menuDefault objectForKey:@"Restaurantid"]];
        CategoryString=@"Drinks";
        [dishesButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [dirnkButton setBackgroundImage:[UIImage imageNamed:@"hot dog.png"] forState:UIControlStateNormal];
        [pizzaButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [setMenuButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [offerButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        [dishesButton setTitleColor:ScrollColor forState:UIControlStateNormal];
        [dirnkButton setTitleColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(0/255.f) alpha:1.0 ] forState: UIControlStateNormal];
        [pizzaButton setTitleColor:ScrollColor forState:UIControlStateNormal];
        [setMenuButton setTitleColor:ScrollColor forState:UIControlStateNormal];
        [offerButton setTitleColor:ScrollColor forState:UIControlStateNormal];
        
        _carousel.hidden=NO;
        covrflowbutton.hidden=NO;
        NSLog(@"drink");
    }
    else if ([sender tag]==1002)
    {
        postData=[NSString stringWithFormat:@"menu/viewPizza/restId/%@/",[menuDefault objectForKey:@"Restaurantid"]];
        CategoryString=@"Pizza";
        [dishesButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [dirnkButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [pizzaButton setBackgroundImage:[UIImage imageNamed:@"hot dog.png"] forState:UIControlStateNormal];
        [setMenuButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [offerButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        [dishesButton setTitleColor:ScrollColor forState:UIControlStateNormal] ;
        [dirnkButton setTitleColor:ScrollColor forState:UIControlStateNormal] ;
        [ pizzaButton setTitleColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(0/255.f) alpha:1.0 ]forState: UIControlStateNormal];
        [setMenuButton setTitleColor:ScrollColor forState:UIControlStateNormal] ;
        [offerButton setTitleColor:ScrollColor forState:UIControlStateNormal] ;
        
        NSLog(@"Pizza");
    }
    else if ([sender tag]==1003)
    {
        postData=[NSString stringWithFormat:@"menu/viewOffers/restId/%@/",[menuDefault objectForKey:@"Restaurantid"]];
        CategoryString=SPATIAL_OFFER;
        [dishesButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [dirnkButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [pizzaButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [setMenuButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [offerButton setBackgroundImage:[UIImage imageNamed:@"hot dog.png"] forState:UIControlStateNormal];
        
        [dishesButton setTitleColor:ScrollColor forState:UIControlStateNormal] ;
        [dirnkButton  setTitleColor:ScrollColor forState:UIControlStateNormal] ;
        [pizzaButton  setTitleColor:ScrollColor forState:UIControlStateNormal];
        [setMenuButton setTitleColor:ScrollColor forState:UIControlStateNormal] ;
        [offerButton  setTitleColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(0/255.f) alpha:1.0 ]forState: UIControlStateNormal];
        
        // NSLog(@"Spacial Offers");
    }
    else if ([sender tag]==1004)
    {
        postData=[NSString stringWithFormat:@"menu/viewSetMenu/restId/%@/",[menuDefault objectForKey:@"Restaurantid"]];
        CategoryString=@"SetMenu";
        [dishesButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [dirnkButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [pizzaButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [setMenuButton setBackgroundImage:[UIImage imageNamed:@"hot dog.png"] forState:UIControlStateNormal];
        [offerButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [dishesButton setTitleColor:ScrollColor forState:UIControlStateNormal] ;
        [dirnkButton setTitleColor:ScrollColor forState:UIControlStateNormal] ;
        [pizzaButton setTitleColor:ScrollColor forState:UIControlStateNormal];
        [setMenuButton setTitleColor:[UIColor colorWithRed:(0/255.f) green:(0/255.f) blue:(0/255.f) alpha:1.0 ]forState: UIControlStateNormal];
        [offerButton setTitleColor:ScrollColor forState:UIControlStateNormal];
        NSLog(@"SetMenu");
    }
    [self gettingSubCategory:postData];
    [self fillsplitArray];
}

#pragma mark......................
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    int count=(int)[subCategoryArray count];
    // [_pageControl setNumberOfPages:count];
    return count;
    
    NSLog(@"%d",count);
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    ///
    
    NSLog(@"%lu",(unsigned long)index);
    
    if (view == nil)
    {
        CGRect rcect= CGRectMake(0, 20, 70.0f, 70.0f);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            rcect= CGRectMake(0, 0,70.0f, 70.0f);
        
        view=[[UIView alloc] initWithFrame:rcect];
        view.backgroundColor=[UIColor clearColor];
        view.backgroundColor=[UIColor clearColor];
        [view.layer setShadowColor:[UIColor blackColor].CGColor];
        view.layer.shadowOpacity = 1.0;
        view.layer.shadowRadius = 5.0;
        view.layer.shadowOffset = CGSizeMake(6, 6);
        UIButton* view1=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [view1 setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [view1 setTitleColor:[UIColor clearColor] forState:UIControlStateSelected];
        view1.frame = rcect;
        [view1 setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)index] forState:UIControlStateNormal];
        //view1.tag=index;
        [view1.layer setCornerRadius:rcect.size.width/2.0];
        [view1.layer setBorderWidth:2];
        [view1.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        [view1.layer setMasksToBounds:YES];
        NSURL *imageurl;
        UIImage *imageFromArray;
        if ([[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:index] objectForKey:@"picture"]] length]>0)
        {
            if ([CategoryString isEqualToString:@"Dishes"])
            {
                imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/category/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:index] objectForKey:@"picture"]]]];
                NSLog(@"%@",imageurl);
                imageFromArray=[UIImage imageWithData:[NSData dataWithContentsOfURL:imageurl]];
                
            }
            else  if ([CategoryString isEqualToString:@"Drinks"])
            {
                imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/drinkcategory/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:index] objectForKey:@"picture"]]]];
                imageFromArray=[UIImage imageWithData:[NSData dataWithContentsOfURL:imageurl]];
                
            }
        }
        
        
        NSLog(@"ikhjkhk%@",imageFromArray);
        
        [(UIButton *)view1  setBackgroundImage:imageFromArray forState:UIControlStateNormal];
        [(UIButton *)view1 setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];
        
        [(UIButton *)view1 addTarget:self action:@selector(setFlowCoverIMageLabel) forControlEvents:UIControlEventTouchUpInside ];
        [view addSubview:view1];
    }
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 0.9f;
    }
    return value;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    const CGFloat centerItemZoom = 1.4;
    const CGFloat centerItemSpacing = 1.1;
    CGFloat spacing = [self carousel:carousel valueForOption:iCarouselOptionSpacing withDefault:0.6f];
    CGFloat absClampedOffset = MIN(1.0, fabs(offset));
    CGFloat clampedOffset = MIN(1.0, MAX(-1.0, offset));
    CGFloat scaleFactor = 1.0 + absClampedOffset * (1.0/centerItemZoom - 1.0);
    
    offset = (scaleFactor * offset + scaleFactor * (centerItemSpacing - 1.0) * clampedOffset) * carousel.itemWidth * spacing;
    
    if (carousel.vertical)
    {
        transform = CATransform3DTranslate(transform, 0.0f, offset, -absClampedOffset);
    }
    else
    {
        transform = CATransform3DTranslate(transform, offset, 0.0f, -absClampedOffset);
    }
    transform = CATransform3DScale(transform, scaleFactor, scaleFactor, 1.0f);
    return transform;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    coverflowIndex=carousel.currentItemIndex;
    [self setFlowCoverIMageLabel];
}

#pragma mark - coverflow digramm
-(void)imageLoadOnView
{
    [_carousel reloadData];
}

-(UIImage *)resizeImage:(UIImage *)image width:(int)width height:(int)height
{
    CGImageRef imageRef = [image CGImage];
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    //if (alphaInfo == kCGImageAlphaNone)
    alphaInfo = kCGImageAlphaNoneSkipLast;
    CGContextRef bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), 4 * width, CGImageGetColorSpace(imageRef), alphaInfo);
    CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;
}
- (void)openFlowView:(AFOpenFlowView *)openFlowView requestImageForIndex:(int)index
{
    //coverflowIndex=index;
}
-(IBAction)clickOnImageOnflow:(id)sender
{
    NSString *postData=nil;
    
    
    if ([CategoryString isEqualToString:@"Dishes"])
    {
        [MyCustomeClass SVProgressMessageShowOnWhenNeed:[NSString stringWithFormat:[MyCustomeClass languageSelectedStringForKey:@"%@Loading..."],centerFlowImageNameLabel.text]];
        postData=[NSString stringWithFormat:@"menu/viewDishesByCat/restId/%@/catId/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"category_id"]]];
    }
    else  if ([CategoryString isEqualToString:@"Drinks"])
    {
        [MyCustomeClass SVProgressMessageShowOnWhenNeed:[NSString stringWithFormat:@"%@Loading...",centerFlowImageNameLabel.text]];
        postData=[NSString stringWithFormat:@"menu/viewDrinksByCat/restId/%@/drinkCatId/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"drink_cat_id"]]];
    }
    else  if ([CategoryString isEqualToString:@"Pizza"])
    {
        return;
        postData=[NSString stringWithFormat:@"menu/viewPizzaTopping/restId/%@/pizza_id_value/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"pizza_id"]]];
    }
    else  if ([CategoryString isEqualToString:@"Spatial office"])
    {
        return;
    }
    else  if ([CategoryString isEqualToString:@"SetMenu"])
    {
        return;
        postData=[NSString stringWithFormat:@"menu/viewSetMenuDish/restId/%@/setMenuId/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"category_id"]]];
    }
    else{
        return;
    }
    NSLog(@"%@",postData);
    
    [self selectedSubCategoryLabelShow];
    [self gettingItemFromSubCategory:postData];
}
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index
{
    coverflowIndex=index;
    [self setFlowCoverIMageLabel];
    NSLog(@"touch image=%d",index);
}
-(void)selectedSubCategoryLabelShow
{
    if (subCategoryArray.count>coverflowIndex)
    {
        if ([CategoryString isEqualToString:@"Dishes"])
        {
            selectedItemTitleList.text=[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"cname"]];
            
        }
        else  if ([CategoryString isEqualToString:@"Drinks"])
        {
            selectedItemTitleList.text=[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"drink_cat_name"]];
            
        }
        else  if ([CategoryString isEqualToString:@"Pizza"])
        {
            selectedItemTitleList.text=[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"title"]];
        }
        else  if ([CategoryString isEqualToString:@"Spatial office"])
        {
            selectedItemTitleList.text=[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"cname"]];
        }
        else  if ([CategoryString isEqualToString:@"SetMenu"])
        {
            
            selectedItemTitleList.text=[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"offer_name"]];
        }
        
    }
}

-(void)setFlowCoverIMageLabel
{
    if (subCategoryArray.count>coverflowIndex)
    {
        if ([CategoryString isEqualToString:@"Dishes"])
        {
            centerFlowImageNameLabel.text=[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"cname"]];
            
        }
        else  if ([CategoryString isEqualToString:@"Drinks"])
        {
            centerFlowImageNameLabel.text=[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"drink_cat_name"]];
            
        }
        else  if ([CategoryString isEqualToString:@"Pizza"])
        {
            centerFlowImageNameLabel.text=[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"title"]];
        }
        else  if ([CategoryString isEqualToString:SPATIAL_OFFER])
        {
            centerFlowImageNameLabel.text=[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"cname"]];
        }
        else  if ([CategoryString isEqualToString:@"SetMenu"])
        {
            
            centerFlowImageNameLabel.text=[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:coverflowIndex] objectForKey:@"offer_name"]];
        }
    }
}

- (UIImage *)defaultImage
{
    
    return [UIImage imageNamed:@"icon_mail.png"];
}
-(IBAction)clickOnOderList:(id)sender
{
    [self sendSelectedOrder];
}
#pragma mark - Webservics Request method
-(void)sendSelectedOrder
{
    [self currentLocation];
    if(finalArray.count>0)
    {
        
        NSData* data=[NSKeyedArchiver archivedDataWithRootObject:finalArray];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"OrderArray"];
        
        if ([appDelegate.openandPaymentWay isEqualToString:@"Menu" ])
        {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Select your table nr." message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:Open_order ,nil];
            [alertView show];
        }
        else
        {
            if ([[menuDefault objectForKey:@"Email"] length]>2)
            {
                appDelegate.cardOpenFromOrder=@"OutOffRestaurant";
                
                [[NSUserDefaults standardUserDefaults] setValue:@"" forKeyPath:@"WalletOrderArray"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self homeButton];
                
            }
            else
            {
                [appDelegate tabBarHide];
                ViewController *viewController=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
                [self presentViewController:viewController animated:true completion:nil];
            }
        }
    }
    else
    {
        [MyCustomeClass alertMessage:@"Please select" :@"any Item before ordering." :@"OK"];
    }
}

-(void)gettingCategoryListLocal: (NSString *)postString
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Loading..."]];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSLog(@"%@",postString);
    [helper gettingCategoryList:postString];
}

-(void)gettingSubCategory :(NSString *) postString
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Loading..."]];
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    
    if (![appDelegate.openandPaymentWay isEqualToString:@"Menu"])
    {
        postString = [postString stringByAppendingString:@"/onlineStatus/1"];
    }
    
    NSLog(@"%@",postString);
    [helper gettingSumCategoryListFromMenu:postString];
}
-(void)gettingItemFromSubCategory:(NSString *) postString
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    
    NSLog(@"%@",postString);
    if (![appDelegate.openandPaymentWay isEqualToString:@"Menu"])
    {
        postString = [postString stringByAppendingString:@"/onlineStatus/1"];
    }
    
    [helper gettingItemOfSubCategory:postString];
}


//////////////////////// response /////
#pragma mark - Webservics Response classes
-(void)sendingOrder:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCESS"])
    {
        [self orderlistSentByForLoop:[finalArray objectAtIndex:orderListCounter]];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"Please try again" :2.0];
    }
}

-(void)gettingCategoryList:(NSString *) response
{
    [categoryArray removeAllObjects];
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    categoryArray =[dataDic objectForKey:@"categoryInfo"];
    NSLog(@"%@",categoryArray);
    NSString *postData=[NSString stringWithFormat:@"category/viewDishCategory/restId/%@/",[menuDefault objectForKey:@"Restaurantid"]];
    for (int i=0; i<categoryArray.count; i++)
    {
        if ([[[categoryArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"Drinks"])
        {
            if (![[[categoryArray objectAtIndex:0] objectForKey:@"status"] isEqualToString:@"1"])
            {
                dirnkButton.frame=CGRectMake(dishesButton.frame.origin.x, dishesButton.frame.origin.y, 0, dishesButton.frame.size.height);
                dirnkButton.enabled=NO;
                dirnkButton.hidden=YES;
            }
        }
        else if ([[[categoryArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"Pizza"])
        {
            if (![[[categoryArray objectAtIndex:0] objectForKey:@"status"] isEqualToString:@"1"])
            {
                pizzaButton.enabled=NO;
                pizzaButton.hidden=YES;
                pizzaButton.frame=CGRectMake(dishesButton.frame.origin.x, dishesButton.frame.origin.y,0, dishesButton.frame.size.height);
            }
        }
        else if ([[[categoryArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"SO"])
        {
            if (![[[categoryArray objectAtIndex:0] objectForKey:@"status"] isEqualToString:@"1"])
            {
                setMenuButton.enabled=NO;
                setMenuButton.hidden=YES;
                setMenuButton.frame=CGRectMake(dishesButton.frame.origin.x, dishesButton.frame.origin.y, 0, dishesButton.frame.size.height);

            }
        }
        else if ([[[categoryArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"Offer"])
        {
            if (![[[categoryArray objectAtIndex:0] objectForKey:@"status"] isEqualToString:@"1"])
            {
                offerButton.enabled=NO;
                offerButton.hidden=YES;
                offerButton.frame=CGRectMake(dishesButton.frame.origin.x, dishesButton.frame.origin.y, 0, dishesButton.frame.size.height);
            }
        }
        else if ([[[categoryArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"Dishes"])
        {
            if (![[[categoryArray objectAtIndex:0] objectForKey:@"status"] isEqualToString:@"1"])
            {
                dishesButton.enabled=NO;
            }
        }
    }
    
    dishesButton.frame=CGRectMake(dishesButton.frame.origin.x, dishesButton.frame.origin.y, dishesButton.frame.size.width, dishesButton.frame.size.height);
    dirnkButton.frame=CGRectMake(dishesButton.frame.origin.x+dishesButton.frame.size.width, dishesButton.frame.origin.y, dirnkButton.frame.size.width, dishesButton.frame.size.height);
    pizzaButton.frame=CGRectMake(dirnkButton.frame.origin.x+dirnkButton.frame.size.width, dishesButton.frame.origin.y, pizzaButton.frame.size.width, dishesButton.frame.size.height);
    offerButton.frame=CGRectMake(pizzaButton.frame.origin.x+pizzaButton.frame.size.width, dishesButton.frame.origin.y, offerButton.frame.size.width, dishesButton.frame.size.height);
    setMenuButton.frame=CGRectMake(offerButton.frame.origin.x+offerButton.frame.size.width, dishesButton.frame.origin.y, setMenuButton.frame.size.width, dishesButton.frame.size.height);
    
    NSLog(@"%f",dishesButton.frame.size.width+dirnkButton.frame.size.width+pizzaButton.frame.size.width+offerButton.frame.size.width+setMenuButton.frame.size.width+10);
    float scrollingContent=dishesButton.frame.size.width+dirnkButton.frame.size.width+pizzaButton.frame.size.width+offerButton.frame.size.width+setMenuButton.frame.size.width+10;
    tabScrollView.contentSize = CGSizeMake(scrollingContent, 29);
    
    
    [self gettingSubCategory:postData];
}

-(void)gettingSumCategoryListFromMenu:(NSString *) response
{
    [subCategoryArray removeAllObjects];
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    NSString *postData=nil;
    if ([CategoryString isEqualToString:@"Dishes"])
    {
        if([[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"dishCategoryInfo"]] length]>3)
        {
            subCategoryArray=[dataDic objectForKey:@"dishCategoryInfo"];
            [self dishdrinkpizzaisNotShow:NO];
        }
        else
        {
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"No Drinks." ]:1.00];
            [itemFromSubCategory removeAllObjects];
        }
        
    }
    else  if ([CategoryString isEqualToString:@"Drinks"])
    {
        if([[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"drinkCatInfo"]] length]>3)
        {
            selectedItemTitleList.text=@"Soft Drinks";
            subCategoryArray=[dataDic objectForKey:@"drinkCatInfo"];
            [self dishdrinkpizzaisNotShow:NO];
        }
        else
        {
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"No Drinks." ]:1.00];
            [itemFromSubCategory removeAllObjects];
        }
        [menuTable reloadData];
    }
    else  if ([CategoryString isEqualToString:@"Pizza"])
    {
        selectedItemTitleList.text=@"Soft Drinks";
        [itemFromSubCategory removeAllObjects];
        [subCategoryArray removeAllObjects];
        NSArray *fullDataArray=[dataDic objectForKey:@"pizzaInfo"];
        for (int kk=0; kk<fullDataArray.count; kk++)
        {
            if ([[NSString stringWithFormat:@"%@",[[fullDataArray objectAtIndex:kk] valueForKey:@"status"]] isEqualToString:@"1"])
            {
                [itemFromSubCategory addObject:[fullDataArray objectAtIndex:kk]];
            }
        }
        [self dishdrinkpizzaisNotShow:NO];
        selectedItemLabel.hidden=NO;
        selectedItemTitleList.hidden=YES;
        TotalPriceList.hidden=NO;
        coverflowView.hidden=YES;
        centerFlowImageNameLabel.hidden=YES;
        [menuTable reloadData];
        [collectionView reloadData];
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Successfully done" ]:1.00];
    }
    else  if ([CategoryString isEqualToString:SPATIAL_OFFER])
    {
        selectedItemTitleList.text=@"Soft Drinks";
        [itemFromSubCategory removeAllObjects];
        [subCategoryArray removeAllObjects];
        
        NSArray *fullDataArray=[dataDic objectForKey:@"offerInfo"];
        for (int kk=0; kk<fullDataArray.count; kk++)
        {
            if ([[NSString stringWithFormat:@"%@",[[fullDataArray objectAtIndex:kk] valueForKey:@"status"]] isEqualToString:@"1"])
            {
                [itemFromSubCategory addObject:[fullDataArray objectAtIndex:kk]];
            }
        }
        [self dishdrinkpizzaisNotShow:NO];
        selectedItemLabel.hidden=NO;
        TotalPriceList.hidden=NO;
        coverflowView.hidden=YES;
        centerFlowImageNameLabel.hidden=YES;
        selectedItemTitleList.hidden=YES;
        [menuTable reloadData];
        [collectionView reloadData];
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Successfully done" ]:1.00];
    }
    else  if ([CategoryString isEqualToString:@"SetMenu"])
    {
        [itemFromSubCategory removeAllObjects];
        selectedItemTitleList.text=@"Soft Drinks";
        [subCategoryArray removeAllObjects];
        subCategoryArray=[dataDic objectForKey:@"setMenuInfo"];

        if (subCategoryArray.count<=0)
        {
            [MyCustomeClass SVProgressMessageDismissWithError:@"No Data." :1.0];
            selectedItemTitleList.hidden=YES;
            coverflowView.hidden=YES;
            centerFlowImageNameLabel.hidden=YES;
            selectedItemTitleList.hidden=YES;
            [menuTable reloadData];
            [collectionView reloadData];
            return;
        }
        NSArray *fullDataArray=[dataDic objectForKey:@"setMenuInfo"];
        for (int kk=0; kk<fullDataArray.count; kk++)
        {
            if ([[NSString stringWithFormat:@"%@",[[fullDataArray objectAtIndex:kk] valueForKey:@"status"]] isEqualToString:@"1"])
            {
                [itemFromSubCategory addObject:[fullDataArray objectAtIndex:kk]];
            }
        }
        
        postData=[NSString stringWithFormat:@"menu/viewSetMenuDetails/restId/%@/setMenuId/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[subCategoryArray objectAtIndex:0] objectForKey:@"offer_id"]]];
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"some issue in setmenu sub category" ]:1.00];
        [self dishdrinkpizzaisNotShow:NO];
        selectedItemTitleList.hidden=YES;
        coverflowView.hidden=YES;
        centerFlowImageNameLabel.hidden=YES;
        selectedItemTitleList.hidden=YES;
        [menuTable reloadData];
        [collectionView reloadData];
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Successfully done" ]:1.00];
        
    }
    NSLog(@"%@",postData);
    [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Successfully done." ]:1.00];
    [menuTable reloadData];
    [collectionView reloadData];

}

-(void)dishdrinkpizzaisNotShow :(BOOL)setYes
{
    centerFlowImageNameLabel.hidden=setYes;
    selectedItemLabel.hidden=setYes;
    TotalPriceList.hidden=setYes;
    coverflowView.hidden=setYes;
    selectedItemTitleList.hidden=setYes;
}

-(void)gettingItemOfSubCategory:(NSString *)response
{
    NSLog(@"%@",response);
    [itemFromSubCategory removeAllObjects];
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"dishInfo"] count]>0)
    {   NSArray *fullDataArray=[dataDic objectForKey:@"dishInfo"];
        for (int kk=0; kk<fullDataArray.count; kk++)
        {
            if ([[NSString stringWithFormat:@"%@",[[fullDataArray objectAtIndex:kk] valueForKey:@"status"]] isEqualToString:@"1"])
            {
                [itemFromSubCategory addObject:[fullDataArray objectAtIndex:kk]];
            }
        }
    }
    else if ([[dataDic objectForKey:@"drinkInfo"] count]>0)
    {
        NSArray *fullDataArray=[dataDic objectForKey:@"drinkInfo"];
        for (int kk=0; kk<fullDataArray.count; kk++)
        {
            if ([[NSString stringWithFormat:@"%@",[[fullDataArray objectAtIndex:kk] valueForKey:@"online"]] isEqualToString:@"1"])
            {
                [itemFromSubCategory addObject:[fullDataArray objectAtIndex:kk]];
            }
        }
    }
    else if ([[dataDic objectForKey:@"dishInfo"] count]>0)
    {
        // itemFromSubCategory=[dataDic objectForKey:@"dishCategoryInfo"];
    }
    else if ([[dataDic objectForKey:@"Spaciel Offer"] count]>0)
    {
        NSArray *fullDataArray=[dataDic objectForKey:@"dishCategoryInfo"];
        for (int kk=0; kk<fullDataArray.count; kk++)
        {
            if ([[NSString stringWithFormat:@"%@",[[fullDataArray objectAtIndex:kk] valueForKey:@"status"]] isEqualToString:@"1"])
            {
                [itemFromSubCategory addObject:[fullDataArray objectAtIndex:kk]];
            }
        }
        // itemFromSubCategory=[dataDic objectForKey:@"dishCategoryInfo"];
    }
    else if ([[dataDic objectForKey:@"setMenuInfo"] count]>0)
    {
        //itemFromSubCategory=[dataDic objectForKey:@"dishCategoryInfo"];
        NSArray *fullDataArray=[dataDic objectForKey:@"dishCategoryInfo"];
        for (int kk=0; kk<fullDataArray.count; kk++)
        {
            if ([[NSString stringWithFormat:@"%@",[[fullDataArray objectAtIndex:kk] valueForKey:@"status"]] isEqualToString:@"1"])
            {
                [itemFromSubCategory addObject:[fullDataArray objectAtIndex:kk]];
            }
        }
    }
    
    NSLog(@"%@",itemFromSubCategory);
    [menuTable reloadData];
    [collectionView reloadData];
    //[MyCustomeClass SVProgressMessageDismissWithSuccess:@"" :0.0];
    [self reloadTableByTimer];
}
-(void)reloadTableByTimer
{
   // NSIndexPath *path =[NSIndexPath indexPathForItem:0 inSection:sectionIndex];
    //[menuTable scrollToRowAtIndexPath:path atScrollPosition:UITableViewRowAnimationTop animated:YES];
    
    CGRect cellRect = [menuTable rectForSection:sectionIndex];
    CGPoint origin=[menuTable convertPoint:cellRect.origin fromView: menuTable];
    [menuTable setContentOffset:CGPointMake(0, origin.y+5)];
    
    [menuTable reloadData];
    [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@""] :1.00];
}


-(void)gettingFail:(NSString*)error
{
    NSLog(@"%@",error);
    [MyCustomeClass SVProgressMessageDismissWithSuccess:error :1.00];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==orderListTable)
        return 1;
    else if (tableView==pizzaTable)
        return 1;
    else if (tableView == modiferTable)
        return 1;
    else
    {
        if (subCategoryArray.count>0)
        {
            return subCategoryArray.count;
        }
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==orderListTable)
    {
        return [finalArray count];
    }
    else if(tableView == modiferTable)
    {
        if (forceModifier.count>0)
        {
            return forceModifier.count;
        }
        else
        {
            return optionModifier.count;
        }
    }
    else if(tableView == pizzaTable)
    {
        if (pizzaSizeArray.count>0)
        {
            return pizzaSizeArray.count;
        }
        else if (pizzaToppingArray.count>0)
        {
            return pizzaToppingArray.count;
        }
        else
        {
            return pizzaBaseArray.count;
        }
    }
    else
    {
        return itemFromSubCategory.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (tableView==orderListTable)
        {
            return 80;
        }
        else if(tableView == modiferTable)
        {
            return 44;
        }
        else if(tableView == pizzaTable)
        {
            return 44;
        }
        else
        {
            if ([CategoryString isEqualToString:@"Dishes"] || [CategoryString isEqualToString:@"Drinks"])
            {
                if ([[arrayForBool objectAtIndex:indexPath.section] boolValue])
                {
                    return 94;
                }
                else
                {
                    return 0;
                }
            }
        }
    
    return 94;
}

#pragma mark - gesture tapped
- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    
    if (indexPath.row == 0)
    {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        
        collapsed       = !collapsed;
        
        for (int i=0; i<arrayForBool.count; i++)
        {
            [arrayForBool replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
        }
        [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        sectionIndex = indexPath.section;
        
        //reload specific section animated
        NSRange range   = NSMakeRange(indexPath.section, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        [menuTable reloadData];
        [menuTable reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
        
        if (collapsed)
        {
            coverflowIndex=indexPath.section;
            [self clickOnImageOnflow:self];
        }
        else
        {
            [itemFromSubCategory removeAllObjects];
        }
    }
    [menuTable reloadData];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == modiferTable || tableView == orderListTable || tableView == pizzaTable)
    {
        return 0;
    }
    else
    {
        if ([CategoryString isEqualToString:@"Dishes"] || [CategoryString isEqualToString:@"Drinks"])
        {
            if(subCategoryArray.count>0)
                return 50;
        }
        return 0;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(subCategoryArray.count
       >0)
    {
        if(tableView == modiferTable || tableView == orderListTable || tableView == pizzaTable)
        {
            return nil;
        }
        UIView *headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        headerView.tag                  = section;
        
        headerView.backgroundColor      = [UIColor whiteColor];
        UILabel *headerString           = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20-50, 50)];
        
        BOOL manyCells = [[arrayForBool objectAtIndex:section] boolValue];
        
        if ([CategoryString isEqualToString:@"Dishes"])
        {
            headerString.text =[[subCategoryArray objectAtIndex:section] objectForKey:@"cname"];
        }
        else if ([CategoryString isEqualToString:@"Drinks"])
        {
            headerString.text =[[subCategoryArray objectAtIndex:section] objectForKey:@"drink_cat_name"];
        }
        
        headerString.textAlignment      =  NSTextAlignmentLeft;
        headerString.textColor          = [UIColor blackColor];
        [headerView addSubview:headerString];
        [headerView setBackgroundColor:[UIColor colorWithRed:192/255.0 green:212.0/255.0 blue:57.0/255.0 alpha:1.0]];
        
        UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
        [headerView addGestureRecognizer:headerTapped];
        
        //up or down arrow depending on the bool
        UIImageView *upDownArrow        = [[UIImageView alloc] initWithImage:manyCells ? [UIImage imageNamed:@"upArrowBlack"] : [UIImage imageNamed:@"downArrowBlack"]];
        upDownArrow.backgroundColor =[UIColor colorWithRed:192/255.0 green:212.0/255.0 blue:57.0/255.0 alpha:1.0];
        upDownArrow.autoresizingMask    = UIViewAutoresizingFlexibleLeftMargin;
        upDownArrow.frame               = CGRectMake(self.view.frame.size.width-40, 10, 30, 30);
        
        [headerView addSubview:upDownArrow];
        
        //up or down arrow depending on the bool
        UIImageView *borderImage        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_bg.png"]];
        borderImage.frame = CGRectMake(0 ,49,self.view.frame.size.width , 1);
        [headerView addSubview:borderImage];
        return headerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==orderListTable)
    {
        static NSString *cellIdentifire = @"OrderListCell";
        orderListCell =(OrderListCell *)[orderListTable dequeueReusableCellWithIdentifier:cellIdentifire];
        if (orderListCell==nil)
        {
            NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"OrderListCell" owner:self options:nil];
            orderListCell = [cellArray objectAtIndex:0];
        }
        
        orderListCell.selectionStyle = UITableViewCellSelectionStyleNone;
        int count = [[[finalArray objectAtIndex:indexPath.row] objectForKey:@"count" ] intValue]*[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"happyHourGet" ] intValue];
        
        if (count<=0)
            count = [[[finalArray objectAtIndex:indexPath.row] objectForKey:@"count" ] intValue];
        
        if(indexPath.row< [finalArray count])
        {
            NSString *totalTaxString=@"";
            float vatTax=0.0;
            float otherTax=0.0;
            float serviceTax=0.0;
            float local_Tax=0.0;
            float forceModiPrice = 0.0;
            float optionModiPrice = 0.0;
            float priceCalucaltion =0.0;
            float displayCount =0.0;
            
            if(taxArray.count>0)
            {
                priceCalucaltion = [[[finalArray objectAtIndex:indexPath.row] objectForKey:@"price"] floatValue];
                
                // modifier calculation
                NSArray *fmLocalArray=[[finalArray objectAtIndex:indexPath.row] objectForKey:@"ForceModifier"];
                
                for(int k=0; k<fmLocalArray.count;k++)
                {
                    forceModiPrice=forceModiPrice+[[[fmLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
                }
                NSArray *omLocalArray=[[finalArray objectAtIndex:indexPath.row] objectForKey:@"OptionModifier"];
                
                for(int k=0; k<omLocalArray.count;k++)
                {
                    optionModiPrice=optionModiPrice+[[[omLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
                }
                
                priceCalucaltion = priceCalucaltion + forceModiPrice+optionModiPrice;
                
                
                if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"is_servicetax" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"is_servicetax" ]] isEqualToString:@"0"])
                {
                    vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                }
                if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"is_othertax" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"is_othertax" ]] isEqualToString:@"0"])
                {
                    otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                }
                if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]] isEqualToString:@"0"])
                {
                    serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                }
                if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"is_localtax" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"is_localtax" ]] isEqualToString:@"0"])
                {
                    local_Tax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                }
            }
            priceCalucaltion = priceCalucaltion + vatTax + otherTax + serviceTax;
            
            displayCount = displayCount +count*[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"happyHourGet" ] intValue];
            if ([[[finalArray objectAtIndex:indexPath.row] objectForKey:@"happyHourGet"] intValue]<=0)
            {
                displayCount = displayCount +count;
            }
            
            priceCalucaltion = priceCalucaltion - count*[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"happyHourAmount" ] floatValue];
            priceCalucaltion = priceCalucaltion - (priceCalucaltion * [[[finalArray objectAtIndex:indexPath.row] objectForKey:@"happyHourDiscount" ] floatValue]/100);
            
            totalTaxString=[NSString stringWithFormat:@"%.2f",priceCalucaltion];
            orderListCell.priceLabel.text=[NSString stringWithFormat:@"%@",totalTaxString];

            
            orderListCell.itemLabel.text=[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
            
            int count = [[[finalArray objectAtIndex:indexPath.row] objectForKey:@"count" ] intValue]*[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"happyHourGet" ] intValue];
            
            if (count<=0)
                count = [[[finalArray objectAtIndex:indexPath.row] objectForKey:@"count" ] intValue];
            
            orderListCell.counterLabel.text=[NSString stringWithFormat:@"%d",count];
            
            orderListCell.itemImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"thumb" ]]];
            
            /*NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/menu/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
            if([[[finalArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"Setmenu"])
            {
                imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/offers/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                
            }
            if([[[finalArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:SPATIAL_OFFER])
            {
                imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/specialoffers/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                
            }*/
            
            NSMutableArray *finalFMArray=[[finalArray objectAtIndex:indexPath.row] objectForKey:@"ForceModifier"];
            NSString *finalFMString=@"";
            for (int i=0; i<finalFMArray.count; i++)
            {
                finalFMString=[NSString stringWithFormat:@"%@,%@",finalFMString,[[finalFMArray objectAtIndex:i] objectForKey:@"fm_item_name"]];
            }
            
            orderListCell.forceModifierLabel.text=[NSString stringWithFormat:@"FM: %@",finalFMString];
            
            if([[[finalArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"Pizza"])
            {
               // imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/pizza/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                
                orderListCell.optionModifierLabel.hidden=YES;
                orderListCell.forceModifierLabel.text=[NSString stringWithFormat:@"SIZE:%@ TOPPING:%@ BASE:%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"size"],[[finalArray objectAtIndex:indexPath.row] objectForKey:@"pizza_topping"],[[finalArray objectAtIndex:indexPath.row] objectForKey:@"pizza_base"]];
            }
            
            NSMutableArray *finalOMArray=[[finalArray objectAtIndex:indexPath.row] objectForKey:@"OptionModifier"];
            NSString *finalOMString=@"";
            for (int i=0; i<finalOMArray.count; i++)
            {
                finalOMString=[NSString stringWithFormat:@"%@,%@",finalOMString,[[finalOMArray objectAtIndex:i] objectForKey:@"om_item_name"]];
            }
            
            orderListCell.optionModifierLabel.text=[NSString stringWithFormat:@"OM: %@",finalOMString];
           // [orderListCell.itemImage setImageWithURL:imageurl];
            
            
            [orderListCell.crossButton addTarget:self action:@selector(clickOnCellCrrossButton:) forControlEvents:UIControlEventTouchUpInside];
            [orderListCell.orderPlusButton addTarget:self action:@selector(clickOnOrderPlusButton:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        // orderListCell.itemLabel.font=[UIFont fontWithName:FONT size:15.0];
        // orderListCell.priceLabel.font=[UIFont fontWithName:FONT size:15.0];
        // orderListCell.counterLabel.font=[UIFont fontWithName:FONT size:15.0];
        // orderListCell.forceModifierLabel.font=[UIFont fontWithName:FONT size:11.0];
        // orderListCell.optionModifierLabel.font=[UIFont fontWithName:FONT size:11.0];
        orderListCell.itemLabel.font=[UIFont fontWithName:FONT_Ragular size:13.0];
        [orderListCell.itemLabel setFont: [orderListCell.itemLabel.font fontWithSize: 13.0]];

        orderListCell.counterLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
        [orderListCell.counterLabel setFont: [orderListCell.counterLabel.font fontWithSize: 12.0]];
        
        orderListCell.forceModifierLabel.font=[UIFont fontWithName:FONT_Ragular size:08.0];
        [orderListCell.forceModifierLabel setFont: [orderListCell.forceModifierLabel.font fontWithSize: 08.0]];

        orderListCell.optionModifierLabel.font=[UIFont fontWithName:FONT_Ragular size:08.0];
        [orderListCell.optionModifierLabel setFont: [orderListCell.optionModifierLabel.font fontWithSize: 08.0]];

        
        [MyCustomeClass roundedImageView:orderListCell.itemImage];
        return orderListCell;
    }
    else if(tableView == pizzaTable)
    {
        if ([pizzaString isEqualToString:@"Topping"])
        {
            static NSString *cellIdentifire = @"OptionModifierCell";
            omodifierCell =(OptionModifierCell *)[pizzaTable dequeueReusableCellWithIdentifier:cellIdentifire];
            if (omodifierCell==nil)
            {
                NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"OptionModifierCell" owner:self options:nil];
                omodifierCell = [cellArray objectAtIndex:0];
            }
            if (pizzaToppingArray.count>0)
            {
                omodifierCell.nameLabel.text=[[pizzaToppingArray objectAtIndex:indexPath.row] objectForKey:@"name"];
                omodifierCell.priceLabel.text=[[pizzaToppingArray objectAtIndex:indexPath.row] objectForKey:@"price"];
                if(selecetePizzaOption.count>0)
                {
                    for (int i=0; i<selecetePizzaOption.count; i++)
                    {
                        if ([[[pizzaToppingArray objectAtIndex:indexPath.row] objectForKey:@"pizza_topping_id"] isEqualToString:[[selecetePizzaOption objectAtIndex:i] objectForKey:@"pizza_topping_id"]])
                        {
                            [omodifierCell.chackBoxbutton setBackgroundImage:[UIImage imageNamed:@"optional modifier selected box.png"] forState:UIControlStateNormal];
                            i=5000;
                        }
                        else
                        {
                            [omodifierCell.chackBoxbutton setBackgroundImage:[UIImage imageNamed:@"optional modifier empty box.png"] forState:UIControlStateNormal];
                        }
                    }
                }
                
                [omodifierCell.chackBoxbutton addTarget:self action:@selector(clickOnOptionModiferRadioButton:) forControlEvents:UIControlEventTouchUpInside];
                omodifierCell.contentView.backgroundColor=[UIColor clearColor];
            }
            
           omodifierCell.nameLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
            [omodifierCell.nameLabel setFont: [omodifierCell.nameLabel.font fontWithSize: 12.0]];

            omodifierCell.priceLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
            [omodifierCell.priceLabel setFont: [omodifierCell.priceLabel.font fontWithSize: 12.0]];

            return omodifierCell;
        }
        else
        {
            static NSString *cellIdentifire = @"PizzaSize";
            fmodifierCell =(FocreModifierCell *)[pizzaTable dequeueReusableCellWithIdentifier:cellIdentifire];
            if (fmodifierCell==nil)
            {
                NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"FocreModifierCell" owner:self options:nil];
                fmodifierCell = [cellArray objectAtIndex:0];
            }
            [fmodifierCell.radiobutton setBackgroundImage:[UIImage imageNamed:@"NewRadioOff.png"] forState:UIControlStateNormal];
            
            if ([pizzaString isEqualToString:@"Size"])
            {
                if (pizzaSizeArray.count>0)
                {
                    fmodifierCell.nameLabel.text=[[pizzaSizeArray objectAtIndex:indexPath.row] objectForKey:@"size"];
                    fmodifierCell.priceLabel.text=[[pizzaSizeArray objectAtIndex:indexPath.row] objectForKey:@"price"];
                    if(selecetePizzaOption.count>0)
                    {
                        if ([[[pizzaSizeArray objectAtIndex:indexPath.row] objectForKey:@"pizza_size_id"] isEqualToString:[[selecetePizzaOption objectAtIndex:0] objectForKey:@"pizza_size_id"]])
                        {
                            [fmodifierCell.radiobutton setBackgroundImage:[UIImage imageNamed:@"NewRadioOn.png"] forState:UIControlStateNormal];
                        }
                    }
                    [fmodifierCell.radiobutton addTarget:self action:@selector(clickOnForceModiferRadioButton:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
            else if([pizzaString isEqualToString:@"Base"])
            {
                if (pizzaBaseArray.count>0)
                {
                    fmodifierCell.nameLabel.text=[[pizzaBaseArray objectAtIndex:indexPath.row] objectForKey:@"name"];
                    fmodifierCell.priceLabel.text=[[pizzaBaseArray objectAtIndex:indexPath.row] objectForKey:@"price"];
                    if(selecetePizzaOption.count>0)
                    {
                        if ([[[pizzaBaseArray objectAtIndex:indexPath.row] objectForKey:@"pizza_base_id"] isEqualToString:[[selecetePizzaOption objectAtIndex:0] objectForKey:@"pizza_base_id"]])
                        {
                            [fmodifierCell.radiobutton setBackgroundImage:[UIImage imageNamed:@"NewRadioOn.png"] forState:UIControlStateNormal];
                        }
                    }
                }
                [fmodifierCell.radiobutton addTarget:self action:@selector(clickOnForceModiferRadioButton:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            //[fmodifierCell.radiobutton addTarget:self action:@selector(clickOnForceModiferRadioButton:) forControlEvents:UIControlEventTouchUpInside];
            
            fmodifierCell.contentView.backgroundColor=[UIColor clearColor];
            fmodifierCell.nameLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
            [fmodifierCell.nameLabel setFont: [fmodifierCell.nameLabel.font fontWithSize: 12.0]];

            
            fmodifierCell.priceLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
            [fmodifierCell.priceLabel setFont: [fmodifierCell.priceLabel.font fontWithSize: 12.0]];

            return fmodifierCell;
        }
    }
    else if(tableView == modiferTable)
    {
        if([modifierTitle.text isEqualToString:@"VALGMULIGHEDER"])
        {
            static NSString *cellIdentifire = @"FocreModifierCell";
            fmodifierCell =(FocreModifierCell *)[orderListTable dequeueReusableCellWithIdentifier:cellIdentifire];
            if (fmodifierCell==nil)
            {
                NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"FocreModifierCell" owner:self options:nil];
                fmodifierCell = [cellArray objectAtIndex:0];
            }
            if (forceModifier.count>0)
            {
                fmodifierCell.nameLabel.text=[[forceModifier objectAtIndex:indexPath.row] objectForKey:@"fm_item_name"];
                fmodifierCell.priceLabel.text=[[forceModifier objectAtIndex:indexPath.row] objectForKey:@"price"];
                /*if([modifierSelectedItemsArray containsObject:[forceModifier objectAtIndex:indexPath.row]])
                 {
                 fmodifierCell.accessoryType = UITableViewCellAccessoryCheckmark;
                 }
                 else
                 {
                 fmodifierCell.accessoryType = UITableViewCellAccessoryNone;
                 }*/
                [fmodifierCell.radiobutton addTarget:self action:@selector(clickOnForceModiferRadioButton:) forControlEvents:UIControlEventTouchUpInside];
                // fmodifierCell.nameLabel.font=[UIFont fontWithName:FONT size:15.0];
                // fmodifierCell.priceLabel.font=[UIFont fontWithName:FONT size:15.0];
            }
            
            [fmodifierCell.radiobutton setBackgroundImage:[UIImage imageNamed:@"NewRadioOff.png"] forState:UIControlStateNormal];
            if (selectedFModifierList.count>0)
            {
                for (int i=0; i<selectedFModifierList.count; i++)
                {
                    if ([[[forceModifier objectAtIndex:indexPath.row] objectForKey:@"fm_cat_id"] isEqualToString:[[selectedFModifierList objectAtIndex:i] objectForKey:@"fm_cat_id"] ])
                    {
                        if ([[[forceModifier objectAtIndex:indexPath.row] objectForKey:@"fm_item_id"] isEqualToString:[[selectedFModifierList objectAtIndex:i] objectForKey:@"fm_item_id"] ])
                        {
                            [fmodifierCell.radiobutton setBackgroundImage:[UIImage imageNamed:@"NewRadioOn.png"] forState:UIControlStateNormal];
                            i=5000;
                        }
                        else
                        {
                            //[fmodifierCell.radiobutton setBackgroundImage:[UIImage imageNamed:@"radio_off.png"] forState:UIControlStateNormal];
                        }
                    }
                }
            }
            
            //fmodifierCell.priceLabel.font=[UIFont fontWithName:FONT size:15.0];
            //fmodifierCell.nameLabel.font=[UIFont fontWithName:FONT size:15.0];
            fmodifierCell.contentView.backgroundColor=[UIColor clearColor];
            return fmodifierCell;
        }
        else
        {
            static NSString *cellIdentifire = @"OptionModifierCell";
            omodifierCell =(OptionModifierCell *)[orderListTable dequeueReusableCellWithIdentifier:cellIdentifire];
            if (omodifierCell==nil)
            {
                NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"OptionModifierCell" owner:self options:nil];
                omodifierCell = [cellArray objectAtIndex:0];
            }
            omodifierCell.nameLabel.text=[[optionModifier objectAtIndex:indexPath.row] objectForKey:@"om_item_name"];
            omodifierCell.priceLabel.text=[[optionModifier objectAtIndex:indexPath.row] objectForKey:@"price"];
            if(selectedOModifierList.count>0)
            {
                for (int i=0; i<selectedOModifierList.count; i++)
                {
                    if ([[[optionModifier objectAtIndex:indexPath.row] objectForKey:@"om_item_id"] isEqualToString:[[selectedOModifierList objectAtIndex:i] objectForKey:@"om_item_id"]])
                    {
                        [omodifierCell.chackBoxbutton setBackgroundImage:[UIImage imageNamed:@"optional modifier selected box.png"] forState:UIControlStateNormal];
                        i=5000;
                    }
                    else
                    {
                        [omodifierCell.chackBoxbutton setBackgroundImage:[UIImage imageNamed:@"optional modifier empty box.png"] forState:UIControlStateNormal];
                    }
                }
            }
            [omodifierCell.chackBoxbutton addTarget:self action:@selector(clickOnOptionModiferRadioButton:) forControlEvents:UIControlEventTouchUpInside];
            omodifierCell.contentView.backgroundColor=[UIColor clearColor];
            // omodifierCell.nameLabel.font=[UIFont fontWithName:FONT size:15.0];
            //omodifierCell.priceLabel.font=[UIFont fontWithName:FONT size:15.0];
            return omodifierCell;
        }
    }
    else
    {
        static NSString *CellIdentifier=@"MenuViewCell";
        menuCell = (MenuViewCell *)[menuTable dequeueReusableCellWithIdentifier:CellIdentifier];
        if (menuCell == nil)
        {
            NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"MenuViewCell" owner:self options:nil];
            
            menuCell = [cellArray objectAtIndex:0];
        }
        menuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([itemFromSubCategory count]>indexPath.row)
        {
            if ([CategoryString isEqualToString:@"Dishes"])
            {
                menuCell.itemNameLabel.text=nil;
                menuCell.itemNameLabel.text=[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"pname" ]];
                
                NSString *totalTaxString=@"";
                float vatTax=0.0;
                float otherTax=0.0;
                float serviceTax=0.0;
                float local_Tax=0.0;
                float priceCalucaltion =0.0;
                
                if(taxArray.count>0)
                {
                    priceCalucaltion = [[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"price"] floatValue];
                    
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_servicetax" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_servicetax" ]] isEqualToString:@"0"])
                    {
                        vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_othertax" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_othertax" ]] isEqualToString:@"0"])
                    {
                        otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]] isEqualToString:@"0"])
                    {
                        serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_localtax" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_localtax" ]] isEqualToString:@"0"])
                    {
                        local_Tax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                    }
                }
                priceCalucaltion = priceCalucaltion + vatTax + otherTax + serviceTax;
                
                totalTaxString=[NSString stringWithFormat:@"%.2f",priceCalucaltion];
                menuCell.itemPriceLabel.text=[NSString stringWithFormat:@"%@",totalTaxString];

                
                NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/menu/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                NSLog(@"%@",imageurl);
                [menuCell.itemImage setImageWithURL:imageurl];
                
            }
            else if ([CategoryString isEqualToString:@"Drinks"])
            {
                menuCell.itemNameLabel.text=nil;
                menuCell.itemNameLabel.text=[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"drink_name" ]];
                NSString *totalTaxString=@"";
                float vatTax=0.0;
                float otherTax=0.0;
                float serviceTax=0.0;
                float local_Tax=0.0;
                float priceCalucaltion =0.0;
                
                if(taxArray.count>0)
                {
                    priceCalucaltion = [[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"drink_price"] floatValue];
                    
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_servicetax" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_servicetax" ]] isEqualToString:@"0"])
                    {
                        vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"drink_price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_othertax" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_othertax" ]] isEqualToString:@"0"])
                    {
                        otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"drink_price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]] isEqualToString:@"0"])
                    {
                        serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"drink_price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_localtax" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_localtax" ]] isEqualToString:@"0"])
                    {
                        local_Tax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"drink_price" ] floatValue]];
                    }
                }
                priceCalucaltion = priceCalucaltion + vatTax + otherTax + serviceTax;
                
                totalTaxString=[NSString stringWithFormat:@"%.2f",priceCalucaltion];
                menuCell.itemPriceLabel.text=[NSString stringWithFormat:@"%@",totalTaxString];

                NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/drinks/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"drink_image"]]]];
                NSLog(@"%@",imageurl);
                [menuCell.itemImage setImageWithURL:imageurl];
            }
            else if ([CategoryString isEqualToString:@"Pizza"])
            {
                menuCell.itemNameLabel.text=nil;
                menuCell.itemNameLabel.text=[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"title" ]];
                
                menuCell.itemPriceLabel.text=@"";
                if ([[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]] length]==6)
                {
                    NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/pizza/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                    NSLog(@"%@",imageurl);
                    [menuCell.itemImage setImageWithURL:imageurl];
                }
                else
                {
                    NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/pizza/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                    NSLog(@"%@",imageurl);
                    [menuCell.itemImage setImageWithURL:imageurl];
                }
                
                //menuCell.plusButton.frame=CGRectMake(menuCell.plusButton.frame.origin.x,menuCell.plusButton.frame.origin.y-25, menuCell.plusButton.frame.size.width, menuCell.plusButton.frame.size.height);
                menuCell.priceBackground.hidden=YES;
            }
            else if ([CategoryString isEqualToString:SPATIAL_OFFER])
            {
                menuCell.itemNameLabel.text=[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"offer_name" ]];
                
                NSString *totalTaxString=@"";
                float vatTax=0.0;
                float otherTax=0.0;
                float serviceTax=0.0;
                float local_Tax=0.0;
                float priceCalucaltion =0.0;
                
                if(taxArray.count>0)
                {
                    priceCalucaltion = [[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"offer_price"] floatValue];
                    
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_servicetax" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_servicetax" ]] isEqualToString:@"0"])
                    {
                        vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"offer_price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_othertax" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_othertax" ]] isEqualToString:@"0"])
                    {
                        otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"offer_price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]] isEqualToString:@"0"])
                    {
                        serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"offer_price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_localtax" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_localtax" ]] isEqualToString:@"0"])
                    {
                        local_Tax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"offer_price" ] floatValue]];
                    }
                }
                priceCalucaltion = priceCalucaltion + vatTax + otherTax + serviceTax;
                
                totalTaxString=[NSString stringWithFormat:@"%.2f",priceCalucaltion];
                menuCell.itemPriceLabel.text=[NSString stringWithFormat:@"%@",totalTaxString];
                
                if ([[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]] length]==6)
                {
                   // NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/specialoffers/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                   // NSLog(@"%@",imageurl);
                   // [menuCell.itemImage setImageWithURL:imageurl];
                }
                else
                {
                    NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/specialoffers/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                    NSLog(@"%@",imageurl);
                    [menuCell.itemImage setImageWithURL:imageurl];
                }
            }
            else if ([CategoryString isEqualToString:@"SetMenu"])
            {
                menuCell.itemNameLabel.text=nil;

                menuCell.itemNameLabel.text=[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"offer_name" ]];
                
                NSString *totalTaxString=@"";
                float vatTax=0.0;
                float otherTax=0.0;
                float serviceTax=0.0;
                float local_Tax=0.0;
                float priceCalucaltion =0.0;
                
                if(taxArray.count>0)
                {
                    priceCalucaltion = [[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"price"] floatValue];
                    
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_servicetax" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_servicetax" ]] isEqualToString:@"0"])
                    {
                        vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_othertax" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_othertax" ]] isEqualToString:@"0"])
                    {
                        otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]] isEqualToString:@"0"])
                    {
                        serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_localtax" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"is_localtax" ]] isEqualToString:@"0"])
                    {
                        local_Tax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax"] floatValue] price:[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                    }
                }
                
                priceCalucaltion = priceCalucaltion + vatTax + otherTax + serviceTax;
                
                totalTaxString=[NSString stringWithFormat:@"%.2f",priceCalucaltion];
                menuCell.itemPriceLabel.text=[NSString stringWithFormat:@"%@",totalTaxString];

                // NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/offers/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"picture"]]]];
               // NSLog(@"%@",imageurl);
                
               // [menuCell.itemImage setImageWithURL:imageurl];
            }
            
            [menuCell.plusButton addTarget:self action:@selector(clickOnCellPlusButton: event:) forControlEvents:UIControlEventTouchUpInside];
            
        menuCell.descripLavel.text=nil;
        menuCell.descripLavel.text=[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"description"];
        [MyCustomeClass roundedImageView:menuCell.itemImage];
        
        // menuCell.itemNameLabel.font=[UIFont fontWithName:FONT size:20.0];
        // menuCell.itemPriceLabel.font=[UIFont fontWithName:FONT size:15.0];
        }
        return menuCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==modiferTable)
    {
        // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}


-(IBAction)clickOnCellPlusButton:(id)sender event:(id)event
{
    /* NSSet *touches = [event allTouches];
     UITouch *touch = [touches anyObject];
     CGPoint currentTouchPosition = [touch locationInView:menuTable];
     NSIndexPath *clickedButtonPath = [menuTable indexPathForCell: menuCell];
     selectedCellIntegerValue=(int)clickedButtonPath.row;*/
    
    if (IS_IOS8)
    {
        menuCell = (MenuViewCell *)[[sender superview] superview] ;
    }
    else
    {
        menuCell = (MenuViewCell *)[[[sender superview] superview] superview] ;
    }
    NSIndexPath *clickedButtonPath = [menuTable indexPathForCell:menuCell];
    selectedCellIntegerValue=(int)clickedButtonPath.row;
    [self happyHourRequest:[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"happy_hours_id"]];
    
    if ([appDelegate.openandPaymentWay isEqualToString:@"Menu" ])
    {
        [self currentLocation];
        if (distance<200)
        {
            /*if ([wifiName isEqualToString:@"bundle"])*/
            {
                // [self orderWithDefaultAddrss];
                
            }
            /*else
             {
             [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"You need to connect with restaurnt wifi for sending open order." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
             }*/
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"You are not in restaurant for sending open order." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            return;
        }
    }
    if ([CategoryString isEqualToString:@"SetMenu"])
    {
        NSString *setMenuName=[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"offer_name" ]];
        UIAlertView *alrtView=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"confirem  %@",setMenuName] message:@"" delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"NO"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:[MyCustomeClass languageSelectedStringForKey:@"YES"]], nil];
        [alrtView show];
    }
    else if ([CategoryString isEqualToString:@"Pizza"])
    {
        [self pizzaSizeRequest:[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"pizza_id"]];
    }
    else
    {
        forceModifierPrice=0;
        optionModifierPrice=0;
        if ([[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"forced_modifer_id"] intValue]>0 && [[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"optional_modifer_id"] intValue]>0)
        {
            if ([[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"forced_modifer_id"] intValue]>0)
            {
                [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
                WebServiceHelper *web=[[WebServiceHelper alloc] init];
                web.delegate=self;
                NSString *urlString=[NSString stringWithFormat:@"menu/viewFm/restId/%@/fmCatId/%@",ciboRestaurantId,[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"forced_modifer_id"]];
                [web getForceModifier:urlString];
            }
        }
        else
        {
            if ([[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"forced_modifer_id"] intValue]>0)
            {
                [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
                WebServiceHelper *web=[[WebServiceHelper alloc] init];
                web.delegate=self;
                NSString *urlString=[NSString stringWithFormat:@"menu/viewFm/restId/%@/fmCatId/%@",ciboRestaurantId,[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"forced_modifer_id"]];
                [web getForceModifier:urlString];
            }
            else if ([[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"optional_modifer_id"] intValue]>0)
            {
                [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
                
                WebServiceHelper *web=[[WebServiceHelper alloc] init];
                web.delegate=self;
                NSString *urlString=[NSString stringWithFormat:@"menu/viewOm/restId/%@/omCatId/%@",ciboRestaurantId,[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"optional_modifer_id"]];
                [web getOptionModifier:urlString];
            }
            else
            {
                UIAlertView *alrtView=[[UIAlertView alloc] initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"Do you want to add in order list"] message:@"Confirmation" delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"NO"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"YES"], nil];
                [alrtView show];
            }
        }
    }
}

-(void)addTotalOnView
{
    ///////////////////////////////
    float finalPrice=0.0;
    int displayCount=0;
    for (int i=0; i<[finalArray count]; i++)
    {
        float singlePrice=0;
        float vatTax=0.0;
        float otherTax=0.0;
        float serviceTax=0.0;
        float localTax=0.0;
        forceModifierPrice=0.0;
        optionModifierPrice=0.0;
        
        singlePrice = [[[finalArray objectAtIndex:i] objectForKey:@"price" ] floatValue];
        int count =[[[finalArray objectAtIndex:i] objectForKey:@"count" ] intValue];
        
        if (taxArray.count>0)
        {
            // modifier calculation
            NSArray *fmLocalArray=[[finalArray objectAtIndex:i] objectForKey:@"ForceModifier"];
            for(int k=0; k<fmLocalArray.count;k++)
            {
                forceModifierPrice=forceModifierPrice+[[[fmLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
            }
            NSArray *omLocalArray=[[finalArray objectAtIndex:i] objectForKey:@"OptionModifier"];
            
            for(int k=0; k<omLocalArray.count;k++)
            {
                optionModifierPrice=optionModifierPrice+[[[omLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
            }
            
            singlePrice =singlePrice + forceModifierPrice+optionModifierPrice;
            
            // service tax...
            if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:i] objectForKey:@"is_servicetax" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:i] objectForKey:@"is_servicetax" ]] isEqualToString:@"0"])
            {
                serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax" ] floatValue] price:singlePrice];
            }
            
            // singlePrice=singlePrice+serviceTax;
            
            // all tax ....
            if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:i] objectForKey:@"is_vat" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:i] objectForKey:@"is_vat" ]] isEqualToString:@"0"])
            {
                vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat" ] floatValue] price:singlePrice];
            }
            if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:i] objectForKey:@"is_othertax" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:i] objectForKey:@"is_othertax" ]] isEqualToString:@"0"])
            {
                otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax" ] floatValue] price:singlePrice];
            }
            if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:i] objectForKey:@"is_localtax" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:i] objectForKey:@"is_localtax" ]] isEqualToString:@"0"])
            {
                localTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax" ] floatValue] price:singlePrice];
            }
        }
        
        singlePrice= singlePrice + vatTax+otherTax+localTax + serviceTax;
        finalPrice= finalPrice+singlePrice;
        
        displayCount = displayCount +count*[[[finalArray objectAtIndex:i] objectForKey:@"happyHourGet" ] intValue];
        if ([[[finalArray objectAtIndex:i] objectForKey:@"happyHourGet"] intValue]<=0)
        {
            displayCount = displayCount +count;
        }
        
        finalPrice = finalPrice - count*[[[finalArray objectAtIndex:i] objectForKey:@"happyHourAmount" ] floatValue];
        finalPrice = finalPrice - (finalPrice * [[[finalArray objectAtIndex:i] objectForKey:@"happyHourDiscount" ] floatValue]/100);

    }
    
    selectedItemLabel.text=[NSString stringWithFormat:@"Item:%d",displayCount];
    TotalPriceList.text=[NSString stringWithFormat:@"%.2f",finalPrice];
    subTotal.text=[NSString stringWithFormat:@"%.2f",finalPrice];
    float tenPersent=0.0;
    servicesChargeLabel.text=[NSString stringWithFormat:@"%.2f",tenPersent];
    servicesChargeLabel.hidden=YES;
    serviceschargeLabelLabel.hidden=YES;
    totelLable.text=[NSString stringWithFormat:@"%.2f",(tenPersent+finalPrice)];
    
    [[NSUserDefaults standardUserDefaults] setFloat:(tenPersent+finalPrice) forKey:@"FinalPrice"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (finalArray.count<=0)
    {
        [self addRedBadge:NO];
    }
    else
    {
        [self addRedBadge:YES];
    }
    [self addRedBadge:NO];
    pizzaString=nil;
    NSData* data=[NSKeyedArchiver archivedDataWithRootObject:finalArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"OrderArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (finalArray.count<=0)
    {
        [self addRedBadge:NO];
    }
    else
    {
        [self addRedBadge:YES];
    }
    [forceModifier removeAllObjects];
    [optionModifier removeAllObjects];
    [selectedOModifierList removeAllObjects];
    [selectedFModifierList removeAllObjects];
    [choosedPizzaDetail removeAllObjects];
    pizzaString=nil;
    [orderListTable reloadData];
}


-(IBAction)clickOnOrderPlusButton:(id)sender
{
    if (IS_IOS8)
    {
        orderListCell = (OrderListCell *)[[sender superview] superview];
    }
    else
    {
        orderListCell = (OrderListCell *)[[[sender superview] superview] superview];
    }
    NSIndexPath *clickedButtonPath = [orderListTable indexPathForCell:orderListCell];
    NSMutableDictionary *countDic =[[NSMutableDictionary alloc] init];
    countDic =[finalArray objectAtIndex:clickedButtonPath.row];
    int count=[[countDic valueForKey:@"count"] intValue];
    float price =[[countDic valueForKey:@"price"] floatValue];
    price=price/count;
    count++;
    price=price*count;
    [countDic setValue:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
    [countDic setValue:[NSString stringWithFormat:@"%f",price] forKey:@"price"];
    
    [finalArray removeObjectAtIndex:clickedButtonPath.row];
    [finalArray insertObject:countDic atIndex:clickedButtonPath.row];
    [self addTotalOnView];
}

-(IBAction)clickOnCellCrrossButton:(id)sender
{
    if (IS_IOS8)
    {
        orderListCell = (OrderListCell *)[[sender superview] superview];
    }
    else
    {
        orderListCell = (OrderListCell *)[[[sender superview] superview] superview];
    }
    NSIndexPath *clickedButtonPath = [orderListTable indexPathForCell:orderListCell];
    NSMutableDictionary *countDic =[[NSMutableDictionary alloc] init];
    countDic =[finalArray objectAtIndex:clickedButtonPath.row];
    int count=[[countDic valueForKey:@"count"] intValue];
    float price =[[countDic valueForKey:@"price"] floatValue];
    price=price/count;
    count--;
    price=price*count;
    [countDic setValue:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
    [countDic setValue:[NSString stringWithFormat:@"%f",price] forKey:@"price"];
    
    [finalArray removeObjectAtIndex:clickedButtonPath.row];
    if (count!=0)
    {
        [finalArray insertObject:countDic atIndex:clickedButtonPath.row];
    }
    if(finalArray.count<=0)
    {
        [finalArray removeAllObjects];
        [selectedOrderArray removeAllObjects];
        orderListShowAndHide=true;
        orderListView.hidden=YES;
        pizzaString=nil;
        [self addRedBadge:NO];
        [self dishdrinkpizzaisNotShow:NO];
        selectedItemLabel.text=[NSString stringWithFormat:@"Items:0"];
        itemCountLabel.text=@"0";
        TotalPriceList.text=[NSString stringWithFormat:@"0"];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKeyPath:@"OrderArray"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    [self addTotalOnView];
}


-(float)addTaxWithDish:(float )tax price:(float) price
{
    float price1=(price*tax)/100;
    return price1;
}

#pragma mark - alertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"YES"]])
    {
        /*if ([CategoryString isEqualToString:@"SetMenu"])
         {
         //[MyCustomeClass alertMessage:@"Menu is set" :@"you can use it." :@"Countinue"];
         }
         else*/
        {
            //int priceInInteger=0;
            //  NSLog(@"%@",itemFromSubCategory);
            if ([CategoryString isEqualToString:@"Dishes"])
            {
                [selectedOrderArray1 removeAllObjects];
                [selectedOrderArray1 addObject:[itemFromSubCategory objectAtIndex:selectedCellIntegerValue]];
                [selectedOrderArray1 addObject:[selectedFModifierList copy]];
                [selectedOrderArray1 addObject:[selectedOModifierList copy]];
                [selectedOrderArray  addObject:[selectedOrderArray1 copy]];
                
                
            }
            else  if ([CategoryString isEqualToString:@"Drinks"])
            {
                [selectedOrderArray2 removeAllObjects];
                
                
                [selectedOrderArray2 addObject:[itemFromSubCategory objectAtIndex:selectedCellIntegerValue]];
                [selectedOrderArray2 addObject:[selectedFModifierList copy]];
                [selectedOrderArray2 addObject:[selectedOModifierList copy]];
                [selectedOrderArray  addObject:[selectedOrderArray2 copy]];
            }
            else  if ([CategoryString isEqualToString:@"Pizza"])
            {
                [selectedOrderArray3 removeAllObjects];
                
                [selectedOrderArray3 addObject:[itemFromSubCategory objectAtIndex:selectedCellIntegerValue]];
                [selectedOrderArray3 addObject:[choosedPizzaDetail copy]];
                [selectedOrderArray3 addObject:[selectedOModifierList copy]];
                [selectedOrderArray  addObject:[selectedOrderArray3 copy]];
            }
            else  if ([CategoryString isEqualToString:SPATIAL_OFFER])
            {
                [selectedOrderArray4 removeAllObjects];
                
                [selectedOrderArray4 addObject:[itemFromSubCategory objectAtIndex:selectedCellIntegerValue]];
                [selectedOrderArray4 addObject:[selectedFModifierList copy]];
                [selectedOrderArray4 addObject:[selectedOModifierList copy]];
                [selectedOrderArray  addObject:[selectedOrderArray4 copy]];
            }
            else  if ([CategoryString isEqualToString:@"SetMenu"])
            {
                [selectedOrderArray5 removeAllObjects];
                
                [selectedOrderArray5 addObject:[itemFromSubCategory objectAtIndex:selectedCellIntegerValue]];
                [selectedOrderArray5 addObject:[selectedFModifierList copy]];
                [selectedOrderArray5 addObject:[selectedOModifierList copy]];
                [selectedOrderArray  addObject:[selectedOrderArray5 copy]];
            }
            //////////////////////////
            NSArray *cleanedArray = [[NSSet setWithArray:selectedOrderArray ] allObjects];
            NSMutableArray *semiFinalArray=[[NSMutableArray alloc] init];

            for (int i=0; i<cleanedArray.count; i++)
            {
                int counter=0;
                float priceInInteger=0;
                for (int j=0;j<selectedOrderArray.count; j++)
                {
                    if (![[NSString stringWithFormat:@"%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"pname"]]  isEqualToString:@"(null)"])
                    {
                        NSArray *fmArray1=[[NSSet setWithArray:[[selectedOrderArray objectAtIndex:j] objectAtIndex:1]] allObjects];
                        NSArray *fmArray2=[[NSSet setWithArray:[[cleanedArray objectAtIndex:i] objectAtIndex:1]] allObjects];
                        NSArray *omArray1=[[NSSet setWithArray:[[selectedOrderArray objectAtIndex:j] objectAtIndex:2]] allObjects];
                        NSArray *omArray2=[[NSSet setWithArray:[[cleanedArray objectAtIndex:i] objectAtIndex:2]] allObjects];
                        
                        if ([[NSString stringWithFormat:@"%@/%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0]objectForKey:@"product_id"],[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"price"]]isEqualToString:[NSString stringWithFormat:@"%@/%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"product_id"],[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"price"]]] && [fmArray1 isEqualToArray:fmArray2] && [omArray1 isEqualToArray: omArray2])
                        {
                            counter++;
                            float singlePrice=0;
                            NSString *priceListLocl=[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"price"];
                            singlePrice=[priceListLocl intValue];
                            priceInInteger=priceInInteger+singlePrice;
                        }
                        
                    }
                    else if (![[NSString stringWithFormat:@"%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"drink_name"]] isEqualToString:@"(null)"])
                        
                    {
                        NSArray *fmArray1=[[NSSet setWithArray:[[selectedOrderArray objectAtIndex:j] objectAtIndex:1]] allObjects];
                        NSArray *fmArray2=[[NSSet setWithArray:[[cleanedArray objectAtIndex:i] objectAtIndex:1]] allObjects];
                        NSArray *omArray1=[[NSSet setWithArray:[[selectedOrderArray objectAtIndex:j] objectAtIndex:2]] allObjects];
                        NSArray *omArray2=[[NSSet setWithArray:[[cleanedArray objectAtIndex:i] objectAtIndex:2]] allObjects];
                        
                        if ([[NSString stringWithFormat:@"%@/%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"drink_id"],[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"points"]]isEqualToString:[NSString stringWithFormat:@"%@/%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"drink_id"],[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0]objectForKey:@"points"]]] && [fmArray1 isEqualToArray:fmArray2] && [omArray1 isEqualToArray: omArray2])
                        {
                            counter++;
                            float singlePrice=0;
                            NSString *priceListLocl=[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"drink_price"];
                            singlePrice=[priceListLocl intValue];
                            priceInInteger=priceInInteger+singlePrice;
                            // NSLog(@"%d",priceInInteger);
                        }
                    }
                    else if (![[NSString stringWithFormat:@"%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0]objectForKey:@"title"]]isEqualToString:@"(null)"])
                        
                    {
                        NSArray *chooseOption1=[[NSSet setWithArray:[[selectedOrderArray objectAtIndex:j] objectAtIndex:1]] allObjects];
                        NSArray *chooseOption2=[[NSSet setWithArray:[[cleanedArray objectAtIndex:i] objectAtIndex:1]] allObjects];
                        
                        if ([[NSString stringWithFormat:@"%@/%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"pizza_id"],[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"drink_id"]]isEqualToString:[NSString stringWithFormat:@"%@/%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"pizza_id"],[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"drink_id"]]] && [chooseOption1 isEqualToArray: chooseOption2])
                        {
                            counter++;
                            float singlePrice=0;
                            if (choosedPizzaDetail.count>0)
                            {
                                for (int kk=0; kk<choosedPizzaDetail.count; kk++)
                                {
                                    // if (kk+1+i<choosedPizzaDetail.count)
                                    {
                                        //breaker++;
                                        singlePrice = singlePrice+[[[choosedPizzaDetail objectAtIndex:kk] objectForKey:@"price"] floatValue];
                                        //if (breaker==2)
                                        {
                                            // kk=5000;
                                        }
                                    }
                                }
                                priceInInteger=priceInInteger+singlePrice;
                            }
                            
                        }
                    }
                    else if (![[NSString stringWithFormat:@"%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0]objectForKey:@"price"]] isEqualToString:@"(null)"]  )
                    {
                        NSArray *fmArray1=[[NSSet setWithArray:[[selectedOrderArray objectAtIndex:j] objectAtIndex:1]] allObjects];
                        NSArray *fmArray2=[[NSSet setWithArray:[[cleanedArray objectAtIndex:i] objectAtIndex:1]] allObjects];
                        NSArray *omArray1=[[NSSet setWithArray:[[selectedOrderArray objectAtIndex:j] objectAtIndex:2]] allObjects];
                        NSArray *omArray2=[[NSSet setWithArray:[[cleanedArray objectAtIndex:i] objectAtIndex:2]] allObjects];
                        if ([[NSString stringWithFormat:@"%@/%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"offer_id"],[[[cleanedArray objectAtIndex:i]  objectAtIndex:0] objectForKey:@"category_id"]]isEqualToString:[NSString stringWithFormat:@"%@/%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"offer_id"],[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"category_id"]]] && [fmArray1 isEqualToArray:fmArray2] && [omArray1 isEqualToArray: omArray2])
                        {
                            counter++;
                            float singlePrice=0;
                            NSString *priceListLocl=[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"price"];
                            singlePrice=[priceListLocl floatValue];
                            priceInInteger=priceInInteger+singlePrice;
                        }
                    }
                    else if (![[NSString stringWithFormat:@"%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0]objectForKey:@"offer_price"]] isEqualToString:@"(null)"])
                    {
                        NSArray *fmArray1=[[NSSet setWithArray:[[selectedOrderArray objectAtIndex:j] objectAtIndex:1]] allObjects];
                        NSArray *fmArray2=[[NSSet setWithArray:[[cleanedArray objectAtIndex:i] objectAtIndex:1]] allObjects];
                        NSArray *omArray1=[[NSSet setWithArray:[[selectedOrderArray objectAtIndex:j] objectAtIndex:2]] allObjects];
                        NSArray *omArray2=[[NSSet setWithArray:[[cleanedArray objectAtIndex:i] objectAtIndex:2]] allObjects];
                        if ([[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"id"]]isEqualToString:[NSString stringWithFormat:@"%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"id"]]] && [fmArray1 isEqualToArray:fmArray2] && [omArray1 isEqualToArray: omArray2])
                        {
                            counter++;
                            float singlePrice=0;
                            NSString *priceListLocl=[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"price"];
                            singlePrice=[priceListLocl intValue];
                            priceInInteger=priceInInteger+singlePrice;
                            NSLog(@"%f",priceInInteger);
                        }
                    }
                }
                NSMutableDictionary *orderDic=[[NSMutableDictionary alloc] init];
                [orderDic setValue:[NSString stringWithFormat:@"%d",counter] forKey:@"count"];
                NSLog(@"%d",i);
                for (int j=0;j<selectedOrderArray.count; j++)
                {
                    if (![[NSString stringWithFormat:@"%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0]objectForKey:@"pname"]]  isEqualToString:@"(null)"])
                    {
                        if ([[NSString stringWithFormat:@"%@/%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"drink_id"],[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"price"]]isEqualToString:[NSString stringWithFormat:@"%@/%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"drink_id"],[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"price"]]])
                        {
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"pname"]] forKey:@"name"];
                            [orderDic setValue:[NSString stringWithFormat:@"%.2f",priceInInteger] forKey:@"price"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"product_id"]] forKey:@"id"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"thumb"]] forKey:@"thumb"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_vat"]] forKey:@"is_vat"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_localtax"]] forKey:@"is_localtax"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_othertax"]] forKey:@"is_othertax"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_servicetax"]] forKey:@"is_servicetax"];
                            [orderDic setValue:[[[cleanedArray objectAtIndex:i ] objectAtIndex:1] copy] forKey:@"ForceModifier"];
                            [orderDic setValue:[[[cleanedArray objectAtIndex:i ] objectAtIndex:2] copy] forKey:@"OptionModifier"];
                            [orderDic setValue:@"Dishes" forKey:@"type"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"points"]] forKey:@"points"];
                            
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"happy_hours_id"]] forKey:@"happy_hours_id"];
                            //
                            //// null info points
                            [orderDic setValue:@"0" forKey:@"pizza_topping_id"];
                            [orderDic setValue:@"0" forKey:@"pizza_topping"];
                            [orderDic setValue:@"0" forKey:@"pizza_base"];//
                            [orderDic setValue:@"0" forKey:@"pizza_base_id"];//
                            [orderDic setValue:@"0" forKey:@"size"];
                            [orderDic setValue:@"0" forKey:@"pizza_size_id"];
                            [semiFinalArray addObject:orderDic];
                            j=5000;
                        }
                    }
                    else if (![[NSString stringWithFormat:@"%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"drink_name"]] isEqualToString:@"(null)"])
                    {
                        
                        if ([[NSString stringWithFormat:@"%@/%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"drink_id"],[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"points"]]isEqualToString:[NSString stringWithFormat:@"%@/%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"drink_id"],[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"points"]]])
                        {
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"drink_name"]] forKey:@"name"];
                            [orderDic setValue:[NSString stringWithFormat:@"%.2f",priceInInteger] forKey:@"price"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"drink_id"]] forKey:@"id"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"thumb"]] forKey:@"thumb"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_vat"]] forKey:@"is_vat"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_localtax"]] forKey:@"is_localtax"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_othertax"]] forKey:@"is_othertax"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_servicetax"]] forKey:@"is_servicetax"];
                            [orderDic setValue:[[[cleanedArray objectAtIndex:i] objectAtIndex:1] copy] forKey:@"ForceModifier"];
                            [orderDic setValue:[[[cleanedArray objectAtIndex:i] objectAtIndex:2] copy] forKey:@"OptionModifier"];
                            [orderDic setValue:@"Drinks" forKey:@"type"];
                            
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"points"]] forKey:@"points"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"happy_hours_id"]] forKey:@"happy_hours_id"];
                            //// null info
                            [orderDic setValue:@"0" forKey:@"pizza_topping_id"];
                            [orderDic setValue:@"0" forKey:@"pizza_topping"];
                            [orderDic setValue:@"0" forKey:@"pizza_base"];//
                            [orderDic setValue:@"0" forKey:@"pizza_base_id"];//
                            [orderDic setValue:@"0" forKey:@"size"];
                            [orderDic setValue:@"0" forKey:@"pizza_size_id"];
                            
                            [semiFinalArray addObject:orderDic];
                            j=5000;
                        }
                    }
                    else if (![[NSString stringWithFormat:@"%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"title"]]isEqualToString:@"(null)"])
                    {
                        if ([[NSString stringWithFormat:@"%@/%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"pizza_id"],[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"drink_id"]]isEqualToString:[NSString stringWithFormat:@"%@/%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"pizza_id"],[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"drink_id"]]])
                        {
                            NSMutableArray *pizzaOptionArray=[[NSMutableArray alloc] init];
                            pizzaOptionArray= [[cleanedArray objectAtIndex:i] objectAtIndex:1];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"title"]] forKey:@"name"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"pizza_id"]] forKey:@"id"];
                            
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[pizzaOptionArray objectAtIndex:1] objectForKey:@"pizza_size_id"]] forKey:@"pizza_size_id"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"points"]] forKey:@"points"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"happy_hours_id"]] forKey:@"happy_hours_id"];
                            
                            NSString *toppingId=@"";
                            NSString *toppingName=@"";
                            NSString *baseName=@"";
                            for (int toppingCount=0; toppingCount<pizzaOptionArray.count; toppingCount++)
                            {
                                NSString *toppingCal=[NSString stringWithFormat:@"%@",[[pizzaOptionArray objectAtIndex:toppingCount] objectForKey:@"pizza_topping_id"]];
                                NSString *baseName1=[NSString stringWithFormat:@"%@",[[pizzaOptionArray objectAtIndex:toppingCount] objectForKey:@"pizza_base_id"]];
                                
                                
                                if (toppingCal.length>0 && ![toppingCal isEqualToString:@"(null)"])
                                {
                                    toppingId=[toppingId stringByAppendingString:[NSString stringWithFormat:@",%@",[[pizzaOptionArray objectAtIndex:toppingCount] objectForKey:@"pizza_topping_id"]]];
                                    toppingName=[toppingName stringByAppendingString:[NSString stringWithFormat:@",%@",[[pizzaOptionArray objectAtIndex:toppingCount] objectForKey:@"name"]]];
                                }
                                
                                if (baseName1.length>0 && ![baseName1 isEqualToString:@"(null)"])
                                {
                                    baseName=[NSString stringWithFormat:@",%@",[[pizzaOptionArray objectAtIndex:toppingCount] objectForKey:@"name"]];
                                }
                            }
                            if ([toppingId hasPrefix:@","])
                            {
                                toppingId = [toppingId substringFromIndex:1];
                                toppingName=[toppingName substringFromIndex:1];
                            }
                            [orderDic setValue:toppingId forKey:@"pizza_topping_id"];
                            [orderDic setValue:toppingName forKey:@"pizza_topping"];
                            
                            
                            //[[[choosedPizzaDetail objectAtIndex:kk+1] objectForKey:@"price"] floatValue]
                            
                            [orderDic setValue:[NSString stringWithFormat:@"%.2f",priceInInteger] forKey:@"price"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[pizzaOptionArray objectAtIndex:0] objectForKey:@"size"]] forKey:@"size"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"thumb"]] forKey:@"thumb"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_localtax"]] forKey:@"is_localtax"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_othertax"]] forKey:@"is_othertax"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_servicetax"]] forKey:@"is_servicetax"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_vat"]] forKey:@"is_vat"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"pizza_base_id"]] forKey:@"pizza_base_id"];//
                            [orderDic setValue:baseName forKey:@"pizza_base"];//
                            
                            [orderDic setValue:@"Pizza" forKey:@"type"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"happy_hours_id"]] forKey:@"happy_hours_id"];
                            /// null info
                            [orderDic setValue:nil forKey:@"ForceModifier"];
                            [orderDic setValue:nil forKey:@"OptionModifier"];
                            
                            [semiFinalArray addObject:orderDic];
                            j=5000;
                        }
                    }
                    else if (![[NSString stringWithFormat:@"%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"price"]] isEqualToString:@"(null)"])
                    {
                        if ([[NSString stringWithFormat:@"%@/%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"id"],[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"drink_id"]]isEqualToString:[NSString stringWithFormat:@"%@/%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"id"],[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"drink_id"]]])
                        {
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"offer_name"]] forKey:@"name"];
                            [orderDic setValue:[NSString stringWithFormat:@"%.2f",priceInInteger] forKey:@"price"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"offer_id"]] forKey:@"id"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"thumb"]] forKey:@"thumb"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_vat"]] forKey:@"is_vat"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_localtax"]] forKey:@"is_localtax"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_othertax"]] forKey:@"is_othertax"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0]objectForKey:@"is_servicetax"]] forKey:@"is_servicetax"];
                            [orderDic setValue:@"SetMenu" forKey:@"type"];
                            
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"points"]] forKey:@"points"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"happy_hours_id"]] forKey:@"happy_hours_id"];
                            
                            [orderDic setValue:[selectedFModifierList copy] forKey:@"ForceModifier"];
                            // [orderDic setValue:[selectedOModifierList copy] forKey:@"OptionModifier"];
                            // [orderDic setValue:@"Dishes" forKey:@"type"];
                            
                            //// null info
                            [orderDic setValue:@"0" forKey:@"pizza_topping_id"];
                            [orderDic setValue:@"0" forKey:@"pizza_topping"];
                            [orderDic setValue:@"0" forKey:@"pizza_base"];//
                            [orderDic setValue:@"0" forKey:@"pizza_base_id"];//
                            [orderDic setValue:@"0" forKey:@"size"];
                            [orderDic setValue:@"0" forKey:@"pizza_size_id"];
                            [semiFinalArray addObject:orderDic];
                            j=5000;
                        }
                    }
                    else if (![[NSString stringWithFormat:@"%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"offer_price"]] isEqualToString:@"(null)"])
                    {
                        if ([[NSString stringWithFormat:@"%@/%@",[[[cleanedArray objectAtIndex:i]  objectAtIndex:0]objectForKey:@"id"],[[[cleanedArray objectAtIndex:i]  objectAtIndex:0]objectForKey:@"drink_id"]]isEqualToString:[NSString stringWithFormat:@"%@/%@",[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"id"],[[[selectedOrderArray objectAtIndex:j ] objectAtIndex:0] objectForKey:@"drink_id"]]])
                        {
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"offer_name"]] forKey:@"name"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"id"]] forKey:@"id"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"offer_price"]] forKey:@"price"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"thumb"]] forKey:@"thumb"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_vat"]] forKey:@"is_vat"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_localtax"]] forKey:@"is_localtax"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"is_othertax"]] forKey:@"is_othertax"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0]objectForKey:@"is_servicetax"]] forKey:@"is_servicetax"];
                            [orderDic setValue:[[[cleanedArray objectAtIndex:i ] objectAtIndex:1] copy] forKey:@"ForceModifier"];
                            [orderDic setValue:[[[cleanedArray objectAtIndex:i ] objectAtIndex:2] copy] forKey:@"OptionModifier"];
                            [orderDic setValue:@"Offers" forKey:@"type"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"points"]] forKey:@"points"];
                            [orderDic setValue:[NSString stringWithFormat:@"%@",[[[cleanedArray objectAtIndex:i] objectAtIndex:0] objectForKey:@"happy_hours_id"]] forKey:@"happy_hours_id"];
                            
                            //// null infoDi
                            [orderDic setValue:@"0" forKey:@"pizza_topping_id"];
                            [orderDic setValue:@"0" forKey:@"pizza_topping"];
                            [orderDic setValue:@"0" forKey:@"pizza_base"];//
                            [orderDic setValue:@"0" forKey:@"pizza_base_id"];//
                            [orderDic setValue:@"0" forKey:@"size"];
                            [orderDic setValue:@"0" forKey:@"pizza_size_id"];
                            
                            [semiFinalArray addObject:orderDic];
                            j=5000;
                        }
                    }
                }
            }
            
            for (int i=0; i<semiFinalArray.count; i++)
            {
                BOOL isAdded=NO;
                for (int j=0; j<finalArray.count; j++)
                {
                    if ([[[semiFinalArray objectAtIndex:i] objectForKey:@"id"] isEqualToString:[[finalArray objectAtIndex:j] objectForKey:@"id"]])
                    {
                        NSString *string1=[NSString stringWithFormat:@"%@",[[semiFinalArray objectAtIndex:i] objectForKey:@"ForceModifier"]];
                        NSString *string2=[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:j] objectForKey:@"ForceModifier"]];
                        
                        NSString *string3=[NSString stringWithFormat:@"%@",[[semiFinalArray objectAtIndex:i] objectForKey:@"OptionModifier"]];
                        NSString *string4=[NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:j] objectForKey:@"OptionModifier"]];
                        
                        if ([string1 isEqualToString:string2] && [string3 isEqualToString:string4])
                        {
                            isAdded=YES;
                            NSMutableDictionary *tempArray=[[NSMutableDictionary alloc] init];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"id"] forKey:@"id"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"is_localtax"] forKey:@"is_localtax"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"is_othertax"] forKey:@"is_othertax"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"is_servicetax"] forKey:@"is_servicetax"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"is_vat"] forKey:@"is_vat"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"pizza_base"] forKey:@"pizza_base"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"pizza_base_id"] forKey:@"pizza_base_id"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"pizza_size_id"] forKey:@"pizza_size_id"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"pizza_topping"] forKey:@"pizza_topping"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"pizza_topping_id"] forKey:@"pizza_topping_id"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"points"] forKey:@"points"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"price"] forKey:@"price"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"size"] forKey:@"size"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"thumb"] forKey:@"thumb"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"type"] forKey:@"type"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"ForceModifier"] forKey:@"ForceModifier"];
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"OptionModifier"] forKey:@"OptionModifier"];
                            [tempArray setValue:[[finalArray objectAtIndex:j] objectForKey:@"happyHourAmount"] forKey:@"happyHourAmount"];
                            [tempArray setValue:[[finalArray objectAtIndex:j] objectForKey:@"happyHourGet"] forKey:@"happyHourGet"];
                            [tempArray setValue:[[finalArray objectAtIndex:j] objectForKey:@"happyhourPoint"] forKey:@"happyhourPoint"];
                            [tempArray setValue:[[finalArray objectAtIndex:j] objectForKey:@"happyHourDiscount"] forKey:@"happyHourDiscount"];
                            [tempArray setValue:[[finalArray objectAtIndex:j] objectForKey:@"happy_hours_id"] forKey:@"happy_hours_id"];
                            [tempArray setValue:ciboRestaurantId forKey:@"restaurant_id"];
                            
                            [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"count"] forKey:@"count"];
                            [finalArray removeObjectAtIndex:j];
                            [finalArray insertObject:tempArray atIndex:j];
                            j=500000;
                            break;
                        }
                        else
                        {
                            isAdded=NO;
                        }
                    }
                }
                if (isAdded==NO)
                {
                    NSMutableDictionary *tempArray=[[NSMutableDictionary alloc] init];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"id"] forKey:@"id"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"is_localtax"] forKey:@"is_localtax"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"is_othertax"] forKey:@"is_othertax"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"is_servicetax"] forKey:@"is_servicetax"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"is_vat"] forKey:@"is_vat"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"pizza_base"] forKey:@"pizza_base"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"pizza_base_id"] forKey:@"pizza_base_id"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"pizza_size_id"] forKey:@"pizza_size_id"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"pizza_topping"] forKey:@"pizza_topping"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"pizza_topping_id"] forKey:@"pizza_topping_id"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"price"] forKey:@"price"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"size"] forKey:@"size"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"thumb"] forKey:@"thumb"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"type"] forKey:@"type"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"ForceModifier"] forKey:@"ForceModifier"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"OptionModifier"] forKey:@"OptionModifier"];
                    NSString *points = [NSString stringWithFormat:@"%d",[happyhourPoint intValue]+[[[semiFinalArray objectAtIndex:i] objectForKey:@"points"] intValue]];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"count"] forKey:@"count"];
                    [tempArray setValue:points forKey:@"points"];
                    [tempArray setValue:[NSString stringWithFormat:@"%@",happyHourAmount] forKey:@"happyHourAmount"];
                    [tempArray setValue:[NSString stringWithFormat:@"%@",happyHourGet] forKey:@"happyHourGet"];
                    [tempArray setValue:[NSString stringWithFormat:@"%@",happyhourPoint] forKey:@"happyhourPoint"];
                    [tempArray setValue:[NSString stringWithFormat:@"%@",happyHourDiscount] forKey:@"happyHourDiscount"];
                    [tempArray setValue:[[semiFinalArray objectAtIndex:i] objectForKey:@"happy_hours_id"] forKey:@"happy_hours_id"];
                    [tempArray setValue:ciboRestaurantId forKey:@"restaurant_id"];
                    
                    [finalArray addObject:tempArray ];
                }
            }
            
            [self addTotalOnView];
        }
    }
    else if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"NO"]])
    {
        selectedCellIntegerValue=0;
        selectedItem=0;
    }
    else if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"I want"]])
    {
        selectedItemTitleList.text=[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"offer_name" ]];
        selectedItemTitleList.hidden=NO;
    }
    else if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:Open_order]])
    {
        if ([[menuDefault objectForKey:@"Email"] length]>2)
        {
            if(appDelegate.bookedTable.length>0)
            {
                if (distance<200)
                {
                    /*if ([wifiName isEqualToString:@"bundle"])*/
                    {
                        [self orderWithDefaultAddrss];
                    }
                    /*else
                     {
                     [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"You need to connect with restaurnt wifi for sending open order." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                     }*/
                }
                else
                {
                    [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"You are not in restaurant for sending open order." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                }
            }
            else
            {
                 appDelegate.orderSelected=YES;
                 TableReservationViewController *table=[[TableReservationViewController alloc] initWithNibName:@"TableReservationViewController" bundle:nil];
                [self.navigationController pushViewController:table animated:true];
            }
        }
        else
        {
            [appDelegate tabBarHide];
            orderListView.hidden=YES;
            ViewController *viewController=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
            [self presentViewController:viewController animated:true completion:nil];
        }
        
    }
    else if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:OnLine_Order]])
    {
        if ([[menuDefault objectForKey:@"Email"] length]>2)
        {
            [self orderWithDefaultAddrss];
        }
        else
        {
            [appDelegate tabBarHide];
            ViewController *viewController=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
            [self presentViewController:viewController animated:true completion:nil];
        }
    }
    else if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"Yes"]])
    {
        NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"OrderArray"];
        finalArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self addTotalOnView];
    }
    else if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"No"]])
    {
        [finalArray removeAllObjects];
        [self addTotalOnView];
        itemCountLabel.text=[NSString stringWithFormat:@"%d",0];
        orderListView.hidden=YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"OrderArray"];
    }
    if (finalArray.count<=0)
    {
        [self addRedBadge:NO];
    }
    else
    {
        [self addRedBadge:NO];
    }
    [orderListTable reloadData];
}

#pragma mark - send order method list
-(void)languageTextOnObjct
{
    [cancelButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Cancel"] forState:UIControlStateNormal] ;
    [nowOrderButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Now Order"] forState:UIControlStateNormal] ;
    
    orderTitleLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Order Address"];
    [firstNameText setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"First name*:"]];
    [surNameText setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Sur name*:"]];
    //[password setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Password*:"]];
    //[phonenumber setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Phone Number*:"]];
    [mobileText setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Mobile Number*:"]];
    [emailAddressText setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Email*:"]];
    //[dOB setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"DOB*:"]];
    [cityText setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"City*:"]];
    [countryText setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Country*:"]];
    [stateText setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"State*:"]];
    [postCodeText setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Post Code*:"]];
    [addrssNameText setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Address*:"]];
    
}

-(IBAction)KeyboardGone:(id)sender
{
    [firstNameText resignFirstResponder];
    [surNameText resignFirstResponder];
    [addrssNameText resignFirstResponder];
    [emailAddressText resignFirstResponder];
    [cityText resignFirstResponder];
    [countryText resignFirstResponder];
    [stateText resignFirstResponder];
    [postCodeText resignFirstResponder];
    [mobileText resignFirstResponder];
    
    
}
-(void)clearAllField
{
    firstNameText.text=nil;
    surNameText.text=nil;
    addrssNameText.text=nil;
    emailAddressText.text=nil;
    cityText.text=nil;
    countryText.text=nil;
    stateText.text=nil;
    postCodeText.text=nil;
    postCodeText.text=nil;
    mobileText.text=nil;
}

-(IBAction)clickOnCancelButton:(id)sender
{
    orderView.hidden=YES;
    [appDelegate tabBarShow];
}

-(IBAction)clicOnNewOrder:(id)sender
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Order cleaning..."]];
    
    if (firstNameText.text==nil || [firstNameText.text length]<=0)
    {
        [firstNameText becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter first name." ] :1.000];
    }
    else if (surNameText.text==nil || [surNameText.text length]<=0)
    {
        [surNameText becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter sur name." ] :1.000];
    }
    else if (emailAddressText.text==nil || [emailAddressText.text length]<=0)
    {
        [emailAddressText becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter email address." ] :1.000];
    }
    else if (cityText.text==nil || [cityText.text length]<=0)
    {
        [cityText becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter city."] :1.000];
    }
    else if (stateText.text==nil || [stateText.text length]<=0)
    {
        [stateText becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter state." ] :1.000];
    }
    else if (countryText.text==nil || [countryText.text length]<=0)
    {
        [countryText becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter country." ] :1.000];
    }
    else if (mobileText.text==nil || [mobileText.text length]<=0)
    {
        [mobileText becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter mobile number."] :1.000];
    }
    else
    {
        if ([MyCustomeClass validateEmail:emailAddressText.text])
        {
            if ([MyCustomeClass checkInternetConnection])
            {
                [self orderWithNewAddress];
            }
            else
            {
                [MyCustomeClass SVProgressMessageDismissWithError:@"internet not connected with device." :2.000];
            }
        }
        else
        {
            [emailAddressText becomeFirstResponder];
            [MyCustomeClass SVProgressMessageDismissWithError:@"Please valid email address." :2.000];
        }
    }
    
    
}

-(void)orderWithNewAddress
{
    orderListCounter=0;
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];
    long int orderIDInInteger=(int )timeInMiliseconds;
    
    orderId=[NSString stringWithFormat:@"17%@",[NSString stringWithFormat:@"%ld",orderIDInInteger]];
    NSLog(@"%@", [NSString stringWithFormat:@"%@",orderId]);
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"orders/sendOrder/restId/%@/",[menuDefault objectForKey:@"Restaurantid"]];
    NSString *PostData=[NSString stringWithFormat:@"order_id=%@&member_id=%@&firstname=%@&lastname=%@&delivery_email=%@&delivery_address=%@&delivery_city=%@&delivery_state=%@&delivery_time=%@&delivery_country=%@&delivery_zipcode=%@&delivery_phone=%@&delivery_mobile=%@&total=%@&general_discount=%@&promo_discount=%@&delivery_date=%@&comments=%@&time_for_delivery=%@&distance=%d&pay_method=%@&paid=%@&order_status=%@&order_date=%@&order_time=%@&type=%@&points=%@&service_tax=%@&vat=%@&local_tax=%@&other_tax=%@&grand_total=%@&pickup=%@&street=%@&tax=%@&is_online=%@&payment_status=%@&web=%@&table_id=%@&booking_id=%@&restId=%@",orderId,[menuDefault objectForKey:@"Member"],firstNameText.text,surNameText.text,emailAddressText.text,addrssNameText.text,cityText.text,stateText.text,[NSDate date],countryText.text,postCodeText.text,mobileText.text,mobileText.text,TotalPriceList.text,[menuDefault objectForKey:@"discount"],@"0",[NSDate date],@"comments",@"time for delivery",distance,@"0",@"0",@"New",@"order date",@"order time",@"open",[menuDefault objectForKey:@"points"], @"10%",@"00",@"0",@"0",totelLable.text,@"1",@"street",@"tex",@"1",@"1",@"web",appDelegate.tableNumber,appDelegate.bookedTable,ciboRestaurantId];
    NSLog(@"%@",PostData);
    [helper sendingOrder:postString :PostData];
}

-(void)orderWithDefaultAddrss
{
    if (selectedOrderArray.count==0)
    {
        NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"OrderArray"];
        selectedOrderArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    [self priceCalulation];
    orderListCounter=0;
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];
    long int orderIDInInteger=(int )timeInMiliseconds;
    
    orderId=[NSString stringWithFormat:@"25%@",[NSString stringWithFormat:@"%ld",orderIDInInteger]];
    NSLog(@"%@", [NSString stringWithFormat:@"%@",orderId]);
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Order cleaning..."]];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"orders/sendOrder/restId/%@/",[menuDefault objectForKey:@"Restaurantid"]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"HH:mm:ss"];
    NSString *time = [formatter1 stringFromDate:[NSDate date]];
    
    
    NSString *PostData=[NSString stringWithFormat:@"order_id=%@&member_id=%@&firstname=%@&lastname=%@&email=%@&street=%@&delivery_city=%@&delivery_state=%@&delivery_time=%@&delivery_country=%@&delivery_zipcode=%@&phone=%@&mobile=%@&total=%@&general_discount=%@&promo_discount=%@&delivery_date=%@&comments=%@&time_for_delivery=%@&distance=%d&payment_method=%d&paid=%@&order_status=%@&order_date=%@&order_time=%@&type=%@&points=%@&service_tax=%@&vat=%@&local_tax=%@&other_tax=%@&grand_total=%@&pickup=%@&street=%@&tax=%.2f&is_online=%@&payment_status=%@&web=%@&table_id=%@&booking_id=%@&restId=%@&order_location=mdm",orderId,[menuDefault objectForKey:@"Member"],[menuDefault objectForKey:@"firstname"],[menuDefault objectForKey:@"lastname"],[menuDefault objectForKey:@"Email"],[menuDefault objectForKey:@"address"],[menuDefault objectForKey:@"city"],[menuDefault objectForKey:@"state"],time,[menuDefault objectForKey:@"country"],[menuDefault objectForKey:@"zipcode"],[menuDefault objectForKey:@"Phone"],[menuDefault objectForKey:@"mobile"],subTotal111,[menuDefault objectForKey:@"discount"],@"0",date,@"comments",time,distance,0,@"0",@"New",date,time,@"open",@"1",@"10",@"00",@"0",@"0",grandTotal,@"1",@"street",[grandTotal floatValue]-[subTotal111 floatValue],@"0",@"1",@"web",appDelegate.tableNumber,appDelegate.bookedTable,ciboRestaurantId];
    
    NSLog(@"%@",PostData);
    [helper sendingOrder:postString :PostData];
    
}

-(void)orderlistSentByForLoop:(NSMutableDictionary *)orderDictionary
{
    NSArray *fmLocalArray=[orderDictionary objectForKey:@"ForceModifier"];
    NSString *fmID=@"";
    NSString *omID=@"";
    
    for(int k=0; k<fmLocalArray.count;k++)
    {
        fmID=[fmID stringByAppendingString:[NSString stringWithFormat:@",%@",[[fmLocalArray objectAtIndex:k] objectForKey:@"fm_item_id"]]];
        
    }
    if ([fmID hasPrefix:@","])
    {
        fmID = [fmID substringFromIndex:1];
    }
    NSArray *omLocalArray=[orderDictionary objectForKey:@"OptionModifier"];
    for(int k=0; k<omLocalArray.count;k++)
    {
        omID=[omID stringByAppendingString:[NSString stringWithFormat:@",%@",[[omLocalArray objectAtIndex:k]objectForKey:@"om_item_id"]]];
    }
    if ([omID hasPrefix:@","])
    {
        omID = [omID substringFromIndex:1];
    }
    float vatTax=0.0;
    float otherTax=0.0;
    float serviceTax=0.0,singlePrice=0.0;
    
    float localTax=0.0;
    if(taxArray.count>0)
    {
        {
            vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat" ] floatValue] price:[[orderDictionary objectForKey:@"price" ] floatValue]];
        }
        {
            otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax" ] floatValue] price:[[orderDictionary objectForKey:@"price" ] floatValue]];
        }
        {
            serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax" ] floatValue] price:[[orderDictionary objectForKey:@"price" ] floatValue]];
        }
        {
            localTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax" ] floatValue] price:[[orderDictionary objectForKey:@"price" ] floatValue]];
        }
        
    }
    
    
    singlePrice=vatTax+otherTax+serviceTax+localTax;
    
    
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"orders/insertOrderProduct/restId/%@/",[menuDefault objectForKey:@"Restaurantid"]];
    
    NSString *PostData=[NSString stringWithFormat:@"productId=%@&order_id=%@&qty=%@&sizeId=%@&price=%@&baseId=%@&toppingIdx1=%@&toppingIdx2=%d&fmId=%@&omId=%@&subTotal=%0.2f&type=%@&points=%@&service_tax=%@&local_tax=%@&other_tax=%@&vat=%@&tax_total=%0.2f&size_value=%@",[orderDictionary objectForKey:@"id"],orderId,[orderDictionary objectForKey:@"count"],[orderDictionary objectForKey:@"pizza_size_id"],[orderDictionary objectForKey:@"price"],[orderDictionary objectForKey:@"pizza_base_id"],[orderDictionary objectForKey:@"pizza_topping_id"],0,fmID,omID,[[orderDictionary objectForKey:@"price"] floatValue]+singlePrice,[orderDictionary objectForKey:@"type"],[orderDictionary objectForKey:@"points"],[orderDictionary objectForKey:@"is_servicetax"],[orderDictionary objectForKey:@"is_localtax"],[orderDictionary objectForKey:@"type"],[orderDictionary objectForKey:@"is_vat"],singlePrice,[orderDictionary objectForKey:@"size"]];
    NSLog(@"%@",PostData);
    
    
    [helper sentOrderListToTheServer:postString :PostData];
}

-(void)sentOrderListToTheServer:(NSString *)response
{
    
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCESS"])
    {
        orderListCounter++;
        if (orderListCounter<selectedOrderArray.count)
        {
            [self orderlistSentByForLoop:[finalArray objectAtIndex:orderListCounter]];
        }
        else
        {
            [finalArray removeAllObjects];
            [selectedOrderArray removeAllObjects];
            orderListView.hidden=YES;
            [orderListTable reloadData];
            servicesChargeLabel.text=@"0";
            subTotal.text=@"0";
            totelLable.text=@"0";
            TotalPriceList.text=@"0";
            selectedItemLabel.text=@"Items:0";
            itemCountLabel.text=@"0";
            orderView.hidden=YES;
            [appDelegate tabBarShow];
            [self clearAllField];
            [MyCustomeClass SVProgressMessageDismissWithError:@"Order successfully sent." :2.0];
            appDelegate.bookedTable=nil;
            appDelegate.orderSelected=NO;
            [self clickOnOrderClearButton:nil];
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKeyPath:@"OrderArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"Please remove all order and select onece again." :2.0];
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, textField.frame.origin.y - 1.5 * textField.frame.size.height);
    [scrollViewOrder setContentOffset:point animated:YES];
}

- (void) scrollVievEditingFinished:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, 0);
    [scrollViewOrder setContentOffset:point animated:YES];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    [self scrollViewAdaptToStartEditingTextField:textField];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self scrollVievEditingFinished:textField];
    return YES;
}

#pragma mark - update Location
-(void)findInternetConnectionName
{
    NSString *ssid = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs)
    {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
        }
    }
    wifiName=ssid;
    NSLog(@"wifiname=%@",wifiName);
}
-(void)currentLocation
{
    [self findInternetConnectionName];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    if (IS_IOS8)
    {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    locationManager.delegate=self;
    [self deviceLocation];
}

- (void)deviceLocation
{
    latitude= locationManager.location.coordinate.latitude;
    longitude=locationManager.location.coordinate.longitude;
    if (latitude<=0)
    {
        // latitude=24.4607833;
    }
    if (longitude<=0)
    {
        // longitude=54.3807539;
    }
    
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:latitude1 longitude:longitude1];
    
    CLLocationDistance distance1 = [locA distanceFromLocation:locB];
    
    distance=distance1;
    distance = 20;
    
    [locationManager stopUpdatingLocation];
    
    
    
}
-(void)restaurentLatiLongRequest
{
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    
    NSString *postData=[NSString stringWithFormat:@"%@",ciboRestaurantId];
    NSLog(@"%@",postData);
    [helper restaurentAddress:postData];
}

-(void)restaurentAddress:(NSString *)response
{
    //NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    // NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"FAIL"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Some connection issue."] :1.00];
    }
    else
    {
        NSMutableArray *infoArray=[[NSMutableArray alloc] init];
        infoArray= [dataDic objectForKey:@"restInfo"];
        NSMutableDictionary *restaurentInfoDic =[[NSMutableDictionary alloc] init];
        restaurentInfoDic =[infoArray objectAtIndex:0];
        latitude1=[[NSString stringWithFormat:@"%@",[restaurentInfoDic objectForKey:@"lat"]] floatValue];
        longitude1=[[NSString stringWithFormat:@"%@",[restaurentInfoDic objectForKey:@"lon"]] floatValue];
        
        NSData* data=[NSKeyedArchiver archivedDataWithRootObject:restaurentInfoDic];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"RestaurantDetail"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Successfully done."] :1.00];
    }
    
}
-(IBAction)clickOnSubmitButton:(id)sender
{
    [forceModifier removeAllObjects];
    [optionModifier removeAllObjects];
    [pizzaBaseArray removeAllObjects];
    [pizzaSizeArray removeAllObjects];
    [pizzaToppingArray removeAllObjects];
    if ([pizzaString isEqualToString:@"Size"])
    {
        if (selecetePizzaOption.count>0)
        {
            [choosedPizzaDetail addObjectsFromArray:selecetePizzaOption];
            
            [self pizzaBaseRequest:[[choosedPizzaDetail objectAtIndex:0] objectForKey:@"pizza_id"] sizeID:[[choosedPizzaDetail objectAtIndex:0] objectForKey:@"pizza_size_id"]];
            return;
        }
    }
    else if ([pizzaString isEqualToString:@"Topping"])
    {
        if (selecetePizzaOption.count>0)
        {
            [choosedPizzaDetail addObjectsFromArray:selecetePizzaOption];
            UIAlertView *alrtView=[[UIAlertView alloc] initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"Do you want to add in order list"] message:@"Confirmation" delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"NO"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"YES"], nil];
            [alrtView show];
            
            pizzaView.hidden=YES;
            return;
            
            
        }
    }
    else if ([pizzaString isEqualToString:@"Base"])
    {
        if (selecetePizzaOption.count>0)
        {
            [choosedPizzaDetail addObjectsFromArray:selecetePizzaOption];
            [self pizzaToppingRequest:[[choosedPizzaDetail objectAtIndex:0] objectForKey:@"pizza_id"] sizeID:[[choosedPizzaDetail objectAtIndex:0] objectForKey:@"pizza_size_id"]];
            return;
        }
    }
    else
    {
        if([modifierTitle.text isEqualToString:@"VALGMULIGHEDER"])
        {
            for(int i=0;i<modifierSelectedItemsArray.count;i++)
            {
                forceModifierPrice=forceModifierPrice+([[[modifierSelectedItemsArray objectAtIndex:i] objectForKey:@"price"] intValue]);
            }
            NSString *multipleModifierList=[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"forced_modifier_id2"];
            NSArray *multiModiFierIdArray=[MyCustomeClass seprateStringFromStringUsingArrray:multipleModifierList :@","];
            
            if (multiModiFierIdArray.count>0 && multipleModifierList.length>0)
            {
                BOOL nowOptionMf=NO;
                for (int i=0; i<multiModiFierIdArray.count; i++)
                {
                    if (selectedFModifierList.count==i+1)
                    {
                        [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
                        [modifierSelectedItemsArray removeAllObjects];
                        WebServiceHelper *web=[[WebServiceHelper alloc] init];
                        web.delegate=self;
                        NSString *urlString=[NSString stringWithFormat:@"menu/viewFm/restId/%@/fmCatId/%@",ciboRestaurantId,[multiModiFierIdArray objectAtIndex:i]];
                        [web getForceModifier:urlString];
                        i=5000;
                        nowOptionMf=NO;
                    }
                    else
                    {
                        nowOptionMf=YES;
                    }
                    
                }
                if (nowOptionMf==YES)
                {
                    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
                    [modifierSelectedItemsArray removeAllObjects];
                    WebServiceHelper *web=[[WebServiceHelper alloc] init];
                    web.delegate=self;
                    NSString *urlString=[NSString stringWithFormat:@"menu/viewOm/restId/%@/omCatId/%@",ciboRestaurantId,[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"optional_modifer_id"]];
                    [web getOptionModifier:urlString];
                }
                
                
            }
            else if (multipleModifierList.length>0)
            {
                if (selectedFModifierList.count>1)
                {
                    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
                    [modifierSelectedItemsArray removeAllObjects];
                    WebServiceHelper *web=[[WebServiceHelper alloc] init];
                    web.delegate=self;
                    NSString *urlString=[NSString stringWithFormat:@"menu/viewOm/restId/%@/omCatId/%@",ciboRestaurantId,[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"optional_modifer_id"]];
                    [web getOptionModifier:urlString];
                    
                }
                else
                {
                    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
                    [modifierSelectedItemsArray removeAllObjects];
                    WebServiceHelper *web=[[WebServiceHelper alloc] init];
                    web.delegate=self;
                    NSString *urlString=[NSString stringWithFormat:@"menu/viewFm/restId/%@/fmCatId/%@",ciboRestaurantId,multipleModifierList];
                    [web getForceModifier:urlString];
                }
            }
            else
            {
                [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
                [modifierSelectedItemsArray removeAllObjects];
                WebServiceHelper *web=[[WebServiceHelper alloc] init];
                web.delegate=self;
                NSString *urlString=[NSString stringWithFormat:@"menu/viewOm/restId/%@/omCatId/%@",ciboRestaurantId,[[itemFromSubCategory objectAtIndex:selectedCellIntegerValue] objectForKey:@"optional_modifer_id"]];
                [web getOptionModifier:urlString];
            }
        }
        else
        {
            for(int i=0;i<modifierSelectedItemsArray.count;i++)
            {
                optionModifierPrice=optionModifierPrice+([[[modifierSelectedItemsArray objectAtIndex:i] objectForKey:@"price"] intValue]);
            }
            
            UIAlertView *alrtView=[[UIAlertView alloc] initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"Do you want to add in order list"] message:@"Confirmation" delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"NO"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"YES"], nil];
            [alrtView show];
            
            modifierView.hidden=YES;
            [modifierSelectedItemsArray removeAllObjects];
            [optionModifier removeAllObjects];
            [forceModifier removeAllObjects];
            
        }
        
    }
    
}



#pragma mark - Modifier Response
-(void)getForceModifier:(NSString *)response
{
    NSLog(@"%@",response);
    NSMutableDictionary *dataDic=[MyCustomeClass jsonDictionary:response];
    forceModifier=[dataDic objectForKey:@"fmInfo"];
    if(forceModifier.count>0)
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Loaded." :1.0];
        [modiferTable reloadData];
        modifierView.hidden=NO;
        modifierTitle.text=@"VALGMULIGHEDER";
    }
    else
    {
        modifierView.hidden=YES;
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"" :1.0];
        modifierView.hidden=YES;
        UIAlertView *alrtView=[[UIAlertView alloc] initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"Do you want to add in order list"] message:@"Confirmation" delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"NO"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"YES"], nil];
        [alrtView show];
        
    }
    
}


-(void)getOptionModifier:(NSString *)response
{
    modifierTitle.text=@"Option modifier";
    
    NSMutableDictionary *dataDic=[MyCustomeClass jsonDictionary:response];
    optionModifier=[dataDic objectForKey:@"omInfo"];
    [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Loaded." :1.0];
    if (optionModifier.count>0)
    {
        [modiferTable reloadData];
        modifierView.hidden=NO;
        
    }
    else
    {
        modifierView.hidden=YES;
        UIAlertView *alrtView=[[UIAlertView alloc] initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"Do you want to add in order list"] message:@"Confirmation" delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"NO"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"YES"], nil];
        [alrtView show];
    }
    
}

-(IBAction)clickOnForceModiferRadioButton:(id)sender
{
    //if([modifierTitle.text isEqualToString:@"Force modifier"])
    {
        if (IS_IOS8)
        {
            fmodifierCell   = (FocreModifierCell *)[[sender superview] superview];
            
        }
        else
        {
            fmodifierCell   = (FocreModifierCell *)[[[sender superview] superview] superview];
        }
        
        NSIndexPath *clickedButtonPath = [modiferTable indexPathForCell:fmodifierCell];
        choosedFModifierInt=(int)clickedButtonPath.row;
        
        if (pizzaSizeArray.count>0)
        {
            NSIndexPath *clickedButtonPath = [pizzaTable indexPathForCell:fmodifierCell];
            choosedFModifierInt=(int)clickedButtonPath.row;
            
            if (selecetePizzaOption.count>0)
                [selecetePizzaOption removeAllObjects];
            
            [selecetePizzaOption addObject:[pizzaSizeArray objectAtIndex:choosedFModifierInt]];
            
            [pizzaTable reloadData];
            return;
        }
        else if (pizzaBaseArray.count>0)
        {
            NSIndexPath *clickedButtonPath = [pizzaTable indexPathForCell:fmodifierCell];
            choosedFModifierInt=(int)clickedButtonPath.row;
            
            if (selecetePizzaOption.count>0)
                [selecetePizzaOption removeAllObjects];
            
            [selecetePizzaOption addObject:[pizzaBaseArray objectAtIndex:choosedFModifierInt]];
            [pizzaTable reloadData];
            return;
        }
        
        if (selectedFModifierList.count>0)
        {
            BOOL checked=NO;
            for (int i=0; i<selectedFModifierList.count; i++)
            {
                if ([[[selectedFModifierList objectAtIndex:i] objectForKey:@"fm_cat_id"] isEqualToString:[[forceModifier objectAtIndex:choosedFModifierInt]objectForKey:@"fm_cat_id"]])
                {
                    [selectedFModifierList removeObjectAtIndex:i];
                    i=5000;
                    checked=YES;
                }
                else
                {
                    if ([[[selectedFModifierList objectAtIndex:i] objectForKey:@"fm_item_id"] isEqualToString:[[forceModifier objectAtIndex:choosedFModifierInt]objectForKey:@"fm_item_id"]])
                    {
                        [selectedFModifierList removeObjectAtIndex:choosedFModifierInt];
                        i=5000;
                        checked=NO;
                    }
                    else
                    {
                        checked=YES;
                    }
                }
            }
            if (checked==YES)
            {
                [selectedFModifierList addObject:[forceModifier objectAtIndex:choosedFModifierInt]];
            }
        }
        else
        {
            [selectedFModifierList addObject:[forceModifier objectAtIndex:choosedFModifierInt]];
        }
    }
    
    [modiferTable reloadData];
    
}

-(IBAction)clickOnOptionModiferRadioButton:(id)sender
{
    if (IS_IOS8)
    {
        omodifierCell   = (OptionModifierCell *)[[sender superview] superview];
        
    }
    else
    {
        omodifierCell   = (OptionModifierCell *)[[[sender superview] superview] superview];
        
    }
    
    if (pizzaToppingArray.count>0)
    {
        NSIndexPath *clickedButtonPath = [pizzaTable indexPathForCell:omodifierCell];
        choosedOModifierInt=(int)clickedButtonPath.row;
        
        if (selecetePizzaOption.count>0)
        {
            BOOL checked=NO;
            for (int i=0; i<selecetePizzaOption.count; i++)
            {
                if ([[[selecetePizzaOption objectAtIndex:i] objectForKey:@"pizza_topping_id"] isEqualToString:[[pizzaToppingArray objectAtIndex:choosedOModifierInt]objectForKey:@"pizza_topping_id"]])
                {
                    [selecetePizzaOption removeObjectAtIndex:choosedOModifierInt];
                    i=5000;
                    checked=NO;
                }
                else
                {
                    checked=YES;
                }
            }
            if (checked==YES)
            {
                [selecetePizzaOption addObject:[pizzaToppingArray objectAtIndex:choosedOModifierInt]];
            }
            
        }
        else
        {
            [selecetePizzaOption addObject:[pizzaToppingArray objectAtIndex:choosedOModifierInt]];
        }
        [pizzaTable reloadData];
        
        
    }
    else
    {
        NSIndexPath *clickedButtonPath = [modiferTable indexPathForCell:omodifierCell];
        choosedOModifierInt=(int)clickedButtonPath.row;
        
        if (selectedOModifierList.count>0)
        {
            BOOL checked=NO;
            for (int i=0; i<selectedOModifierList.count; i++)
            {
                if ([[[selectedOModifierList objectAtIndex:i] objectForKey:@"om_item_id"] isEqualToString:[[optionModifier objectAtIndex:choosedOModifierInt]objectForKey:@"om_item_id"]])
                {
                    [selectedOModifierList removeObjectAtIndex:choosedOModifierInt];
                    i=5000;
                    checked=NO;
                }
                else
                {
                    checked=YES;
                }
            }
            if (checked==YES)
            {
                [selectedOModifierList addObject:[optionModifier objectAtIndex:choosedOModifierInt]];
                
            }
        }
        else
        {
            [selectedOModifierList addObject:[optionModifier objectAtIndex:choosedOModifierInt]];
        }
        [modiferTable reloadData];
    }
}

#pragma mark - pizza Detail
-(void)pizzaToppingRequest:(NSString *)pizzaID sizeID: (NSString *)sizeID
{
    [pizzaSizeArray removeAllObjects];
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
    [modifierSelectedItemsArray removeAllObjects];
    WebServiceHelper *web=[[WebServiceHelper alloc] init];
    web.delegate=self;
    
    NSString *urlString=[NSString stringWithFormat:@"menu/viewPizzaTopping/restId/%@/pizzaId/%@/sizeId/%@",ciboRestaurantId,pizzaID,sizeID];
    [web toppingPizza:urlString];
}
-(void)pizzaBaseRequest:(NSString *)pizzaID sizeID: (NSString *)sizeID
{
    [pizzaToppingArray removeAllObjects];
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
    [modifierSelectedItemsArray removeAllObjects];
    WebServiceHelper *web=[[WebServiceHelper alloc] init];
    web.delegate=self;
    
    NSString *urlString=[NSString stringWithFormat:@"menu/viewPizzaBase/restId/%@/pizzaId/%@/sizeId/%@",ciboRestaurantId,pizzaID,sizeID];
    [web basePizza:urlString];
}
-(void)pizzaSizeRequest:(NSString *)pizzaID
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
    [modifierSelectedItemsArray removeAllObjects];
    WebServiceHelper *web=[[WebServiceHelper alloc] init];
    web.delegate=self;
    
    NSString *urlString=[NSString stringWithFormat:@"menu/viewPizzaPrice/restId/%@/pizza_id/%@",ciboRestaurantId,pizzaID];
    [web sizePizz:urlString];
}
-(void)pizzaPriceListRequest
{
    [modifierSelectedItemsArray removeAllObjects];
    WebServiceHelper *web=[[WebServiceHelper alloc] init];
    web.delegate=self;
    NSString *urlString=[NSString stringWithFormat:@"/menu/viewPizzaPrice/restId/%@/",ciboRestaurantId];
    [web sizePizz:urlString];
}

-(void)toppingPizza:(NSString *)response
{
    NSLog(@"%@",response);
    pizzaString=@"Topping";
    pizzaTitle.text=@"Topping";
    [pizzaBaseArray removeAllObjects];
    
    NSMutableDictionary *dataDic=[MyCustomeClass jsonDictionary:response];
    pizzaToppingArray=[dataDic objectForKey:@"pizzaToppingInfo"];
    [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Loaded." :1.0];
    [selecetePizzaOption removeAllObjects];
    if (pizzaToppingArray.count>0)
    {
        [pizzaTable reloadData];
         pizzaView.hidden=NO;
    }
    else
    {
        modifierView.hidden=YES;
        UIAlertView *alrtView=[[UIAlertView alloc] initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"Do you want to add in order list"] message:@"Confirmation" delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"NO"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"YES"], nil];
        [alrtView show];
    }
}

-(void)basePizza:(NSString *)response
{
    NSLog(@"%@",response);
    
    pizzaString=@"Base";
    pizzaTitle.text=@"Base";
    [pizzaSizeArray removeAllObjects];
    
    NSMutableDictionary *dataDic=[MyCustomeClass jsonDictionary:response];
    pizzaBaseArray=[dataDic objectForKey:@"pizzaBaseInfo"];
    [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Loaded." :1.0];
    [selecetePizzaOption removeAllObjects];
    
    if (pizzaBaseArray.count>0)
    {
        [pizzaTable reloadData];
        pizzaView.hidden=NO;
    }
    else
    {
        modifierView.hidden=YES;
        UIAlertView *alrtView=[[UIAlertView alloc] initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"Do you want to add in order list"] message:@"Confirmation" delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"NO"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"YES"], nil];
        [alrtView show];
    }
}

-(void)sizePizz:(NSString *)response
{
    NSLog(@"%@",response);
    pizzaString=@"Size";
    pizzaTitle.text=@"Size";
    NSMutableDictionary *dataDic=[MyCustomeClass jsonDictionary:response];
    pizzaSizeArray=[dataDic objectForKey:@"pizzaPriceInfo"];
    [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Loaded." :1.0];
    if (pizzaSizeArray.count>0)
    {
        [pizzaTable reloadData];
        pizzaView.hidden=NO;
        
    }
    
    
}
-(void)addRedBadge:(BOOL) showHide
{
    
    if (showHide)
    {
        [mkv setFont:[UIFont boldSystemFontOfSize:12]];
        [mkv setShine:NO];
        [mkv setShadow:NO];
        int count=0;
        int displayCount =0;
        for (int i=0; i<finalArray.count; i++)
        {
            count =[[[finalArray objectAtIndex:i] objectForKey:@"count"] intValue];
            displayCount= displayCount + count*[[[finalArray objectAtIndex:i] objectForKey:@"happyHourGet"] intValue];//
            if ([[[finalArray objectAtIndex:i] objectForKey:@"happyHourGet"] intValue]<=0)
            {
                displayCount = displayCount +count;
            }
        }
        itemCountLabel.text=[NSString stringWithFormat:@"%d",displayCount];

        mkv.value=displayCount;
        [badgeButton addSubview:mkv];
    }
    else
    {
        [mkv removeFromSuperview];
    }
    
    
}
-(void)priceCalulation
{
    //subTotal,*grandTotal;
    float subTtotalFloat=0.0;
    float grandTotalFloat=0.0;
    for (int i=0; i<[finalArray count]; i++)
    {
        float singlePrice=0;
        float vatTax=0.0;
        float otherTax=0.0;
        float serviceTax=0.0;
        float localTax=0.0;
        float forceModifierPrice11=0.0;
        float optionModifierPrice11=0.0;
        if(taxArray.count>0)
        {
            if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:i] objectForKey:@"is_vat" ]].length>0)
            {
                vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat"] floatValue] price:[[[finalArray objectAtIndex:i] objectForKey:@"price" ] floatValue]];
            }
            if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:i] objectForKey:@"is_othertax" ]].length>0)
            {
                otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax"] floatValue] price:[[[finalArray objectAtIndex:i] objectForKey:@"price" ] floatValue]];
            }
            if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:i] objectForKey:@"is_servicetax" ]].length>0)
            {
                serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax"]floatValue] price:[[[finalArray objectAtIndex:i] objectForKey:@"price" ] floatValue]];
                //serviceTax = [self addTaxWithDish:10.0 price:[[[finalArray objectAtIndex:i] objectForKey:@"price" ] floatValue]];
                
            }
            if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:i] objectForKey:@"is_localtax" ]].length>0)
            {
                localTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax"] floatValue] price:[[[finalArray objectAtIndex:i] objectForKey:@"price" ] floatValue]];
            }
            
        }
        
        singlePrice=vatTax+otherTax+serviceTax+localTax;
        NSArray *fmLocalArray=[[finalArray objectAtIndex:i] objectForKey:@"ForceModifier"];
        
        for(int k=0; k<fmLocalArray.count;k++)
        {
            forceModifierPrice11=forceModifierPrice11+[[[fmLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
        }
        NSArray *omLocalArray=[[finalArray objectAtIndex:i] objectForKey:@"OptionModifier"];
        
        for(int k=0; k<omLocalArray.count;k++)
        {
            optionModifierPrice11=optionModifierPrice11+[[[omLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
        }
        subTtotalFloat= subTtotalFloat + [[[finalArray objectAtIndex:i] objectForKey:@"price" ] floatValue]+optionModifierPrice11+forceModifierPrice11;
        grandTotalFloat= + grandTotalFloat+ singlePrice+forceModifierPrice11+optionModifierPrice11+[[[finalArray objectAtIndex:i] objectForKey:@"price" ] floatValue];
        
    }
    subTotal111= [NSString stringWithFormat:@"%.2f",subTtotalFloat];
    grandTotal=  [NSString stringWithFormat:@"%.2f",grandTotalFloat];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return itemFromSubCategory.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCollectionCell *menuCell1 = (MenuCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MenuCollectionCell" forIndexPath:indexPath];
    
    if ([itemFromSubCategory count]>indexPath.row)
    {
        if ([CategoryString isEqualToString:@"Dishes"])
        {
            menuCell1.itemNameLabel.text=[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"pname" ]];
            
            if(indexPath.row< [finalArray count])
            {
                NSString *totalTaxString=@"";
                float vatTax=0.0;
                float otherTax=0.0;
                float serviceTax=0.0;
                float local_Tax= 0.0;
                if(taxArray.count>0)
                {
                    if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"service_tax" ]].length>0)
                    {
                        vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"other_tax" ]].length>0)
                    {
                        otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]].length>0)
                    {
                        serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"local_tax" ]].length>0)
                    {
                        local_Tax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                    }
                    
                }
                
                totalTaxString=[NSString stringWithFormat:@"%.2f",[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
                
                menuCell1.itemPriceLabel.text=[NSString stringWithFormat:@"%@",totalTaxString];
                
                NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/menu/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                NSLog(@"%@",imageurl);
                [menuCell1.itemImage setImageWithURL:imageurl];
                
            }
            
            
        }
        else if ([CategoryString isEqualToString:@"Drinks"])
        {
            menuCell1.itemNameLabel.text=[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"drink_name" ]];
            
            if(indexPath.row< [finalArray count])
            {
                NSString *totalTaxString=@"";
                float vatTax=0.0;
                float otherTax=0.0;
                float serviceTax=0.0;
                float local_Tax=0.0;
                if(taxArray.count>0)
                {
                    if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"service_tax" ]].length>0)
                    {
                        vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"drink_price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"other_tax" ]].length>0)
                    {
                        otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"drink_price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]].length>0)
                    {
                        serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"drink_price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"local_tax" ]].length>0)
                    {
                        local_Tax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"drink_price" ] floatValue]];
                    }
                }
                
                totalTaxString=[NSString stringWithFormat:@"%.2f",[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"drink_price" ] floatValue]];
                
                menuCell1.itemPriceLabel.text=[NSString stringWithFormat:@"%@",totalTaxString];
                
                NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/drinks/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"drink_image"]]]];
                NSLog(@"%@",imageurl);
                [menuCell1.itemImage setImageWithURL:imageurl];
                
            }
            
        }
        else if ([CategoryString isEqualToString:@"Pizza"])
        {
            menuCell1.itemNameLabel.text=[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"title" ]];
            
            menuCell1.itemPriceLabel.text=@"";
            if ([[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]] length]==6)
            {
                NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/pizza/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                NSLog(@"%@",imageurl);
                [menuCell1.itemImage setImageWithURL:imageurl];
            }
            else
            {
                NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/pizza/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                NSLog(@"%@",imageurl);
                [menuCell.itemImage setImageWithURL:imageurl];
            }
            menuCell1.priceBackground.hidden=YES;
            
        }
        else if ([CategoryString isEqualToString:SPATIAL_OFFER])
        {
            menuCell1.itemNameLabel.text=[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"offer_name" ]];
            
            if(indexPath.row< [finalArray count])
            {
                NSString *totalTaxString=@"";
                float vatTax=0.0;
                float otherTax=0.0;
                float serviceTax=0.0;
                float localTax=0.0;
                
                if(taxArray.count>0)
                {
                    if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"service_tax" ]].length>0)
                    {
                        vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"offer_price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"other_tax" ]].length>0)
                    {
                        otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"offer_price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]].length>0)
                    {
                        serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"offer_price" ] floatValue]];
                    }
                    if([NSString stringWithFormat:@"%@",[[finalArray objectAtIndex:indexPath.row] objectForKey:@"local_tax" ]].length>0)
                    {
                        localTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax"] floatValue] price:[[[finalArray objectAtIndex:indexPath.row] objectForKey:@"offer_price" ] floatValue]];
                    }
                }
                
                //totalTaxString=[NSString stringWithFormat:@"%.2f",vatTax+otherTax+localTax+serviceTax+[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"offer_price" ] floatValue]];
                totalTaxString=[NSString stringWithFormat:@"%.2f",[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"offer_price" ] floatValue]];
                
                menuCell1.itemPriceLabel.text=[NSString stringWithFormat:@"%@",totalTaxString];
                
                if ([[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]] length]==6)
                {
                    NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/specialoffers/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                    NSLog(@"%@",imageurl);
                    [menuCell1.itemImage setImageWithURL:imageurl];
                }
                else
                {
                    NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/specialoffers/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"]]]];
                    NSLog(@"%@",imageurl);
                    [menuCell1.itemImage setImageWithURL:imageurl];
                }
                
                
            }
            
        }
        else if ([CategoryString isEqualToString:@"SetMenu"])
        {
            menuCell1.itemNameLabel.text=[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"offer_name" ]];
            
            menuCell1.itemPriceLabel.text=[NSString stringWithFormat:@"%.2f",[[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
            NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/offers/thumb/%@",[menuDefault objectForKey:@"Restaurantid"],[NSString stringWithFormat:@"%@",[[itemFromSubCategory objectAtIndex:indexPath.row] objectForKey:@"picture"]]]];
            NSLog(@"%@",imageurl);
            
            [menuCell1.itemImage setImageWithURL:imageurl];
            
        }
        
        [menuCell1.plusButton addTarget:self action:@selector(clickOnCellPlusButton:event:) forControlEvents:UIControlEventTouchUpInside];
    }
    return menuCell1;
    
    
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

-(void)taxRequest
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
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

-(void)happyHourRequest:(NSString *)happyHourID
{
    //happyHourID =@"55";
    WebServiceHelper *helper = [[WebServiceHelper alloc] init];
    helper.delegate=self;
    NSString *postUrl =[NSString stringWithFormat:@"restId/%@/hhId/%@",ciboRestaurantId,happyHourID];
    [helper happyHour:postUrl];
}

-(void)happyHour:(NSString *)response
{
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    happyHourArray =[dataDic objectForKey:@"happyhourInfo"];
    isHappyHour=NO;
    if (happyHourArray.count>1)
    {
        [happyHourArray removeAllObjects];
    }
    else
    {
        if (!happyHourArray.count>0)
            return;
        
        NSString *dayString = [[happyHourArray objectAtIndex:0] objectForKey:@"day"];
        
        NSArray *dayArray = [MyCustomeClass seprateStringFromStringUsingArrray:dayString :@","];
        if ([[[happyHourArray objectAtIndex:0] objectForKey:@"status"] intValue] == 1)
        {
            if ([[[happyHourArray objectAtIndex:0] objectForKey:@"online"] intValue] == 1)
            {
                BOOL breakLoop=NO;
                for (int i=0; i<dayArray.count; i++)
                {
                    if([[dayArray objectAtIndex:0] isEqualToString:[MyCustomeClass currentDay:[NSDate date]]])
                    {
                        
                        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
                        [formatter1 setDateFormat:@"HH:mm:ss"];
                        NSString *time = [formatter1 stringFromDate:[NSDate date]];
                        NSArray *currentArray=[MyCustomeClass seprateStringFromStringUsingArrray:time :@":"];
                        int fromTime = [[NSString stringWithFormat:@"%@",[[happyHourArray objectAtIndex:0] objectForKey:@"time_from"]] intValue];
                        int toTime = [[NSString stringWithFormat:@"%@",[[happyHourArray objectAtIndex:0] objectForKey:@"time_to"]] intValue];
                        int currentHour=[[NSString stringWithFormat:@"%@",[currentArray objectAtIndex:0]] intValue];
                        if (fromTime<=currentHour && toTime> currentHour)
                        {
                            breakLoop=YES;
                            break;
                        }
                    }
                }
                if (breakLoop ==YES)
                {
                    happyHourDiscount=nil;
                    happyHourBuy=nil;
                    happyhourPoint=nil;
                    happyHourAmount=nil;
                    happyHourGet =nil;
                    
                    NSString *type =[[happyHourArray objectAtIndex:0] objectForKey:@"type"];
                    if ([type isEqualToString:@"Buy_n_Get"])
                    {
                        happyHourBuy = [[happyHourArray objectAtIndex:0] objectForKey:@"buy_qty"];
                        happyHourGet =[[happyHourArray objectAtIndex:0] objectForKey:@"get_qty"];
                    }
                    else if ([type isEqualToString:@"Discount"])
                    {
                        happyHourDiscount = [[happyHourArray objectAtIndex:0] objectForKey:@"discount"];
                    }
                    else if ([type isEqualToString:@"Points"])
                    {
                        happyhourPoint = [[happyHourArray objectAtIndex:0] objectForKey:@"points"];
                    }
                    else if ([type isEqualToString:@"Amount"])
                    {
                        happyHourAmount = [[happyHourArray objectAtIndex:0] objectForKey:@"amount"];
                    }
                    isHappyHour=YES;
                }
            }
        }
    }
}

@end
