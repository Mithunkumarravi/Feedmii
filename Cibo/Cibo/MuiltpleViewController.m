//
//  MuiltpleViewController.m
//  Reataurant Cibo
//
//  Created by mithun ravi on 10/01/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import "MuiltpleViewController.h"
#import "SorterCollectionViewCell.h"
#import "MyOpenOrderViewController.h"

@interface MuiltpleViewController ()

@end

@implementation MuiltpleViewController
@synthesize multiRestaurantArray;
@synthesize fetchfavAFterChangeArray;
@synthesize favRestaurntArray;
@synthesize locationRestaurantArray;
@synthesize loadedArray;
@synthesize searchResults;
@synthesize typeArray;
@synthesize eventArray;
@synthesize couponArray;
@synthesize profileArray;
@synthesize typeFilArray;

////////////
@synthesize orderArrayList;
@synthesize productListArray;
@synthesize resturantArray;
@synthesize sortedArray;
@synthesize temprestaurantID;

- (void)viewDidLoad
{
    [super viewDidLoad];
    clickedButton=@"All";
    loadedArray=[[NSMutableArray alloc] init];
    typeArray = [[NSMutableArray alloc] init];
    fetchfavAFterChangeArray=[[NSMutableArray alloc] init];
    favRestaurntArray=[[NSMutableArray alloc] init];
    locationRestaurantArray=[[NSMutableArray alloc] init];
    multiRestaurantArray =[[NSMutableArray alloc] init];
    searchResults=[[NSMutableArray alloc] init];
    eventArray= [[NSMutableArray alloc] init];
    couponArray= [[NSMutableArray alloc] init];
    profileArray= [[NSMutableArray alloc] init];
    typeFilArray= [[NSMutableArray alloc] init];;
    
    searchImage.image=[UIImage imageNamed:@"search_icon.png"];
    UINib *cellNib = [UINib nibWithNibName:@"MultipleCollectionViewCell" bundle:nil];
    [multiCollection registerNib:cellNib forCellWithReuseIdentifier:@"MultipleCollectionViewCell"];
    
    UINib *cellNib1 = [UINib nibWithNibName:@"SorterCollectionViewCell" bundle:nil];
    [collectionViewSorter registerNib:cellNib1 forCellWithReuseIdentifier:@"SorterCollectionViewCell"];
  //
    [MyCustomeClass addSwipGestureFromLeftToRight:multiCollection action:@selector(moveRightToLeft) target:self];
    [MyCustomeClass addSwipGestureFromRightToLeft:newView action:@selector(moveLeftToRight) target:self];
    [MyCustomeClass addSwipGestureFromRightToLeft:sorterView action:@selector(moveSorterViewRightToLeft) target:self];
    
    ////////////////////////////
    
    [MyCustomeClass addSwipGestureFromRightToLeft:multiCollection action:@selector(moveRightToLeft_vwMyOrder) target:self];
    [MyCustomeClass addSwipGestureFromLeftToRight:vwMyOrder action:@selector(moveLeftToRight_vwMyOrder) target:self];
    
    ////////////////////////////////////////
    
    [self typeArrayFilling];
    [self allRestaurantListRequest];
    
    
    [allRest.titleLabel setFont:[UIFont fontWithName:FONT_Ragular size:12]];

    locationRest.titleLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    favRest.titleLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    allRest.titleLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    
    sorterFilterLabel.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [sorterFilterLabel setFont: [sorterFilterLabel.font fontWithSize: 20.0]];
    
    lblTitle.font=[UIFont fontWithName:FONT_Ragular size:22.0];
    [lblTitle setFont: [lblTitle.font fontWithSize: 22.0]];
    
    lblRestauranter.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblRestauranter setFont: [lblRestauranter.font fontWithSize: 12.0]];
    
    lblSorter.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblSorter setFont: [lblSorter.font fontWithSize: 12.0]];
    
    lblFavoritter.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblFavoritter setFont: [lblFavoritter.font fontWithSize: 12.0]];
    
    lblTilbud.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblTilbud setFont: [lblTilbud.font fontWithSize: 12.0]];
    
    lblKuponer.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblKuponer setFont: [lblKuponer.font fontWithSize: 12.0]];
    
    lblProfile.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblProfile setFont: [lblProfile.font fontWithSize: 12.0]];
    
    /////////////////
    orderArrayList=[[NSMutableArray alloc] init];
    productListArray=[[NSMutableArray alloc] init];
    sortedArray =[[NSMutableArray alloc] init];
    itemView.hidden=YES;
    //[MyCustomeClass drawBorder:itemView];
    [orderTable setSeparatorColor:[UIColor clearColor]];
    [itemTable setSeparatorColor:[UIColor brownColor]];
    openDefault=[NSUserDefaults standardUserDefaults];
    //[self myOrderListRequest];
    
    lblMyWallet.font=[UIFont fontWithName:FONT_Ragular size:22.0];
    [lblMyWallet setFont: [lblMyWallet.font fontWithSize: 22.0]];
    orderNameLabel.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [orderNameLabel setFont: [orderNameLabel.font fontWithSize: 20.0]];
    
    //itemView.layer.cornerRadius = 5;
    //itemView.layer.masksToBounds= YES;


}

-(void)viewWillAppear:(BOOL)animated
{
    clickedButton=@"All";
    [self currentLocation];
}

