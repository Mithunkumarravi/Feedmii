//
//  TableReservationViewController.m
//  Cibo
//
//  Created by mithun ravi on 21/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "TableReservationViewController.h"
#import "PersonCollectionViewCell.h"
#import "TimeSlotCollectionViewCell.h"

@interface TableReservationViewController ()

@end

@implementation TableReservationViewController

@synthesize timeArray;
@synthesize roomInfoArray,timeSlotArray;
@synthesize personArray;

@synthesize tableArray;
@synthesize mobileArray;
@synthesize arrDate;
@synthesize monthArray,yearArray;

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
    appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    tableReservationDefault=[NSUserDefaults standardUserDefaults];
    timeArray = [[NSMutableArray alloc] init];
    roomInfoArray=[[NSMutableArray alloc]init];
    timeSlotArray=[[NSMutableArray alloc]init];
    tableArray=[[NSMutableArray alloc] init];
    
    personArray=[[NSMutableArray alloc] init];
    arrDate = [[NSMutableArray alloc] init];
    arrDate = [[NSMutableArray alloc] init];
    yearArray =[[NSMutableArray alloc] init];

    for (int i = 0 ; i<12; i++)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if (i == 1)
        {
            [dic setValue:@"Yes" forKey:@"Selected"];
        }
        else
        {
            [dic setValue:@"No" forKey:@"Selected"];
        }
        [dic setValue:[NSString stringWithFormat:@"%d",(i+1)] forKey:@"name"];
        [personArray addObject:dic];
    }
    personLabel.text = [[personArray objectAtIndex:1] objectForKey:@"name"];
    selectedPerson = [[personArray objectAtIndex:1] objectForKey:@"name"];
    
    for (int i= 0; i<200; i++)
    {
        int year =2015;
        [yearArray addObject:[NSString stringWithFormat:@"%d",(year+i)]];
    }
    
    currentMonth = [[MyCustomeClass currentMonthInInteger:[NSDate date]]intValue];
    [dateCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[self setTimeAndMonth:currentMonth] inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];

    
  
    monthArray=[[NSMutableArray alloc] initWithObjects:@"JAN",@"FEB",@"MAR",@"API",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC", nil];

    
    mobileArray = [[NSMutableArray alloc] initWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"], nil];
    selectedMobile = [mobileArray objectAtIndex:0];
   // personLabel.text=@"PERSONER";
    roomLabel.text=@"Room";
    timeslotLabel.text=@"Time";
    //dateLabel.text=@"Date";
    //tableLabel.text=@"Table";
    //mobileLabel.text =@"Mobile";
   
    
    personLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [personLabel setFont: [personLabel.font fontWithSize: 12.0]];

    roomLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [roomLabel setFont: [roomLabel.font fontWithSize: 12.0]];

    timeslotLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [timeslotLabel setFont: [timeslotLabel.font fontWithSize: 12.0]];

    dateLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [dateLabel setFont: [dateLabel.font fontWithSize: 12.0]];

    mobileLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [mobileLabel setFont: [mobileLabel.font fontWithSize: 12.0]];

    
    [self gettingRoomRequest];
    [datePicker setMinimumDate:[NSDate date]];
    ////////////////////////////////////////////////////////////////////////NAVEEN
    
    UINib *cellNib = [UINib nibWithNibName:@"PersonCollectionViewCell" bundle:nil];
    [collectionviewNummer_Person registerNib:cellNib forCellWithReuseIdentifier:@"PersonCollectionViewCell"];
    [dateCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"PersonCollectionViewCell"];
    
    UINib *cellNib2 = [UINib nibWithNibName:@"TimeSlotCollectionViewCell" bundle:nil];
    [timeSlotCollectioonView registerNib:cellNib2 forCellWithReuseIdentifier:@"TimeSlotCollectionViewCell"];
    
    [roomCollectionView registerNib:cellNib2 forCellWithReuseIdentifier:@"TimeSlotCollectionViewCell"];

    collectionviewNummer_Person.pagingEnabled = YES;
    [self currentMonth];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
   // phoneNumberText.text = strValue != nil ? strValue : @"No Value";
    
    NSString *str = @"+";
    NSString* strValue1 =  [defaults objectForKey:@"countrycode"];
    NSString *foo = strValue1;
    NSString *trimmed = [foo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    str = [str stringByAppendingString:trimmed];
    countryCode = str;
}
-(int)setTimeAndMonth:(int)monthInINT
{
    int scrollCount = 0;
    [arrDate removeAllObjects];
    for (int i =1; i<32; i++)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"No" forKey:@"Selected"];
        int currentDate = [[MyCustomeClass currentDayInInteger:[NSDate date]] intValue];
        int currentMonth1 = [[MyCustomeClass currentMonthInInteger:[NSDate date]]intValue];

        
        if (currentMonth1==monthInINT)
        {
            if (currentDate==i)
            {
                [dic setValue:@"Yes" forKey:@"Selected"];
                
            }
            if (i<currentDate)
            {
                [dic setValue:@"YesNo" forKey:@"Selected"];
            }
        }
        
        [dic setValue:[NSString stringWithFormat:@"%d",(i)] forKey:@"name"];
        
        if (monthInINT==2 )
        {
            [arrDate addObject:dic];

            if ([[yearArray objectAtIndex:yearIndex] intValue]%4==0)
            {
                if (i==29)
                    i=4000;
            }
            else
            {
                if (i==28)
                    i=4000;
            }
           
        }
        else if (monthInINT == 1 || monthInINT == 3 || monthInINT == 5 || monthInINT == 7 || monthInINT == 8 || monthInINT == 10 || monthInINT == 12)
        {
            [arrDate addObject:dic];
            if (i==31)
                i=4000;
        }
        else
        {
            [arrDate addObject:dic];
            if (i==30)
                i=4000;
        }
        if (currentMonth1==monthInINT)
        {
            if (currentDate==i)
            {
                // NSString *strCurrentYear = [MyCustomeClass currentYearInInteger:[NSDate date]];
                currentMonth1 = [[MyCustomeClass currentMonthInInteger:[NSDate date]]intValue];
                
                dateLabel.text = [NSString stringWithFormat:@"%@-%d-%@",[yearArray objectAtIndex:yearIndex],currentMonth,[[arrDate objectAtIndex:(i-1)] objectForKey:@"name"]];
                selectedDate = dateLabel.text;
                scrollCount =(i-1);
            }
        }
    }
    return scrollCount;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (appDelegate.orderSelected)
    {
        timeDataView.hidden=YES;
        tableLabel.text=@"BESTIL";
        NSString *formattedDate1;
        NSDateFormatter *dateFormatter1 =[[NSDateFormatter alloc]init];
        [dateFormatter1 setDateFormat:@"hh:mm:ss a"];
        formattedDate1 = [dateFormatter1 stringFromDate:[NSDate date]];
        dateLabel.text = formattedDate1;
    }
    else
    {
        timeDataView.hidden=NO;
        appDelegate.orderSelected=NO;
    }
    
    CGAffineTransform t0 = CGAffineTransformMakeTranslation (0, pickerTimeSlot.bounds.size.height/2);
    CGAffineTransform s0 = CGAffineTransformMakeScale (1.0, 0.5);
    CGAffineTransform t1 = CGAffineTransformMakeTranslation (0, -pickerTimeSlot.bounds.size.height/2);
    pickerTimeSlot.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
    pickerRoomSelect.transform = CGAffineTransformConcat (t0, CGAffineTransformConcat(s0, t1));
    datePicker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
    pickerMobile.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));

    CGAffineTransform t00 = CGAffineTransformMakeTranslation (0, pickerPerson.bounds.size.height/2);
    CGAffineTransform s00 = CGAffineTransformMakeScale (1.0, 0.5);
    CGAffineTransform t11 = CGAffineTransformMakeTranslation (0, -pickerPerson.bounds.size.height/2);
    pickerPerson.transform = CGAffineTransformConcat(t00, CGAffineTransformConcat(s00, t11));
    pickerTable.transform = CGAffineTransformConcat(t00, CGAffineTransformConcat(s00, t11));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)currentMonth
{
    currentMonth = [MyCustomeClass getCurrentMonthInNumber];
    yearIndex=0;
    yearMonthLabel.text = [NSString stringWithFormat:@"%@ %@",[monthArray objectAtIndex:currentMonth-1],[yearArray objectAtIndex:yearIndex]];
    
}
#pragma mark - Button action methods
-(IBAction)clickOnHomeButton:(id)sender
{
    UIApplication *application=nil;
    NSDictionary *dic=nil;
    [tableReservationDefault setValue:@"Home" forKey:@"RootView"];
    [tableReservationDefault setValue:@"Home" forKey:@"Logout"];
    
    [appDelegate application:application didFinishLaunchingWithOptions:dic];
}

