//
//  RootViewController.m
//  ContarCalorias
//
//  Created by mithun ravi on 14/10/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "RootViewController.h"
#define kExposedWidth 320.0

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize rootTableView;
@synthesize nameArray,imageArray;


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
    rootTableView.separatorColor=[UIColor yellowColor];
    rootDefault=[NSUserDefaults standardUserDefaults];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    nameArray= [[NSMutableArray alloc] initWithObjects:@"Profile",@"My Points",@"Visit site",@"Follow us on FB", @"My Wallet", @"Logout",nil];
    [rootTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //////////////////  menu view controller is set  /////////
    
    self.indexOfVisibleController = 0;
    UIViewController *visibleViewController = self.viewControllers[0];
    visibleViewController.view.frame = [self offScreenFrame];
    [self addChildViewController:visibleViewController]; // (5)
    [self.view addSubview:visibleViewController.view]; // (6)
    self.isMenuVisible = YES;
    [self adjustContentFrameAccordingToMenuVisibility]; // (7)
    [self.viewControllers[0] didMoveToParentViewController:self]; // (8)
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[rootDefault objectForKey:@"Email"] length]>0)
    {
        if (ciboRestaurantId>0)
        {
            [self restaurentAddressRequest];
            [self gettingUserMounchPoints];
        }
    }
}