-(void)typeArrayFilling
{
    NSMutableDictionary *dataDic1 = [[NSMutableDictionary alloc] init];
    [dataDic1 setValue:@"Arabic" forKey:@"English"];
    [dataDic1 setValue:@"Arabisk" forKey:@"Other"];
    [dataDic1 setValue:@"arabic.png" forKey:@"image"];
    [typeArray addObject:dataDic1];
    
    NSMutableDictionary *dataDic2 = [[NSMutableDictionary alloc] init];
    [dataDic2 setValue:@"American" forKey:@"English"];
    [dataDic2 setValue:@"Amerikansk " forKey:@"Other"];
    [dataDic2 setValue:@"american.png" forKey:@"image"];
    [typeArray addObject:dataDic2];
    
    NSMutableDictionary *dataDic3 = [[NSMutableDictionary alloc] init];
    [dataDic3 setValue:@"Australien" forKey:@"English"];
    [dataDic3 setValue:@"Australsk " forKey:@"Other"];
    [dataDic3 setValue:@"austrelia.png" forKey:@"image"];
    //[typeArray addObject:dataDic3];//
    
    NSMutableDictionary *dataDic4 = [[NSMutableDictionary alloc] init];
    [dataDic4 setValue:@"Danish" forKey:@"English"];
    [dataDic4 setValue:@"Dansk " forKey:@"Other"];
    [dataDic4 setValue:@"Danish.png" forKey:@"image"];
    [typeArray addObject:dataDic4];//
    
    NSMutableDictionary *dataDic5 = [[NSMutableDictionary alloc] init];
    [dataDic5 setValue:@"Fusion" forKey:@"English"];
    [dataDic5 setValue:@"Fransk " forKey:@"Other"];
    //[typeArray addObject:dataDic5];
    
    NSMutableDictionary *dataDic6 = [[NSMutableDictionary alloc] init];
    [dataDic6 setValue:@"Greek" forKey:@"English"];
    [dataDic6 setValue:@"Græsk" forKey:@"Other"];
    [dataDic6 setValue:@"greek.png" forKey:@"image"];
    [typeArray addObject:dataDic6];
    
    NSMutableDictionary *dataDic7 = [[NSMutableDictionary alloc] init];
    [dataDic7 setValue:@"Indian" forKey:@"English"];
    [dataDic7 setValue:@"Indisk" forKey:@"Other"];
    [dataDic7 setValue:@"india.png" forKey:@"image"];

    [typeArray addObject:dataDic7];
    
    NSMutableDictionary *dataDic8 = [[NSMutableDictionary alloc] init];
    [dataDic8 setValue:@"Italien" forKey:@"English"];
    [dataDic8 setValue:@"Italiensk" forKey:@"Other"];
    [dataDic8 setValue:@"italien.png" forKey:@"image"];

    [typeArray addObject:dataDic8];
    
    NSMutableDictionary *dataDic9 = [[NSMutableDictionary alloc] init];
    [dataDic9 setValue:@"Japanese" forKey:@"English"];
    [dataDic9 setValue:@"Japansk " forKey:@"Other"];
    [dataDic9 setValue:@"japanese.png" forKey:@"image"];
    [typeArray addObject:dataDic9];
    
    NSMutableDictionary *dataDic10 = [[NSMutableDictionary alloc] init];
    [dataDic10 setValue:@"Chinese" forKey:@"English"];
    [dataDic10 setValue:@"Kinesisk" forKey:@"Other"];
    [dataDic10 setValue:@"Chinese.png" forKey:@"image"];
    [typeArray addObject:dataDic10];
    
    NSMutableDictionary *dataDic11 = [[NSMutableDictionary alloc] init];
    [dataDic11 setValue:@"Coratian" forKey:@"English"];
    [dataDic11 setValue:@"Kroatisk" forKey:@"Other"];
    //[typeArray addObject:dataDic11];
    
    NSMutableDictionary *dataDic12 = [[NSMutableDictionary alloc] init];
    [dataDic12 setValue:@"Mexicican" forKey:@"English"];
    [dataDic12 setValue:@"Mexicansk " forKey:@"Other"];
    [dataDic12 setValue:@"mexicansk.png" forKey:@"image"];
    [typeArray addObject:dataDic12];
    
    NSMutableDictionary *dataDic13 = [[NSMutableDictionary alloc] init];
    [dataDic13 setValue:@"Nordic" forKey:@"English"];
    [dataDic13 setValue:@"Nordisk" forKey:@"Other"];
    //[typeArray addObject:dataDic13];
    
    NSMutableDictionary *dataDic14 = [[NSMutableDictionary alloc] init];
    [dataDic14 setValue:@"Spainish" forKey:@"English"];
    [dataDic14 setValue:@"Spansk" forKey:@"Other"];
    //[typeArray addObject:dataDic14];
    
    NSMutableDictionary *dataDic15 = [[NSMutableDictionary alloc] init];
    [dataDic15 setValue:@"Thai" forKey:@"English"];
    [dataDic15 setValue:@"Thailandsk" forKey:@"Other"];
    //[typeArray addObject:dataDic15];
    
    NSMutableDictionary *dataDic16 = [[NSMutableDictionary alloc] init];
    [dataDic16 setValue:@"Turkish" forKey:@"English"];
    [dataDic16 setValue:@"Tyrkisk" forKey:@"Other"];
    //[typeArray addObject:dataDic16];
    
    NSMutableDictionary *dataDic17 = [[NSMutableDictionary alloc] init];
    [dataDic17 setValue:@"Vegitarian" forKey:@"English"];
    [dataDic17 setValue:@"Vegetar" forKey:@"Other"];
    //[typeArray addObject:dataDic17];
    
    NSMutableDictionary *dataDic18 = [[NSMutableDictionary alloc] init];
    [dataDic18 setValue:@"Vietnamese" forKey:@"English"];
    [dataDic18 setValue:@"Vietnamesisk" forKey:@"Other"];
    //[typeArray addObject:dataDic18];
    
    NSMutableDictionary *dataDic19 = [[NSMutableDictionary alloc] init];
    [dataDic19 setValue:@"Afcican" forKey:@"English"];
    [dataDic19 setValue:@"Arabisk" forKey:@"Other"];
    //[typeArray addObject:dataDic19];
    
    NSMutableDictionary *dataDic20 = [[NSMutableDictionary alloc] init];
    [dataDic20 setValue:@"Iranian" forKey:@"English"];
    [dataDic20 setValue:@"Iransk" forKey:@"Other"];
    //[typeArray addObject:dataDic20];
    
    NSMutableDictionary *dataDic21 = [[NSMutableDictionary alloc] init];
    [dataDic21 setValue:@"Lebanonese" forKey:@"English"];
    [dataDic21 setValue:@"Libanesisk" forKey:@"Other"];
    //[typeArray addObject:dataDic21];
    
    NSMutableDictionary *dataDic22 = [[NSMutableDictionary alloc] init];
    [dataDic22 setValue:@"Marocoan" forKey:@"English"];
    [dataDic22 setValue:@"Marokkansk" forKey:@"Other"];
    //[typeArray addObject:dataDic22];
    
    NSMutableDictionary *dataDic38 = [[NSMutableDictionary alloc] init];
    [dataDic38 setValue:@"Farnch" forKey:@"English"];
    [dataDic38 setValue:@"Farnch" forKey:@"Other"];
    [dataDic38 setValue:@"French.png" forKey:@"image"];
    [typeArray addObject:dataDic38];
    
    /*NSMutableDictionary *dataDic23 = [[NSMutableDictionary alloc] init];
    [dataDic23 setValue:@"Arabic" forKey:@"English"];
    [dataDic23 setValue:@"Arabisk" forKey:@"Other"];
    [typeArray addObject:dataDic23];
    
    NSMutableDictionary *dataDic24 = [[NSMutableDictionary alloc] init];
    [dataDic24 setValue:@"Korean" forKey:@"English"];
    [dataDic24 setValue:@"Koreansk" forKey:@"Other"];
    [typeArray addObject:dataDic24];
    
    NSMutableDictionary *dataDic25 = [[NSMutableDictionary alloc] init];
    [dataDic25 setValue:@"Pakistani" forKey:@"English"];
    [dataDic25 setValue:@"Pakistansk" forKey:@"Other"];
    [typeArray addObject:dataDic25];
    
    NSMutableDictionary *dataDic26 = [[NSMutableDictionary alloc] init];
    [dataDic26 setValue:@"Russian" forKey:@"English"];
    [dataDic26 setValue:@"Arabisk" forKey:@"Other"];
    [typeArray addObject:dataDic26];
    
    NSMutableDictionary *dataDic27 = [[NSMutableDictionary alloc] init];
    [dataDic27 setValue:@"South American" forKey:@"English"];
    [dataDic27 setValue:@"Sydamerikansk" forKey:@"Other"];
    [typeArray addObject:dataDic27];*/
    
   /* NSMutableDictionary *dataDic28 = [[NSMutableDictionary alloc] init];
    [dataDic28 setValue:@"Beijing" forKey:@"English"];
    [dataDic28 setValue:@"Beijing" forKey:@"Other"];
    [dataDic28 setValue:@"Chinese.png" forKey:@"image"];
    [typeArray addObject:dataDic28];
    
    NSMutableDictionary *dataDic29 = [[NSMutableDictionary alloc] init];
    [dataDic29 setValue:@"Shanghi" forKey:@"English"];
    [dataDic29 setValue:@"Shanghi" forKey:@"Other"];
    [dataDic29 setValue:@"shanghai.png" forKey:@"image"];
    [typeArray addObject:dataDic29];
    
    NSMutableDictionary *dataDic30 = [[NSMutableDictionary alloc] init];
    [dataDic30 setValue:@"Guangzhou" forKey:@"English"];
    [dataDic30 setValue:@"Guangzhou" forKey:@"Other"];
    [dataDic30 setValue:@"Guangzhou.png" forKey:@"image"];
    [typeArray addObject:dataDic30];
    
    NSMutableDictionary *dataDic31 = [[NSMutableDictionary alloc] init];
    [dataDic31 setValue:@"Mumabai" forKey:@"English"];
    [dataDic31 setValue:@"Mumabai" forKey:@"Other"];
    [dataDic31 setValue:@"mumbai.png" forKey:@"image"];
    [typeArray addObject:dataDic31];
    
    NSMutableDictionary *dataDic32 = [[NSMutableDictionary alloc] init];
    [dataDic32 setValue:@"New York" forKey:@"English"];
    [dataDic32 setValue:@"newyork.png" forKey:@"image"];
    //[typeArray addObject:dataDic32];
    
    NSMutableDictionary *dataDic33 = [[NSMutableDictionary alloc] init];
    [dataDic33 setValue:@"Los Angeles" forKey:@"English"];
    [dataDic33 setValue:@"Los Angeles" forKey:@"Other"];
    [dataDic33 setValue:@"Los-Angeles.png" forKey:@"image"];
    [typeArray addObject:dataDic33];
    
    NSMutableDictionary *dataDic34 = [[NSMutableDictionary alloc] init];
    [dataDic34 setValue:@"Miami" forKey:@"English"];
    [dataDic34 setValue:@"Miami" forKey:@"Other"];
    [dataDic34 setValue:@"Miami.png" forKey:@"image"];
    [typeArray addObject:dataDic34];
    
    NSMutableDictionary *dataDic35 = [[NSMutableDictionary alloc] init];
    [dataDic35 setValue:@"Philadelphia" forKey:@"English"];
    [dataDic35 setValue:@"Philadelphia" forKey:@"Other"];
    [dataDic35 setValue:@"Philadelphia.png" forKey:@"image"];
    [typeArray addObject:dataDic35];
    
    NSMutableDictionary *dataDic36 = [[NSMutableDictionary alloc] init];
    [dataDic36 setValue:@"HongKong" forKey:@"English"];
    [dataDic36 setValue:@"HongKong" forKey:@"Other"];
    [dataDic36 setValue:@"Hong-Kong.png" forKey:@"image"];
    [typeArray addObject:dataDic36];
    
    NSMutableDictionary *dataDic37 = [[NSMutableDictionary alloc] init];
    [dataDic37 setValue:@"London" forKey:@"English"];
    [dataDic37 setValue:@"London" forKey:@"Other"];
    [dataDic37 setValue:@"London.png" forKey:@"image"];
    //[typeArray addObject:dataDic37];
    
    NSMutableDictionary *dataDic38 = [[NSMutableDictionary alloc] init];
    [dataDic38 setValue:@"Paris" forKey:@"English"];
    [dataDic38 setValue:@"Paris" forKey:@"Other"];
    [dataDic38 setValue:@"French.png" forKey:@"image"];
    [typeArray addObject:dataDic38];
    
    NSMutableDictionary *dataDic39 = [[NSMutableDictionary alloc] init];
    [dataDic39 setValue:@"Rome" forKey:@"English"];
    [dataDic39 setValue:@"Rome" forKey:@"Other"];
    [dataDic39 setValue:@"Rome.png" forKey:@"image"];
    [typeArray addObject:dataDic39];
    
    NSMutableDictionary *dataDic40 = [[NSMutableDictionary alloc] init];
    [dataDic40 setValue:@"Singapore" forKey:@"English"];
    [dataDic40 setValue:@"Singapore" forKey:@"Other"];
    [dataDic40 setValue:@"Singapore.png" forKey:@"image"];
    [typeArray addObject:dataDic40];
    
    NSMutableDictionary *dataDic41 = [[NSMutableDictionary alloc] init];
    [dataDic41 setValue:@"Bangkok" forKey:@"English"];
    [dataDic41 setValue:@"Bangkok" forKey:@"Other"];
    [dataDic41 setValue:@"Bangkok.png" forKey:@"image"];
    [typeArray addObject:dataDic41];
    
    NSMutableDictionary *dataDic42 = [[NSMutableDictionary alloc] init];
    [dataDic42 setValue:@"Toronto" forKey:@"English"];
    [dataDic42 setValue:@"Toronto" forKey:@"Other"];
    [dataDic42 setValue:@"Toronto.png" forKey:@"image"];
    [typeArray addObject:dataDic42];
    
    //NSMutableDictionary *dataDic43 = [[NSMutableDictionary alloc] init];
    //[dataDic43 setValue:@"Other" forKey:@"English"];
    //[dataDic43 setValue:@"Others" forKey:@"Other"];
    //[typeArray addObject:dataDic43];
    [typeTableView reloadData];*/
}