-(IBAction)clickONBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:true];
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - Date Picker methods
-(IBAction)clickOnTableBooking:(id)sender
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Booking..."]];
   
    if ([personLabel.text isEqualToString:@"PERSONER"])
    {
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please select no of person" ] :1.0];
    }
    else if ([roomLabel.text isEqualToString:@"Room"])
    {
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please select any room." ] :1.0];
    }
    else if ([timeslotLabel.text isEqualToString:@"Time"])
    {
        if (appDelegate.orderSelected)
        {
            [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please choose table."] :1.0];
        }
        else
        {
            [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please select time"] :1.0];
        }
    }
    else if ([dateLabel.text isEqualToString:@"Date"])
    {
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please select no of person"] :1.0];
    }
    else
    {
        [self BookingTable];
    }
}


#pragma mark - Webservics Request classes
-(void)BookingTable
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *url=@"";
    NSString *postData=@"";
    if (appDelegate.orderSelected)
    {
        
        NSString *formattedDate;
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        formattedDate = [dateFormatter stringFromDate:date];
        
        NSString *formattedDate1;
        NSDateFormatter *dateFormatter1 =[[NSDateFormatter alloc]init];
        [dateFormatter1 setDateFormat:@"hh:mm:ss a"];
        formattedDate1 = [dateFormatter1 stringFromDate:date];
        
        selectedMobile = [[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"];

        url=[NSString stringWithFormat:@"http://ciboapp.com/admin/newdmenuapi/tableRes/reserveTable/restId/%@",[tableReservationDefault objectForKey:@"Restaurantid"]];
        
        postData=[NSString stringWithFormat:@"roomId=%@&name=%@&email=%@&phone=%@&noOfPeople=%@&time=%@&date=%@&tableId=%@",selectedRoomID,[tableReservationDefault objectForKey:@"Username"],[tableReservationDefault objectForKey:@"Email"],selectedMobile,selectedPerson,formattedDate1,formattedDate,tableIdString];
    }
    else
    {
        url=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/tableRes/reserveTable/restId/%@/memberId/%@",[tableReservationDefault objectForKey:@"Restaurantid"],[tableReservationDefault objectForKey:@"Member"]];
        postData=[NSString stringWithFormat:@"roomId=%@&name=%@&email=%@&phone=%@&noOfPeople=%@&time=%@&date=%@&countrycode=%@&comment=%@",selectedRoomID,[tableReservationDefault objectForKey:@"Username"],[tableReservationDefault objectForKey:@"Email"],selectedMobile,selectedPerson,selectedTime,selectedDate,countryCode,comment];
    }
     NSLog(@"%@",postData);
    [helper tableBooking:url :postData];
}

#pragma mark - Webservics Response classes
-(void)timeSlotRequest
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postData=[NSString stringWithFormat:@"%@",[tableReservationDefault objectForKey:@"Restaurantid"]];
    NSLog(@"%@",postData);
    [helper timeSlotResponse:postData];
}

-(void)gettingRoomRequest
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Data Fetching..."]];
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postData=[NSString stringWithFormat:@"%@",[tableReservationDefault objectForKey:@"Restaurantid"]];
    NSLog(@"%@",postData);
    [helper gettingRoom:postData];
}
-(void)viewTableRequest
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Getting table..."]];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postData=[NSString stringWithFormat:@"tableRes/viewRoomTables/restId/%@/roomId/%@",[tableReservationDefault objectForKey:@"Restaurantid"],selectedRoomID];
    [helper viewTableInTheRoom:postData];
}

