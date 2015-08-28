//
//  AlbumViewController.m
//  Cibo
//
//  Created by mithun ravi on 20/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "AlbumViewController.h"

enum
{
    ImageDemoCellTypePlain,
    ImageDemoCellTypeFill,
    ImageDemoCellTypeOffset
};

@interface AlbumViewController ()



@end

@implementation AlbumViewController

//@synthesize albumCollectionView;
@synthesize results;
@synthesize collectionView;
@synthesize titleLable;
@synthesize gallaryCategoryArray;
@synthesize actionSheet;
@synthesize pickerView;
@synthesize categoryID;
@synthesize gallaryArray;
@synthesize subtitleLabel;
@synthesize localImageView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    subtitleLabel.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [subtitleLabel setFont: [subtitleLabel.font fontWithSize: 20.0]];


    NSString *num = [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
    NSLog(@"%@",num);
    localImageView=[[UIImageView alloc] init];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    albumDefault =[NSUserDefaults standardUserDefaults];
    gallaryCategoryArray=[[NSMutableArray alloc] init];
    gallaryArray=[[NSMutableArray alloc] init];
    titleLable.text=ciboRestaurantName;
    [self galleryInfoRequest];
    UINib *cellNib = [UINib nibWithNibName:@"AlbumCell" bundle:nil];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:@"AlbumCell"];
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //[flowLayout setItemSize:CGSizeMake(140, 140)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [collectionView setCollectionViewLayout:flowLayout];
}

-(void)viewWillAppear:(BOOL)animated
{
    subtitleLabel.text=    [MyCustomeClass languageSelectedStringForKey:@"Gallary"];
    [appDelegate tabBarHide];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Webservics Request method
-(void)gettingGalleryCategroyList :(NSString *) categoryIDLocal
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Fetch Gallery data..."]];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postData=[NSString stringWithFormat:@"/gallery/viewGallery/restId/%@/galleryCatId/%@",ciboRestaurantId,categoryIDLocal];
    NSLog(@"%@",postData);
    [helper galleryCategoryFromServer:postData];
    
}
-(void)galleryInfoRequest
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Loading..."]];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postData=[NSString stringWithFormat:@"%@",ciboRestaurantId];
    NSLog(@"%@",postData);
    [helper gettingGallery:postData];
}

#pragma mark - Webservics Response method

-(void)gettingGallery:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"FAIL"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Some connection issue." ]:1.00];
    }
    else
    {
        gallaryCategoryArray= [dataDic objectForKey:@"galleryCatInfo"];
        if (gallaryCategoryArray.count>0)
        {
            [self gettingGalleryCategroyList:[NSString stringWithFormat:@"%@",[[gallaryCategoryArray objectAtIndex:0] objectForKey:@"id"]]];
            //[self.gridView reloadData];
            [self.collectionView reloadData];
        }
        else
        {
            [MyCustomeClass SVProgressMessageDismissWithError:@"No Data." :1.0];
        }
    }
}

-(void)galleryCategoryFromServer:(NSString *)response
{
    [gallaryArray removeAllObjects];
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"FAIL"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Some connection issue."] :1.00];
    }
    else
    {
        gallaryArray= [dataDic objectForKey:@"galleryInfo"];
        if (gallaryArray.count>0)
        {
            [collectionView reloadData];
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey: @"Successfully done."] :1.00];
        }
        else
        {
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey: @"No data."] :1.00];
        }
    }
}

-(void)gettingFail:(NSString*)error
{
    NSLog(@"%@",error);
    [MyCustomeClass SVProgressMessageDismissWithSuccess:error :1.00];
}

#pragma mark - action method list
-(IBAction)clickONGalleryCategoryButton:(id)sender
{
    if (timeBackgroundView==nil)
    {
        if(gallaryCategoryArray.count>0)
         [self addDataPickerWithDoneAndCancelButton];
        else
        {
            [[[UIAlertView alloc]initWithTitle:@"Alert !" message:@"Category not available now." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil] show];
        }
    }
}

-(IBAction)clickOnHomeButton:(id)sender
{
    UIApplication *application=nil;
    NSDictionary *dic=nil;
    [albumDefault setValue:@"Home" forKey:@"RootView"];
    [albumDefault setValue:@"Home" forKey:@"Logout"];
    
    [appDelegate application:application didFinishLaunchingWithOptions:dic];
}