-(void)moveSorterViewRightToLeft
{
    [MyCustomeClass myMovingAnimationLeftRight:sorterView direction:1 :320];
    [MyCustomeClass myMovingAnimationLeftRight:newView direction:1 :320];
    [MyCustomeClass myMovingAnimationLeftRight:vwMyOrder direction:0 :320];
}

-(void)moveRightToLeft
{
    [MyCustomeClass myMovingAnimationLeftRight:newView direction:0 :320];
}
-(void)moveLeftToRight
{
    [MyCustomeClass myMovingAnimationLeftRight:newView direction:1 :320];
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
-(IBAction)clickOnLocationButton:(id)sender
{
    //[loadedArray removeAllObjects];
    [loadedArray addObjectsFromArray:locationRestaurantArray];
    clickedButton=@"Location";

    [multiCollection reloadData];
}


-(IBAction)clickOnFavHeartButton:(id)sender
{
    MultipleCollectionViewCell *multiCell;
    NSMutableArray *getFavRestaurantArray =[[NSMutableArray alloc] init];
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"FavRestaurant"];
    [getFavRestaurantArray addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    
    if (IS_IOS8)
        multiCell = (MultipleCollectionViewCell *)[[sender superview] superview] ;
    else
        multiCell = (MultipleCollectionViewCell *)[[[sender superview] superview] superview] ;
    
   int index = multiCell.likeButton.tag;
    //NSIndexPath *indexPath = [multiCollection indexPathForCell:multiCell];
    NSDictionary *DIC =[[loadedArray objectAtIndex:index]  objectForKey:@"Value"];
    NSString *fevRestId =[NSString stringWithFormat:@"%@",[DIC valueForKey:@"restaurant_id"]];
    BOOL ClickedHeart=NO;
    int favIndex=0;
    for (int i =0; i<getFavRestaurantArray.count; i++)
    {
        if ([fevRestId isEqualToString:[NSString stringWithFormat:@"%@",[getFavRestaurantArray objectAtIndex:i]]])
        {
            ClickedHeart=YES;
            favIndex=i;
            break;
        }
    }
    if (ClickedHeart)
    {
        [getFavRestaurantArray removeObjectAtIndex:favIndex];
    }
    else
    {
        [getFavRestaurantArray addObject:fevRestId];
    }
    
     NSData *savedata=[NSKeyedArchiver archivedDataWithRootObject:getFavRestaurantArray];
    [[NSUserDefaults standardUserDefaults] setObject:savedata forKey:@"FavRestaurant"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [multiCollection reloadData];
}

-(IBAction)keyboardDismiss:(id)sender
{
    [searchtext resignFirstResponder];
}

-(void)currentLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    if (IS_IOS8)
    {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    locationManager.delegate=self;
}

- (void)deviceLocation :(NSMutableArray *)unShort
{
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
    NSMutableArray *distanceArray =[[NSMutableArray alloc] init];
    for (int i=0; i<unShort.count; i++)
    {
        float latitude =[[NSString stringWithFormat:@"%@",[[unShort objectAtIndex:i] valueForKey:@"lat"]] floatValue];
        float longitude =[[NSString stringWithFormat:@"%@",[[unShort objectAtIndex:i] valueForKey:@"lon"]] floatValue];
        CLLocation *locB = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        CLLocationDistance distance1 = [locA distanceFromLocation:locB];
        NSMutableDictionary *distancedic =[[NSMutableDictionary alloc] init];
        [distancedic setValue:[NSString stringWithFormat:@"%f",distance1] forKey:@"Distance"];
        [distancedic setValue:[NSString stringWithFormat:@"%d",i] forKey:@"Index"];
        [distanceArray addObject:distancedic];
    }
    
    NSSortDescriptor* sortDes = [[NSSortDescriptor alloc] initWithKey:@"Distance" ascending:YES];
    [distanceArray sortUsingDescriptors:[NSArray arrayWithObject:sortDes]];
    
    for (int i = 0; i<distanceArray.count; i++)
    {
        NSLog(@"%d",[[[distanceArray objectAtIndex:i] valueForKey:@"Index"] intValue]);
        NSMutableDictionary *distanceDic =[[NSMutableDictionary alloc] init];
        [distanceDic setValue:[[distanceArray objectAtIndex:i] valueForKey:@"Distance"]  forKey:@"Distance"];
        [distanceDic setValue:[unShort objectAtIndex:[[[distanceArray objectAtIndex:i] valueForKey:@"Index"] intValue]]  forKey:@"Value"];
        [multiRestaurantArray addObject:distanceDic];
    }

   // [locationManager stopUpdatingLocation];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView1
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView1 numberOfItemsInSection:(NSInteger)section
{
    
    if (collectionView1 == multiCollection )
    {
        return loadedArray.count;
    }
    else
    {
        return typeArray.count;

    }
}

+ (BOOL)checkersCellAtIndexIsDark:(NSIndexPath *)indexPath {
    NSInteger squareIndex = indexPath.item % 4;
    return (squareIndex == 0 || squareIndex == 3);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    if (collectionView1==multiCollection)
    {
        MultipleCollectionViewCell *cell = (MultipleCollectionViewCell *)[multiCollection dequeueReusableCellWithReuseIdentifier:@"MultipleCollectionViewCell" forIndexPath:indexPath];
        if (loadedArray.count>0)
        {
            NSMutableDictionary * displayDic =[[loadedArray objectAtIndex:indexPath.row] objectForKey:@"Value"];
            
            cell.restName.font=[UIFont fontWithName:FONT_Ragular size:19.0];
            [cell.restName setFont: [cell.restName.font fontWithSize: 19.0]];

            cell.restName.text=[NSString stringWithFormat:@"%@",[displayDic valueForKey:@"rname"]];
            
            NSString *distance = [self distanceSettings:[[loadedArray objectAtIndex:indexPath.row] objectForKey:@"Distance"]];
            NSString *typeString =[NSString stringWithFormat:@"%@ (%@)",[displayDic valueForKey:@"foodtype"],distance];
            cell.likeLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
            [cell.likeLabel setFont: [cell.likeLabel.font fontWithSize: 12.0]];

            cell.likeLabel.text=typeString;
            if ([NSString stringWithFormat:@"%@",[displayDic valueForKey:@"foodtype"]].length<=0)
            {
                NSString *typeString =[NSString stringWithFormat:@"Other (%@)",distance];
                cell.likeLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
                cell.likeLabel.text=typeString;
            }
            
            NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/logo/thumb/%@",[NSString stringWithFormat:@"%@",[displayDic valueForKey:@"restaurant_id"]],[NSString stringWithFormat:@"%@",[displayDic valueForKey:@"logo"]]]];
            
            [cell.logoImageView setImageWithURL:imageurl];
            if(cell.logoImageView.image==nil)
            {
                cell.logoImageView.image=[UIImage imageNamed:@"logo 2.png"];
            }
            NSMutableArray *getFavRestaurantArray =[[NSMutableArray alloc] init];
            NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"FavRestaurant"];
            getFavRestaurantArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            NSString *fevRestId =[NSString stringWithFormat:@"%@",[displayDic valueForKey:@"restaurant_id"]];
            BOOL ClickedHeart=NO;
            for (int i =0; i<getFavRestaurantArray.count; i++)
            {
                if ([fevRestId isEqualToString:[NSString stringWithFormat:@"%@",[getFavRestaurantArray objectAtIndex:i]]])
                {
                    ClickedHeart=YES;
                    break;
                }
            }
            if (ClickedHeart)
                [cell.likeButton setBackgroundImage:[UIImage imageNamed:@"heart_red.png"] forState:UIControlStateNormal];
            else
                [cell.likeButton setBackgroundImage:[UIImage imageNamed:@"heart_gray.png"] forState:UIControlStateNormal];
        }
        
        [cell.likeLabel setFont: [cell.likeLabel.font fontWithSize: 12.0]];

        cell.likeButton.tag=indexPath.row;
        [cell.likeButton addTarget:self action:@selector(clickOnFavHeartButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell.likeClickedButton addTarget:self action:@selector(clickOnFavHeartButton:) forControlEvents:UIControlEventTouchUpInside];
        cell.likeClickedButton.titleLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
        cell.likeButton.titleLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(menuController:)];
        [cell addGestureRecognizer:recognizer];
        return cell;

        }
    else
    {
        SorterCollectionViewCell *cell1 = (SorterCollectionViewCell *)[collectionViewSorter dequeueReusableCellWithReuseIdentifier:@"SorterCollectionViewCell" forIndexPath:indexPath];
        
        cell1.imgRestType.image = [UIImage imageNamed:[[typeArray objectAtIndex:indexPath.row] objectForKey:@"image"]];
        
        cell1.lblSorterCollectionCell.text   = [[typeArray objectAtIndex:indexPath.row] objectForKey:@"Other"];
        cell1.lblSorterCollectionCell.font=[UIFont fontWithName:FONT_Ragular size:18.0];
        [cell1.lblSorterCollectionCell setFont: [cell1.lblSorterCollectionCell.font fontWithSize: 18.0]];

        
        cell1.backgroundColor = ([[self class] checkersCellAtIndexIsDark:indexPath])? [UIColor colorWithRed:179/255.0 green:206.0/255.0 blue:0.0/255.0 alpha:1.0] : [UIColor whiteColor];

        /*if ( indexPath.row % 2 == 0 )
            cell1.backgroundColor = [UIColor yellowColor];
        else
            cell1.backgroundColor = [UIColor greenColor];
    */
        sorterView.frame=CGRectMake(0, sorterView.frame.origin.y, sorterView.frame.size.width, sorterView.frame.size.height);
        return cell1;
    }
}


- (void)collectionView:(UICollectionView *)collectionView1 didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView1==multiCollection)
    {
        if (loadedArray.count>indexPath.row)
        {
            NSMutableDictionary * displayDic =[[loadedArray objectAtIndex:indexPath.row] objectForKey:@"Value"];
            
            // set restaurant id.
            ciboRestaurantId= [NSString stringWithFormat:@"%@",[displayDic valueForKey:@"restaurant_id"]];
            //ciboRestaurantId=@"30692730";//@"30692730";
            [[NSUserDefaults standardUserDefaults] setValue:ciboRestaurantId forKey:@"Restaurantid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            /// set restaraunt name
            ciboRestaurantName = [NSString stringWithFormat:@"%@",[displayDic valueForKey:@"rname"]];
            
            /// set table booking flag
            isTableBooking = [[displayDic valueForKey:@"tablebooking"] intValue];
            
            /// last order data
            NSData* data11 = [[NSUserDefaults standardUserDefaults] objectForKey:@"OrderArray"];
            if (data11.length>0)
            {
                NSArray  *selectedOrderArray = [NSKeyedUnarchiver unarchiveObjectWithData:data11];
                if (selectedOrderArray.count>0)
                {
                    NSString *lastRestaurantID = [[selectedOrderArray objectAtIndex:0] objectForKey:@"restaurant_id"];
                    if (![lastRestaurantID isEqualToString:ciboRestaurantId])
                    {
                        [[NSUserDefaults standardUserDefaults] setValue:@"" forKeyPath:@"OrderArray"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                    }
                }
            }
            
            /// set restaurant data
             NSData* data=[NSKeyedArchiver archivedDataWithRootObject:displayDic];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"RestaurantDetail"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            /// set all restaurant list
            NSData* data111=[NSKeyedArchiver archivedDataWithRootObject:multiRestaurantArray];
            [[NSUserDefaults standardUserDefaults] setObject:data111 forKey:@"RestaurantList"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }
    else
    {
        foodType = [[typeArray objectAtIndex:indexPath.row] objectForKey:@"English"];
        [self filterByFoodType];
        [self moveSorterViewRightToLeft];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

- (CGFloat)collectionView:(UICollectionView *)collectionView1 layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView1==collectionViewSorter)
    {
        return 0;
    }
    return 0;
}


- (void)menuController:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint longLocation = [recognizer locationInView:multiCollection];
        NSIndexPath *indexPath = [multiCollection indexPathForItemAtPoint:longLocation];
        //
        RestaurantDetailViewController *restDetail =[[RestaurantDetailViewController alloc] initWithNibName:@"RestaurantDetailViewController" bundle:nil];
        restDetail.detailDic=[[loadedArray objectAtIndex:indexPath.row] objectForKey:@"Value"];
        //[restDetail setDetailDic:[loadedArray objectAtIndex:indexPath.row]];
        restDetail.latidue=locationManager.location.coordinate.latitude;
        restDetail.longitude=locationManager.location.coordinate.longitude;
        [self  presentViewController:restDetail animated:true completion:nil];
    }
}
-(NSString *)distanceSettings:(NSString *)distance
{
    NSString *finalDistance =@"0";
    float distanceInFloat =[distance floatValue];
    distanceInFloat =distanceInFloat/1000;
    if (distanceInFloat>0)
    {
        finalDistance = [NSString stringWithFormat:@"%.2f Km",distanceInFloat];
        return finalDistance;
    }
    distanceInFloat = [distance floatValue];

    if (distanceInFloat>0)
         finalDistance = [NSString stringWithFormat:@"%.2f m",distanceInFloat];
    else
        finalDistance = [NSString stringWithFormat:@"0.00 m"];
    
    return finalDistance;
}

-(void)allRestaurantListRequest
{
    countryString=@"Denmark";//@"Denmark";
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    [helper allRestaurantList:[MyCustomeClass whiteSpaceReplaceFromString:countryString]];
}

-(void)allRestaurantList:(NSString *)response
{
    [loadedArray removeAllObjects];
    [multiRestaurantArray removeAllObjects];
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[NSString stringWithFormat:@"%@",[dataDic valueForKey:@"RESULT"]] isEqualToString:@"SUCCESS"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Done." :1.0];
        [self deviceLocation:[dataDic valueForKey:@"INFO"]];
        [loadedArray addObjectsFromArray:multiRestaurantArray];
        [multiCollection reloadData];
    }
   /* if ([NSString stringWithFormat:@"%@",[dataDic valueForKey:@"restList"]].length>5)
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Done." :1.0];
        [self deviceLocation:[dataDic valueForKey:@"restList"]];
        [loadedArray addObjectsFromArray:multiRestaurantArray];
        [multiCollection reloadData];
    }*/
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"No Restaurant." :1.0];
    }
}