-(void)gettingRoom:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init] ;
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"FAIL"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Some connection issue."] :1.00];
    }
    else
    {
        NSArray *roomInfoArrayLocal= [dataDic objectForKey:@"roomInfo"];
        NSLog(@"%@",roomInfoArrayLocal);
        if (roomInfoArrayLocal.count >0)
        {
            [roomInfoArray removeAllObjects];
            for (int i = 0 ; i<roomInfoArrayLocal.count; i++)
            {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:@"No" forKey:@"Selected"];
                [dic setValue:[roomInfoArrayLocal objectAtIndex:i] forKey:@"name"];
                [roomInfoArray addObject:dic];
            }
            
            [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Done." :0.5];
        }
        else
        {
            [MyCustomeClass alertMessage:[MyCustomeClass languageSelectedStringForKey:@"No Room available"] :[MyCustomeClass languageSelectedStringForKey:@"in this restaurent"] :[MyCustomeClass languageSelectedStringForKey:@"OK"]];
        }
        [roomCollectionView reloadData];
    }
}

-(void)timeSlotResponse:(NSString *)response
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
        NSMutableArray *localDataArray=[[NSMutableArray alloc] init];
        localDataArray=[dataDic objectForKey:@"timeslotsInfo"];
        if (localDataArray.count >0)
        {
            [timeSlotArray removeAllObjects];
            for (int i = 0 ; i<localDataArray.count; i++)
            {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:@"No" forKey:@"Selected"];
                [dic setValue:[localDataArray objectAtIndex:i] forKey:@"name"];
                [timeSlotArray addObject:dic];
            }
            [self viewTableRequest];
        }
        else
        {
            [MyCustomeClass alertMessage:[MyCustomeClass languageSelectedStringForKey:@"No Room available"] :[MyCustomeClass languageSelectedStringForKey:@"in this restaurent" ]:[MyCustomeClass languageSelectedStringForKey:@"OK"]];
        }
    }
    [timeSlotCollectioonView reloadData];
}