#pragma mark - Data Picker methods

-(void)addDataPickerWithDoneAndCancelButton
{
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 200);
    
    pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    pickerToolbar.tintColor = [UIColor whiteColor];
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(clickOnCancelButtonOnActionSheet:)];
    
    [cancelBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                       NSForegroundColorAttributeName,
                                       nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *titleButton;
    float pickerMarginHeight = 168;
    titleButton = [[UIBarButtonItem alloc] initWithTitle:@"Category" style:UIBarButtonItemStylePlain target: nil action: nil];
    
    [titleButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                         NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnDoneButtonOnActionData:)];
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                     NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    
    NSArray *itemArray = [[NSArray alloc] initWithObjects:cancelBtn, flexSpace, titleButton, flexSpace, doneBtn, nil];
    
    [pickerToolbar setItems:itemArray animated:YES];
    
    if(IS_IPAD)
    {
        [pickerToolbar setFrame:CGRectMake(0, 0, 320, 44)];
        
        UIViewController* popoverContent = [[UIViewController alloc] init];
        popoverContent.preferredContentSize = CGSizeMake(320, 216);
        UIView* popoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
        popoverView.backgroundColor = [UIColor whiteColor];
        [popoverView addSubview:pickerView];
        [popoverView addSubview:pickerToolbar];
        popoverContent.view = popoverView;
        UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
        [popoverController presentPopoverFromRect:CGRectMake(0, pickerMarginHeight, 320, 216) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else
    {
        timeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 568-240, 320, 246)];
        [timeBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
        [timeBackgroundView addSubview:pickerToolbar];
        [timeBackgroundView addSubview:pickerView];
        [appDelegate.window addSubview:timeBackgroundView];
        timeBackgroundView.hidden=NO;
    }
}

-(IBAction)clickOnCancelButtonOnActionSheet:(id)sender
{
    timeBackgroundView.hidden=YES;
    [timeBackgroundView removeFromSuperview];
    timeBackgroundView=nil;
}
-(IBAction)clickOnDoneButtonOnActionData:(id)sender
{
    [self gettingGalleryCategroyList:categoryID];
    [actionSheet dismissWithClickedButtonIndex:1 animated:YES];
    timeBackgroundView.hidden=YES;
    [timeBackgroundView removeFromSuperview];
    timeBackgroundView=nil;
}

#pragma mark
#pragma mark PickrView datasource methods


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return gallaryCategoryArray.count;
    
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[gallaryCategoryArray objectAtIndex:row] objectForKey:@"cat_name"];
    
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    categoryID=[[gallaryCategoryArray objectAtIndex:row] objectForKey:@"id"];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return gallaryArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*if (indexPath.row%2==0)
    {
        AlbumViewCell *photoCell = (AlbumViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumViewCell" forIndexPath:indexPath];
        [photoCell.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/gallery/thumb/%@",ciboRestaurantId,[[gallaryArray objectAtIndex:indexPath.row]objectForKey:@"path"]]]];
        return photoCell;
    }
    else*/
    {
        AlbumCell *photoCell = (AlbumCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCell" forIndexPath:indexPath];
        
        [photoCell.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/gallery/thumb/%@",ciboRestaurantId,[[gallaryArray objectAtIndex:indexPath.row]objectForKey:@"path"]]]];
        return photoCell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView1 didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (gallaryArray.count>indexPath.row)
    {
        [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Image Loading..."]];
        AlbumDescriptionViewController *albumDescription=[[AlbumDescriptionViewController alloc] initWithNibName:@"AlbumDescriptionViewController" bundle:nil];
        [albumDescription setCoverImageArray:gallaryArray];
        [self.navigationController pushViewController:albumDescription animated:true];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Adjust cell size for orientation
    if (indexPath.row==0)
        return CGSizeMake(180, 140);
    else if (indexPath.row==1)
        return CGSizeMake(140, 140);
    else if (indexPath.row==2)
        return CGSizeMake(140, 140);
    else if (indexPath.row==3)
        return CGSizeMake(180, 140);
    else if (indexPath.row==4)
        return CGSizeMake(190, 140);
    else if (indexPath.row==5)
        return CGSizeMake(130, 140);
    
    
    return CGSizeMake(130, 140);

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.collectionView performBatchUpdates:nil completion:nil];
}

@end