-(void)gettingFail:(NSString *)error
{
    [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Internet connection is not available." :2.5];
}



-(void)orderProductList:(NSString *)response
{
    [productListArray removeAllObjects];
    NSLog(@"%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    productListArray=[dataDic objectForKey:@"orderDetailInfo"] ;
    
    if (productListArray.count>0)
    {
        [itemTable reloadData];
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Done." :1.0];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"No Data." :1.0];
    }
    if ([move isEqualToString:@"NewClass"])
    {
        [self orderSendingPackage:0];
    }
    
    qunatityOfitems = 0;
    for (int i=0; i<productListArray.count; i++)
    {
        qunatityOfitems = qunatityOfitems + [[[[productListArray objectAtIndex:i] objectForKey:@"p" ] objectForKey:@"quantity"] intValue];
    }
    [itemTable reloadData];
}

#pragma mark - search Restaurant
-(void)filterContact:(NSString*)searchString
{
    [loadedArray removeAllObjects];
    [searchResults removeAllObjects];
    
    if ([clickedButton isEqualToString:@"All"])
    {
        [searchResults addObjectsFromArray:multiRestaurantArray];
    }
    else if ([clickedButton isEqualToString:@"Fav"])
    {
        [searchResults addObjectsFromArray:favRestaurntArray];
    }
    else if ([clickedButton isEqualToString:@"Event"])
    {
        [searchResults addObjectsFromArray:eventArray];
    }
    else if ([clickedButton isEqualToString:@"Coupon"])
    {
        [searchResults addObjectsFromArray:couponArray];
    }
    else if ([clickedButton isEqualToString:@"Type"])
    {
        [searchResults addObjectsFromArray:typeFilArray];
    }
    else if ([clickedButton isEqualToString:@"Coupon"])
    {
        [searchResults addObjectsFromArray:couponArray];
    }

    if (searchString.length>0)
    {
        NSArray *searchWords = [searchString componentsSeparatedByString:@" "];
        NSMutableArray *searchResults1 = [[NSMutableArray alloc] init];
        for (int i=0;i<searchResults.count;i++ )
        {
            NSDictionary *restDic = [[searchResults objectAtIndex:i] objectForKey:@"Value"];
            bool bAllWordsFound = NO;
            for(NSString* aWord in searchWords)
            {
                if(![aWord isEqualToString:@""])
                {
                    if ([[NSString stringWithFormat:@"%@",[restDic valueForKey:@"rname"]] rangeOfString:aWord options:NSCaseInsensitiveSearch].location == NSNotFound)
                    {
                        bAllWordsFound = NO;
                        break;
                    }
                    else
                        bAllWordsFound = YES;
                }
            }
            if(bAllWordsFound)
                [searchResults1 addObject:[searchResults objectAtIndex:i]];
        }
        [loadedArray addObjectsFromArray:searchResults1];
        [multiCollection reloadData];
    }
}

#pragma mark - TextField Delegate Method list
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    searchImage.hidden=YES;
    return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    lblTitle.hidden=YES;
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    lblTitle.hidden=NO;
    textField.text=nil;
    return YES;

}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    searchImage.hidden=NO;
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self filterContact:textField.text];
    return YES;
}// return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [loadedArray removeAllObjects];
    if ([clickedButton isEqualToString:@"All"])
    {
        [loadedArray addObjectsFromArray:multiRestaurantArray];
    }
    else if ([clickedButton isEqualToString:@"Fav"])
    {
        [loadedArray addObjectsFromArray:favRestaurntArray];
    }
    else
    {
        [loadedArray addObjectsFromArray:locationRestaurantArray];
    }
    [multiCollection reloadData];
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return  YES;
}// called when 'return' key pressed. return NO to ignore.