-(void)layoutSettingsWithiOSANDDvice
{
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nameArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier=@"RootViewCell";
    RootViewCell *rootCell = (RootViewCell *)[rootTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (rootCell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"RootViewCell" owner:self options:nil];
        rootCell = [cellArray objectAtIndex:0];
    }
    if (indexPath.row==0)
    {
        rootCell.titleImageView.image=[UIImage imageNamed:@"profile.png"];
        rootCell.titleImageView.frame=CGRectMake(35, 20, 30, 30);
        rootCell.titleLabel.frame=CGRectMake(120, 20, 200, 30);
        UIImageView *cellImageView=[[UIImageView alloc]init];
        cellImageView.frame=CGRectMake(40, 5, 300, 60);
        cellImageView.image=[UIImage imageNamed:@" menuCell_bg.png"] ;
         [rootCell.contentView addSubview:cellImageView];
        
        UIImageView *circleImageView=[[UIImageView alloc]init];
        circleImageView.frame=CGRectMake(20, 4, 62, 62);
        circleImageView.image=[UIImage imageNamed:@"leaf.png"] ;
        [rootCell.contentView addSubview:circleImageView];
    }
    else if (indexPath.row==1)
    {
        rootCell.titleImageView.image=[UIImage imageNamed:@"Point1.png"];
        rootCell.titleImageView.frame=CGRectMake(255, 20, 30, 30);
        rootCell.titleLabel.frame=CGRectMake(50, 20, 150, 30);
        
        UIImageView *cellImageView=[[UIImageView alloc]init];
        cellImageView.frame=CGRectMake(-20, 5, 300, 60);
        cellImageView.image=[UIImage imageNamed:@" menuCell_bg.png"] ;
        [rootCell.contentView addSubview:cellImageView];
        
        UIImageView *circleImageView=[[UIImageView alloc]init];
        circleImageView.frame=CGRectMake(240, 4, 62, 62);
        circleImageView.image=[UIImage imageNamed:@"leaf.png"] ;
        [rootCell.contentView addSubview:circleImageView];


    }
    else if (indexPath.row==2)
    {
        rootCell.titleImageView.image=[UIImage imageNamed:@"visit site.png"];
        rootCell.titleImageView.frame=CGRectMake(35, 20, 30, 30);
        rootCell.titleLabel.frame=CGRectMake(120, 20, 200, 30);

        
        UIImageView *cellImageView=[[UIImageView alloc]init];
        cellImageView.frame=CGRectMake(40, 5, 300, 60);
        cellImageView.image=[UIImage imageNamed:@" menuCell_btn.png"] ;
        [rootCell.contentView addSubview:cellImageView];
        
        UIImageView *circleImageView=[[UIImageView alloc]init];
        circleImageView.frame=CGRectMake(20, 4, 62, 62);
        circleImageView.image=[UIImage imageNamed:@"leaf.png"] ;
        [rootCell.contentView addSubview:circleImageView];
    }
    
    else if (indexPath.row==3)
    {
        rootCell.titleImageView.image=[UIImage imageNamed:@"facebook.png"];
        rootCell.titleImageView.frame=CGRectMake(255, 20, 30, 30);
        rootCell.titleLabel.frame=CGRectMake(50, 20, 200, 30);
        UIImageView *cellImageView=[[UIImageView alloc]init];
        cellImageView.frame=CGRectMake(-20, 5, 300, 60);
        cellImageView.image=[UIImage imageNamed:@" menuCell_bg.png"] ;
        [rootCell.contentView addSubview:cellImageView];
        
        UIImageView *circleImageView=[[UIImageView alloc]init];
        circleImageView.frame=CGRectMake(240, 4, 62, 62);
        circleImageView.image=[UIImage imageNamed:@"leaf.png"] ;
        [rootCell.contentView addSubview:circleImageView];


    }
    else if (indexPath.row==4)
    {
        rootCell.titleImageView.image=[UIImage imageNamed:@"online_order.png"];
        rootCell.titleImageView.frame=CGRectMake(35, 20, 30, 30);
        rootCell.titleLabel.frame=CGRectMake(120, 20, 200, 30);
        UIImageView *cellImageView=[[UIImageView alloc]init];
        cellImageView.frame=CGRectMake(40, 5, 300, 60);
        cellImageView.image=[UIImage imageNamed:@" menuCell_bg.png"] ;
        [rootCell.contentView addSubview:cellImageView];
        UIImageView *circleImageView=[[UIImageView alloc]init];
        circleImageView.frame=CGRectMake(20, 4, 62, 62);
        circleImageView.image=[UIImage imageNamed:@"leaf.png"] ;
        [rootCell.contentView addSubview:circleImageView];
    }
    else if (indexPath.row==5)
    {
        rootCell.titleImageView.image=[UIImage imageNamed:@"Logout.png"];
        rootCell.titleImageView.frame=CGRectMake(255, 20, 30, 30);
        rootCell.titleLabel.frame=CGRectMake(50, 20, 200, 30);
        UIImageView *cellImageView=[[UIImageView alloc]init];
        cellImageView.frame=CGRectMake(-20, 5, 300, 60);
        cellImageView.image=[UIImage imageNamed:@" menuCell_bg.png"] ;
        [rootCell.contentView addSubview:cellImageView];
        UIImageView *circleImageView=[[UIImageView alloc]init];
        circleImageView.frame=CGRectMake(240, 4, 62, 62);
        circleImageView.image=[UIImage imageNamed:@"leaf.png"] ;
        [rootCell.contentView addSubview:circleImageView];
    }
        rootCell.selectionStyle = UITableViewCellEditingStyleNone;
        rootCell.titleLabel.text= [nameArray objectAtIndex:indexPath.row];
        //rootCell.backgroundColor=[UIColor clearColor];
    
    if (indexPath.row==1)
    {
        if(munchPoint<=0)
        {
            munchPoint=@"0";
        }
        rootCell.titleLabel.text= [NSString stringWithFormat:@"%@: %@",[nameArray objectAtIndex:indexPath.row],munchPoint];
    }
    rootCell.titleLabel.font=[UIFont fontWithName:FONT_Ragular size:20.0];
  
    [rootCell.titleLabel setFont: [rootCell.titleLabel.font fontWithSize: 20.0]];

        return rootCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==7)
    {
        [rootDefault setValue:@"No" forKey:@"IS_Login"];
        [appDelegate application:nil didFinishLaunchingWithOptions:nil];
    }
    else if(indexPath.row==0)
    {
       // [self replaceVisibleViewControllerWithViewControllerAtIndex:1];
        SettingsViewController *settings=[[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
        settings.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:settings animated:true completion:nil];
    }
    else if (indexPath.row==5)
    {
        [rootDefault setValue:@"Logout" forKey:@"Logout"];
        [rootDefault setValue:@"view" forKey:@"RootView"];
        UIApplication *application;
        [appDelegate application:application didFinishLaunchingWithOptions:nil];
        // [self.navigationController popViewControllerAnimated:true];
        [rootDefault setValue:@"" forKey:@"Email"];
        [self replaceVisibleViewControllerWithViewControllerAtIndex:0];
    }
    else if (indexPath.row==4)
    {
        MyOpenOrderViewController *order=[[MyOpenOrderViewController alloc] initWithNibName:@"MyOpenOrderViewController" bundle:nil];
        NSData* data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"RestaurantList"];
        order.resturantArray = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
        order.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:order animated:true completion:nil];
    }
    else if (indexPath.row==2)
    {
        if ([[restaurentInfoDic objectForKey:@"domain"] length]>0)
        {
             WebSiteViewController *tableReservation=[[WebSiteViewController alloc] initWithNibName:@"WebSiteViewController" bundle:nil];
            [tableReservation setWebString:[restaurentInfoDic objectForKey:@"domain"]];
            tableReservation.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:tableReservation animated:true completion:nil];
        }
        else
        {
            [MyCustomeClass alertMessage:[MyCustomeClass languageSelectedStringForKey:@"No website available in "] :[MyCustomeClass languageSelectedStringForKey:@"Restaurent"] :[MyCustomeClass languageSelectedStringForKey:@"OK"]];
        }
        
    }
    else if (indexPath.row==3)
    {
        
        if ([[restaurentInfoDic objectForKey:@"social_fb"] length]>0)
        {
            WebSiteViewController *tableReservation=[[WebSiteViewController alloc] initWithNibName:@"WebSiteViewController" bundle:nil];
            [tableReservation setWebString:[restaurentInfoDic objectForKey:@"social_fb"]];
            tableReservation.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

            [self presentViewController:tableReservation animated:true completion:nil];
        }
        else
        {
            [MyCustomeClass alertMessage:[MyCustomeClass languageSelectedStringForKey:@"No website available in "] :[MyCustomeClass languageSelectedStringForKey:@"Restaurent"] :[MyCustomeClass languageSelectedStringForKey:@"OK"]];
        }
        
    }
    else
    {
       
    }
}