-(void)viewTableInTheRoom:(NSString *)response
{
    NSLog(@"%@",response);
    NSMutableDictionary *tableDataDic= [MyCustomeClass jsonDictionary:response];
    NSMutableArray *localDataArray =[[NSMutableArray alloc] init];
    localDataArray=[tableDataDic objectForKey:@"roomTableInfo"];
    
    if (localDataArray.count>0)
    {
        [tableArray removeAllObjects];
        for (int i = 0 ; i<localDataArray.count; i++)
        {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:@"No" forKey:@"Selected"];
            [dic setValue:[localDataArray objectAtIndex:i] forKey:@"name"];
            [tableArray addObject:dic];
        }
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"table set." :1.0];
        [timeSlotCollectioonView reloadData];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"No Table available on this time slot" :1.0];
    }
}


-(void)tableBooking:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Table successfully booked."] :1.0];
        
        if (appDelegate.orderSelected)
        {
            appDelegate.bookedTable=[dataDic objectForKey:@"booking_id"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"Your Order sent to kitchen."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            appDelegate.bookedTable=[dataDic objectForKey:@"Table booked."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"Thank you For Booking, you will received confirmation soon."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
        [self.navigationController popViewControllerAnimated:true];
        [self dismissViewControllerAnimated:true completion:nil];
    }
    else
    {
        if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"TABLE LEFT"])
        {
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Person is over from table limit."] :2.0];
        }
        else
        {
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Please try again."] :1.0];
        }
    }
}