/*#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return typeArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"RootViewCell";
    RootViewCell *rootCell = (RootViewCell *)[typeTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (rootCell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"RootViewCell" owner:self options:nil];
        rootCell = [cellArray objectAtIndex:0];
    }
    if (typeArray.count)
    {
        rootCell.textLabel.text =[[typeArray objectAtIndex:indexPath.row] objectForKey:@"Other"];
    }
    rootCell.titleLabel.hidden=YES;
    return rootCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    foodType = [[typeArray objectAtIndex:indexPath.row] objectForKey:@"English"];
    [self filterByFoodType];
    [self moveSorterViewRightToLeft];
}*/

// slider method list
#pragma mark - slider method list
-(IBAction)clickOnBackButton:(id)sender
{
    foodType=nil;
    [self moveSorterViewRightToLeft];
}
-(IBAction)clickOnButtonOne:(id)sender
{
    [loadedArray removeAllObjects];
    [loadedArray addObjectsFromArray:multiRestaurantArray];
    clickedButton=@"All";
    [multiCollection reloadData];
    [self moveLeftToRight];
}
-(IBAction)clickOnButtonTwo:(id)sender
{
    clickedButton=@"Type";
    [MyCustomeClass myMovingAnimationLeftRight:sorterView direction:0 :320];
}