#pragma mark - Menu Related all method list
- (id)initWithViewControllers:(NSArray *)viewControllers andMenuTitles:(NSArray *)menuTitles
{
    if (self = [super init])
    {
        NSAssert(self.viewControllers.count == self.menuTitles.count, @"There must be one and only one menu title corresponding to every view controller!");    // (1)
        NSMutableArray *tempVCs = [NSMutableArray arrayWithCapacity:viewControllers.count];
        
        self.menuTitles = [menuTitles copy];
        
        for (UIViewController *vc in viewControllers) // (2)
        {
            if (![vc isMemberOfClass:[UINavigationController class]])
            {
                UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:vc];
                navigation.navigationBarHidden=true;
                [tempVCs addObject:navigation];
            }
            else
            {
                [tempVCs addObject:vc];
            }
            //UIBarButtonItem *revealMenuBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(toggleMenuVisibility:)]; // (3)
            UIButton *menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
            menuButton.frame=CGRectMake(0, 0, 50, 50);
          //  [menuButton setBackgroundImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
            [menuButton addTarget:self action:@selector(toggleMenuVisibility:) forControlEvents:UIControlEventTouchUpInside];
            UIViewController *topVC = ((UINavigationController *)tempVCs.lastObject).topViewController;
            [topVC.view addSubview:menuButton];
        }
        self.viewControllers = [tempVCs copy];
    }
    return self;
}

- (void)toggleMenuVisibility:(id)sender // (9)
{
    self.isMenuVisible = !self.isMenuVisible;
    self.isMenuVisible =NO;
    //[self adjustContentFrameAccordingToMenuVisibility];
}