-(void)gettingFail:(NSString*)error
{
    NSLog(@"%@",error);
    [MyCustomeClass SVProgressMessageDismissWithSuccess:error :1.00];
}


//========================

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==collectionviewNummer_Person)
    {
        return personArray.count;
    }
    else if (collectionView==dateCollectionView)
    {
        return arrDate.count;
    }
    else if (collectionView==roomCollectionView)
    {
        return roomInfoArray.count;
    }
    else
    {
        if (appDelegate.orderSelected)
        {
            return tableArray.count;
        }
        else
        {
            return timeSlotArray.count;
        }
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==collectionviewNummer_Person)
    {
        PersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PersonCollectionViewCell" forIndexPath:indexPath];

       
        cell.lblNum_Person.text   = [[personArray objectAtIndex:indexPath.row ] objectForKey:@"name"];
        cell.boldLabel.text = [[personArray objectAtIndex:indexPath.row ] objectForKey:@"name"];
        cell.lblNum_Person.hidden=YES;
        cell.boldLabel.hidden=YES;
        
        if ([[[personArray objectAtIndex:indexPath.row ] objectForKey:@"Selected"] isEqualToString:@"Yes"])
        {
            cell.lblNum_Person.hidden=YES;
            cell.boldLabel.hidden=NO;
        }
        else
        {
            cell.lblNum_Person.hidden=NO;
            cell.boldLabel.hidden=YES;
        }
        return cell;
    }
    else if (collectionView==dateCollectionView)
    {
        PersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PersonCollectionViewCell" forIndexPath:indexPath];
        
        cell.lblNum_Person.text   = [[arrDate objectAtIndex:indexPath.row ] objectForKey:@"name"];
        cell.boldLabel.text = [[arrDate objectAtIndex:indexPath.row ] objectForKey:@"name"];
        
        
        if ([[[arrDate objectAtIndex:indexPath.row ] objectForKey:@"Selected"] isEqualToString:@"Yes"])
        {
            cell.lblNum_Person.hidden=YES;
            cell.boldLabel.hidden=NO;
        }
        else
        {
            cell.lblNum_Person.hidden=NO;
            cell.boldLabel.hidden=YES;
        }
        
        if ([[[arrDate objectAtIndex:indexPath.row ] objectForKey:@"Selected"] isEqualToString:@"YesNo"])
        {
            cell.lblNum_Person.hidden=NO;
            cell.lblNum_Person.textColor = [UIColor grayColor];
            cell.boldLabel.hidden=YES;
        }
        else
        {
            cell.lblNum_Person.textColor = [UIColor blackColor];
            
        }
        return cell;
    }
    else if (collectionView==timeSlotCollectioonView)
    {
        if (appDelegate.orderSelected)
        {
            TimeSlotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TimeSlotCollectionViewCell" forIndexPath:indexPath];
            
            NSDictionary *tempDic = [[tableArray objectAtIndex:indexPath.row] objectForKey:@"name"];
            
            cell.lblTimeSlot.text   = [NSString stringWithFormat:@"%@ : max_limit:%@",[tempDic objectForKey:@"tname"],[tempDic objectForKey:@"max_limit"]];
            cell.boldLabel.text = [NSString stringWithFormat:@"%@ : max_limit:%@",[tempDic objectForKey:@"tname"],[tempDic objectForKey:@"max_limit"]];
            
            if ([[[tableArray objectAtIndex:indexPath.row ] objectForKey:@"Selected"] isEqualToString:@"Yes"])
            {
                cell.lblTimeSlot.hidden=YES;
                cell.boldLabel.hidden=NO;
            }
            else
            {
                cell.lblTimeSlot.hidden=NO;
                cell.boldLabel.hidden=YES;
            }
            
            [MyCustomeClass drawBorder:cell.lblTimeSlot];
            [MyCustomeClass drawBorder:cell.boldLabel];
            cell.lblTimeSlot.font=[UIFont fontWithName:FONT_Ragular size:14.0];
            [cell.lblTimeSlot setFont: [cell.lblTimeSlot.font fontWithSize: 14.0]];
            cell.boldLabel.font=[UIFont fontWithName:FONT_Ragular size:16.0];
            [cell.boldLabel setFont: [cell.boldLabel.font fontWithSize: 16.0]];
            return cell;
        }
        else
        {
            TimeSlotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TimeSlotCollectionViewCell" forIndexPath:indexPath];
            NSDictionary *serveArray = [[timeSlotArray objectAtIndex:indexPath.row ] objectForKey:@"name"];
            cell.lblTimeSlot.text   = [serveArray objectForKey:@"time_slot"] ;
            cell.boldLabel.text =[serveArray objectForKey:@"time_slot"] ;;
            
            if ([[[timeSlotArray objectAtIndex:indexPath.row ] objectForKey:@"Selected"] isEqualToString:@"Yes"])
            {
                cell.lblTimeSlot.hidden=YES;
                cell.boldLabel.hidden=NO;
            }
            else
            {
                cell.lblTimeSlot.hidden=NO;
                cell.boldLabel.hidden=YES;
            }
            return cell;
        }
    }
    else if (collectionView==roomCollectionView)
    {
        TimeSlotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TimeSlotCollectionViewCell" forIndexPath:indexPath];
       
        NSDictionary *serveArray = [[roomInfoArray objectAtIndex:indexPath.row ] objectForKey:@"name"];
   

        cell.lblTimeSlot.text   = [serveArray objectForKey:@"name"] ;
        cell.boldLabel.text =[serveArray objectForKey:@"name"] ;;
        if ([[[roomInfoArray objectAtIndex:indexPath.row ] objectForKey:@"Selected"] isEqualToString:@"Yes"])
        {
            
            cell.lblTimeSlot.hidden=YES;
            cell.boldLabel.hidden=NO;
        }
        else
        {
            cell.lblTimeSlot.hidden=NO;
            cell.boldLabel.hidden=YES;
        }
        
        return cell;
    }
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==collectionviewNummer_Person)
    {
        NSMutableDictionary *dataDic =[[NSMutableDictionary alloc] init];
        [dataDic setValue:[[personArray objectAtIndex:indexPath.row ] objectForKey:@"name"] forKey:@"name"];
        [dataDic setValue:@"Yes" forKey:@"Selected"];

        for (int i=0; i<personArray.count; i++)
        {
            if ([[[personArray objectAtIndex:i] objectForKey:@"Selected"] isEqualToString:@"Yes"])
            {
                NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
                [dic setValue:[[personArray objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
                [dic setValue:@"No" forKey:@"Selected"];
                [personArray removeObjectAtIndex:i];
                [personArray insertObject:dic atIndex:i];
            }
        }
        [personArray removeObjectAtIndex:indexPath.row];
        [personArray insertObject:dataDic atIndex:indexPath.row];
        [collectionviewNummer_Person reloadData];
        personLabel.text = [[personArray objectAtIndex:indexPath.row ] objectForKey:@"name"];
        selectedPerson = [[personArray objectAtIndex:indexPath.row ] objectForKey:@"name"];

    }
    else if (collectionView==timeSlotCollectioonView)
    {
        NSMutableDictionary *dataDic =[[NSMutableDictionary alloc] init];

        if (appDelegate.orderSelected)
        {
            [dataDic setValue:[[tableArray objectAtIndex:indexPath.row ] objectForKey:@"name"] forKey:@"name"];
            [dataDic setValue:@"Yes" forKey:@"Selected"];
            
            for (int i=0; i<tableArray.count; i++)
            {
                if ([[[tableArray objectAtIndex:i] objectForKey:@"Selected"] isEqualToString:@"Yes"])
                {
                    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
                    [dic setValue:[[tableArray objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
                    [dic setValue:@"No" forKey:@"Selected"];
                    [tableArray removeObjectAtIndex:i];
                    [tableArray insertObject:dic atIndex:i];
                }
            }
            
            [tableArray removeObjectAtIndex:indexPath.row];
            [tableArray insertObject:dataDic atIndex:indexPath.row];
            [timeSlotCollectioonView reloadData];
            
            NSDictionary *serveDic = [[tableArray objectAtIndex:indexPath.row ] objectForKey:@"name"];
            tableLabel.text = [NSString stringWithFormat:@"%@ : max_limit:%@",[serveDic objectForKey:@"tname"],[serveDic objectForKey:@"max_limit"]];
            tableIdString = [serveDic objectForKey:@"table_id"];
            timeslotLabel.text = tableIdString;
        }
        else
        {
            [dataDic setValue:[[timeSlotArray objectAtIndex:indexPath.row ] objectForKey:@"name"] forKey:@"name"];
            [dataDic setValue:@"Yes" forKey:@"Selected"];
            
            for (int i=0; i<timeSlotArray.count; i++)
            {
                if ([[[timeSlotArray objectAtIndex:i] objectForKey:@"Selected"] isEqualToString:@"Yes"])
                {
                    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
                    [dic setValue:[[timeSlotArray objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
                    [dic setValue:@"No" forKey:@"Selected"];
                    [timeSlotArray removeObjectAtIndex:i];
                    [timeSlotArray insertObject:dic atIndex:i];
                }
            }
            [timeSlotArray removeObjectAtIndex:indexPath.row];
            [timeSlotArray insertObject:dataDic atIndex:indexPath.row];
            [timeSlotCollectioonView reloadData];
            NSDictionary *serveDic = [[timeSlotArray objectAtIndex:indexPath.row ] objectForKey:@"name"];
            
            selectedTime = [serveDic objectForKey:@"time_slot"];
            timeslotLabel.text=[serveDic objectForKey:@"time_slot"];
        }
    }
    else if (collectionView==dateCollectionView)
    {
        int currentDate = [[MyCustomeClass currentDayInInteger:[NSDate date]] intValue];
        int currentMonth1 = [[MyCustomeClass currentMonthInInteger:[NSDate date]]intValue];

        if (currentMonth1!=currentMonth)
        {
            NSMutableDictionary *dataDic =[[NSMutableDictionary alloc] init];
            
            [dataDic setValue:[[arrDate objectAtIndex:indexPath.row ] objectForKey:@"name"] forKey:@"name"];
            
            [dataDic setValue:@"Yes" forKey:@"Selected"];
            
            for (int i=0; i<arrDate.count; i++)
            {
                
                if ([[[arrDate objectAtIndex:i] objectForKey:@"Selected"] isEqualToString:@"Yes"])
                {
                    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
                    
                    [dic setValue:@"No" forKey:@"Selected"];
                    [dic setValue:[[arrDate objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
                    [arrDate removeObjectAtIndex:i];
                    [arrDate insertObject:dic atIndex:i];
                }
                
            }
            [arrDate removeObjectAtIndex:indexPath.row];
            [arrDate insertObject:dataDic atIndex:indexPath.row];
            [dateCollectionView reloadData];
            
            dateLabel.text = [NSString stringWithFormat:@"%@-%d-%@",[yearArray objectAtIndex:yearIndex],currentMonth,[[arrDate objectAtIndex:indexPath.row ] objectForKey:@"name"]];
            selectedDate = dateLabel.text;
            [dateCollectionView reloadData];
        }
        else
        {
            if ((int)indexPath.row>=currentDate)
            {
                NSMutableDictionary *dataDic =[[NSMutableDictionary alloc] init];
                
                [dataDic setValue:[[arrDate objectAtIndex:indexPath.row ] objectForKey:@"name"] forKey:@"name"];
                
                [dataDic setValue:@"Yes" forKey:@"Selected"];
                
                for (int i=0; i<arrDate.count; i++)
                {
                    
                    if ([[[arrDate objectAtIndex:i] objectForKey:@"Selected"] isEqualToString:@"Yes"])
                    {
                        NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
                        
                        [dic setValue:@"No" forKey:@"Selected"];
                        if (i<currentDate)
                        {
                            [dic setValue:@"YesNo" forKey:@"Selected"];
                        }
                        
                        [dic setValue:[[arrDate objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
                        [arrDate removeObjectAtIndex:i];
                        [arrDate insertObject:dic atIndex:i];
                    }
                    
                }
                [arrDate removeObjectAtIndex:indexPath.row];
                [arrDate insertObject:dataDic atIndex:indexPath.row];
                [dateCollectionView reloadData];
                
                dateLabel.text = [NSString stringWithFormat:@"%@-%d-%@",[yearArray objectAtIndex:yearIndex],currentMonth,[[arrDate objectAtIndex:indexPath.row ] objectForKey:@"name"]];
                selectedDate = dateLabel.text;
                [dateCollectionView reloadData];
            }
            else
            {
                [[[UIAlertView alloc] initWithTitle:@"Alet !" message:@"You can not choose past date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }

        }
    }
    else if (collectionView==roomCollectionView)
    {
        NSMutableDictionary *dataDic =[[NSMutableDictionary alloc] init];
        [dataDic setValue:[[roomInfoArray objectAtIndex:indexPath.row ] objectForKey:@"name"] forKey:@"name"];
        [dataDic setValue:@"Yes" forKey:@"Selected"];
        
        for (int i=0; i<roomInfoArray.count; i++)
        {
            if ([[[roomInfoArray objectAtIndex:i] objectForKey:@"Selected"] isEqualToString:@"Yes"])
            {
                NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
                [dic setValue:[[roomInfoArray objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
                [dic setValue:@"No" forKey:@"Selected"];
                [roomInfoArray removeObjectAtIndex:i];
                [roomInfoArray insertObject:dic atIndex:i];
            }
        }
        [roomInfoArray removeObjectAtIndex:indexPath.row];
        [roomInfoArray insertObject:dataDic atIndex:indexPath.row];
        [roomCollectionView reloadData];
        NSDictionary *serveDic = [[roomInfoArray objectAtIndex:indexPath.row ] objectForKey:@"name"];
        selectedRoomID = [serveDic objectForKey:@"room_id"];
        roomLabel.text = [serveDic objectForKey:@"name"] ;;

        if (appDelegate.orderSelected)
        {
            [self viewTableRequest];
        }
        else
        {
            [self timeSlotRequest];

        }

    }//roomCollectionView
    
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(IBAction)clickOnNextmonth:(id)sender
{
    currentMonth++;
    if (currentMonth>12)
    {
        currentMonth = 1;
        yearIndex++;
    }
    [self setTimeAndMonth:currentMonth];

    yearMonthLabel.text = [NSString stringWithFormat:@"%@ %@",[monthArray objectAtIndex:currentMonth-1],[yearArray objectAtIndex:yearIndex]];
    [dateCollectionView reloadData];
}
-(IBAction)clickOnpreviewsMonth:(id)sender
{
    currentMonth--;
    if (currentMonth<1)
    {
        currentMonth = 12;
        yearIndex--;
        if (yearIndex<0)
        {
            yearIndex=0;
        }
    }
    
    [self setTimeAndMonth:currentMonth];
    if (yearIndex==0)
    {
        if (currentMonth<[MyCustomeClass getCurrentMonthInNumber])
        {
            currentMonth = [MyCustomeClass getCurrentMonthInNumber];
            return;
        }
    }
    yearMonthLabel.text = [NSString stringWithFormat:@"%@ %@",[monthArray objectAtIndex:currentMonth-1],[yearArray objectAtIndex:yearIndex]];
    [dateCollectionView reloadData];

}

-(IBAction)enterCommantAlert:(id)sender
{
    UIAlertView *passwordAlertView = [[UIAlertView alloc] initWithTitle:@"KOMMENTR" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
    [passwordAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [passwordAlertView show];
    
}

#pragma mark - Alert View delegate method
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Send"])
    {
        UITextField *username = [alertView textFieldAtIndex:0];
        comment = username.text;
    }
}


@end