-(IBAction)clickOnButtonThree:(id)sender
{
    [loadedArray removeAllObjects];
    [favRestaurntArray removeAllObjects];
    clickedButton=@"Fav";
    NSMutableArray *getFavRestaurantArray1 =[[NSMutableArray alloc] init];
    NSData* data11 = [[NSUserDefaults standardUserDefaults] objectForKey:@"FavRestaurant"];
    [getFavRestaurantArray1 addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:data11]];
    for (int i =0; i<multiRestaurantArray.count; i++)
    {
        for (int j=0; j<getFavRestaurantArray1.count; j++)
        {
            NSDictionary * displayDic =[[multiRestaurantArray objectAtIndex:i] objectForKey:@"Value"];

            if ([[NSString stringWithFormat:@"%@",[displayDic valueForKey:@"restaurant_id"]] isEqualToString:[NSString stringWithFormat:@"%@",[getFavRestaurantArray1 objectAtIndex:j]]])
            {
                [favRestaurntArray addObject:[multiRestaurantArray objectAtIndex:i]];
                j=500000;
            }
        }
    }
    
    [loadedArray addObjectsFromArray:favRestaurntArray];
    [multiCollection reloadData];
    [self moveLeftToRight];
}

-(IBAction)clickOnButtonFour:(id)sender
{
    clickedButton=@"Event";
    [self moveLeftToRight];
    [self filterByEvents];
}