- (void)adjustContentFrameAccordingToMenuVisibility // (10)
{
    UIViewController *visibleViewController = self.viewControllers[self.indexOfVisibleController];
    CGSize size = visibleViewController.view.frame.size;
     //self.isMenuVisible = NO;
    if (!self.isMenuVisible)
    {
        if ([[rootDefault objectForKey:@"Email"] length]>0)
        {
            [UIView animateWithDuration:0.5 animations:^{
                visibleViewController.view.frame = CGRectMake(kExposedWidth, 0, size.width, size.height);
            }];
        }
        else
        {
            ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
            [self presentViewController:viewController animated:true completion:nil];
        }
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            visibleViewController.view.frame = CGRectMake(0, 0, size.width, size.height);
        }];
    }
}

- (void)replaceVisibleViewControllerWithViewControllerAtIndex:(NSInteger)index // (11)
{
    if (index == self.indexOfVisibleController) return;
    UIViewController *incomingViewController = self.viewControllers[index];
    incomingViewController.view.frame = [self offScreenFrame];
    UIViewController *outgoingViewController = self.viewControllers[self.indexOfVisibleController];
    CGRect visibleFrame = self.view.bounds;
    
    
    [outgoingViewController willMoveToParentViewController:nil]; // (12)
    
    [self addChildViewController:incomingViewController]; // (13)
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents]; // (14)
    [self transitionFromViewController:outgoingViewController // (15)
                      toViewController:incomingViewController
                              duration:0.5 options:0
                            animations:^{
                                outgoingViewController.view.frame = [self offScreenFrame];
                            }
     
                            completion:^(BOOL finished) {
                                [UIView animateWithDuration:0.5
                                                 animations:^{
                                                     [outgoingViewController.view removeFromSuperview];
                                                     [self.view addSubview:incomingViewController.view];
                                                     incomingViewController.view.frame = visibleFrame;
                                                     [[UIApplication sharedApplication] endIgnoringInteractionEvents]; // (16)
                                                 }];
                                [incomingViewController didMoveToParentViewController:self]; // (17)
                                [outgoingViewController removeFromParentViewController]; // (18)
                                self.isMenuVisible = NO;
                                self.indexOfVisibleController = index;
                            }];
}

- (CGRect)offScreenFrame
{
    return CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

-(IBAction)clickOProfileButton:(id)sender
{
   /* if([[rootDefault objectForKey:@"RootView"] isEqualToString:@"Login"])
    {
        ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [self presentViewController:viewController animated:true completion:nil];
    }
    else*/
    {
        //self.isMenuVisible = !self.isMenuVisible;
        //[self adjustContentFrameAccordingToMenuVisibility];
    }
}

-(void)gettingUserMounchPoints
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"munchPoints/getMemberPoints/memberId/%@",[rootDefault objectForKey:@"Member"]];
    NSLog(@"%@",postString);
    
    [helper gettingUserMounchPoints:postString];
}


-(void)gettingUserMounchPoints:(NSString *)response
{
    // NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSMutableArray *userMunchPoints=[[NSMutableArray alloc] init];
    //offerInfo
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
        userMunchPoints =[dataDic objectForKey:@"pointInfo"];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"" :1.0];
    }
    
    
    if (userMunchPoints.count>0)
    {
        munchPoint=[[userMunchPoints objectAtIndex:0] objectForKey:@"points"];

        if (munchPoint.length<=0)
        {
            munchPoint=@"No points";
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setValue:munchPoint forKey:@"points"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [rootTableView reloadData];
    }
   
   
}

-(void)restaurentAddressRequest
{
   
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    
    NSString *postData=[NSString stringWithFormat:@"%@",ciboRestaurantId];
    NSLog(@"%@",postData);
    [helper restaurentAddress:postData];
}
-(void)restaurentAddress:(NSString *)response
{
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
        NSMutableArray *infoArray=[[NSMutableArray alloc] init];
        infoArray= [dataDic objectForKey:@"restInfo"];
        restaurentInfoDic =[[NSMutableDictionary alloc] init];
        restaurentInfoDic =[infoArray objectAtIndex:0];
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Successfully done."] :1.00];
        
    }
}


-(void)gettingFail:(NSString *)error
{
    NSLog(@"%@",error);
    [MyCustomeClass SVProgressMessageDismissWithSuccess:@"" :1.0];

}
@end