-(IBAction)clickOnButtonFive:(id)sender
{
    clickedButton=@"Coupon";
    [self moveLeftToRight];
    [self filterByCoupons];
}

-(IBAction)clickOnButtonSix:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Email"] length]>0)
    {
        //[self moveRightToLeft_vwMyOrder];
        SettingsViewController *settings =[[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
        [self presentViewController:settings animated:true completion:nil];
    }
    else
    {
        ViewController *viewController=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [self presentViewController:viewController animated:true completion:nil];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations objectAtIndex:0];
    //[locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
            countryString = [[NSString alloc]initWithString:placemark.country];
             NSLog(@"fff :%d ddd:%@",countryString.length,countryString);
             if (countryString.length>0)
             {
                 [locationManager stopUpdatingLocation];
                 [self allRestaurantListRequest];
             }
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
         }
     }];
}

-(void)filterByFoodType
{
    [typeFilArray removeAllObjects];
    [typeFilArray addObjectsFromArray:loadedArray];
    [loadedArray removeAllObjects];
    for (int i=0; i<multiRestaurantArray.count; i++)
    {
        NSMutableDictionary * displayDic =[[multiRestaurantArray objectAtIndex:i] objectForKey:@"Value"];
        
        if ([foodType isEqualToString:[displayDic objectForKey:@"foodtype"]])
        {
            [loadedArray addObject:[multiRestaurantArray objectAtIndex:i]];
        }
        if ([foodType isEqualToString:@"Other"])
        {
            if ([[NSString stringWithFormat:@"%@",[displayDic objectForKey:@"foodtype"] ] length]<=0)
            {
                [loadedArray addObject:[multiRestaurantArray objectAtIndex:i]];
            }
        }
    }
    [multiCollection reloadData];
}
-(void)filterByEvents
{
    [eventArray removeAllObjects];
    [eventArray addObjectsFromArray:loadedArray];
    [loadedArray removeAllObjects];
    for (int i=0; i<multiRestaurantArray.count; i++)
    {
        NSMutableDictionary * displayDic =[[multiRestaurantArray objectAtIndex:i] objectForKey:@"Value"];
       
        if ([[NSString stringWithFormat:@"%@",[displayDic objectForKey:@"event"] ] intValue]>0)
            {
                [loadedArray addObject:[multiRestaurantArray objectAtIndex:i]];
            }
    }
    [multiCollection reloadData];
}

-(void)filterByCoupons
{
    [couponArray removeAllObjects];
    [couponArray addObjectsFromArray:loadedArray];
    [loadedArray removeAllObjects];
    for (int i=0; i<multiRestaurantArray.count; i++)
    {
        NSMutableDictionary * displayDic =[[multiRestaurantArray objectAtIndex:i] objectForKey:@"Value"];
        
        if ([[NSString stringWithFormat:@"%@",[displayDic objectForKey:@"coupon"] ] intValue]>0)
        {
            [loadedArray addObject:[multiRestaurantArray objectAtIndex:i]];
        }
    }
    [multiCollection reloadData];
}
////////////////naveen
-(void)moveRightToLeft_vwMyOrder
{
    [MyCustomeClass myMovingAnimationLeftRight:vwMyOrder direction:1 :320];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Email"] length]>0)
    {
      [self myOrderListRequest];
    }
    else
    {
        ViewController *viewController=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [self presentViewController:viewController animated:true completion:nil];
    }

}
-(void)moveLeftToRight_vwMyOrder
{
    [MyCustomeClass myMovingAnimationLeftRight:vwMyOrder direction:0 :320];
    [self moveLeftToRight];

}


-(IBAction)clickONBackButton:(id)sender
{
    [MyCustomeClass myMovingAnimationLeftRight:vwMyOrder direction:0 :320];
    [self moveLeftToRight];
    //[self dismissViewControllerAnimated:true completion:nil];
}
-(void)listOfRestaurant
{
    [sortedArray removeAllObjects];
    for (int j = 0; j<multiRestaurantArray.count; j++)
    {
        NSMutableDictionary *dataDic =[[NSMutableDictionary alloc] init];
        [dataDic setValue:[[[multiRestaurantArray objectAtIndex:j] objectForKey:@"Value"] objectForKey:@"rname"] forKey:@"Restaurant"];
        NSMutableArray *innerArray = [[NSMutableArray alloc] init];
        for (int i=0; i<orderArrayList.count; i++)
        {
            if ([[[[multiRestaurantArray objectAtIndex:j] objectForKey:@"Value"] objectForKey:@"restaurant_id"] isEqualToString:[[orderArrayList objectAtIndex:i] objectForKey:@"restaurant_id"]])
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
        return 87;
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
        itemCell.quantitiyLabel.text=[NSString stringWithFormat:@"%@",[[[productListArray objectAtIndex:indexPath.row ] objectForKey:@"p" ] objectForKey:@"quantity"]];
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
    /*if(tableView== orderTable)
    {
        move=@"OldClass";
        orderNameLabel.text=[NSString stringWithFormat:@"Order %d",(int)(indexPath.row+1)];
        selectedOrderName = [NSString stringWithFormat:@"Order %d",(int)(indexPath.row+1)];
        selectedOrderAmount = [[NSString stringWithFormat:@"%.2f",[[[orderArrayList objectAtIndex:indexPath.row ] objectForKey:@"grand_total"] floatValue]]  floatValue];
        //lblTotalPrice.text = [NSString stringWithFormat:@"%0.2f",selectedOrderAmount];
        
        [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
        [self productDetailRequest:[[orderArrayList objectAtIndex:indexPath.row] objectForKey:@"order_id"]];
        [[NSUserDefaults standardUserDefaults] setValue:[[orderArrayList objectAtIndex:indexPath.row ]objectForKey:@"grand_total"] forKey:@"FinalPrice"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        orderId = [[orderArrayList objectAtIndex:indexPath.row] objectForKey:@"order_id"];
        orderLocation = [[orderArrayList objectAtIndex:indexPath.row] objectForKey:@"order_location"];
        selectedOrderDetail = [orderArrayList objectAtIndex:indexPath.row];
        itemView.hidden=NO;
    }*/

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
    //[MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    helper.delegate=self;
    [helper myOpenOrderList:[NSString stringWithFormat:@"memberId/%@",[openDefault valueForKey:@"Member"]]];
}
-(void)myOpenOrderList:(NSString *)response
{
    NSLog(@"%@",response);
    [orderArrayList removeAllObjects];
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



-(void)productDetailRequest:(NSString *)orderID restaurantId:(NSString *)restaurantID
{
    temprestaurantID = restaurantID;
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    helper.delegate=self;
    [helper orderProductList:[NSString stringWithFormat:@"restId/%@/oid/%@",restaurantID,orderID]];
}
////Naveen

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
