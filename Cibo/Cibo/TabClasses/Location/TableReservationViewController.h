//
//  TableReservationViewController.h
//  Cibo
//
//  Created by mithun ravi on 21/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomeClass.h"
#import "WebServiceHelper.h"

@class AppDelegate;
@interface TableReservationViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,WebServiceHelperDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>
{
    AppDelegate *appDelegate;
    NSUserDefaults *tableReservationDefault;
    
    IBOutlet UIPickerView *pickerPerson;
    IBOutlet UIPickerView *pickerTimeSlot;
    IBOutlet UIPickerView *pickerRoomSelect;
    IBOutlet UIPickerView *pickerMobile;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIPickerView *pickerTable;
    
    IBOutlet UILabel *personLabel;
    IBOutlet UILabel *roomLabel;
    IBOutlet UILabel *timeslotLabel;
    IBOutlet UILabel *mobileLabel;
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *tableLabel;
    IBOutlet UILabel *yearMonthLabel;
    IBOutlet UIView *timeDataView;
    
    NSString *dataPickerString;
    NSString *selectedRoomID,*selectedTime,*selectedDate,*selectedMobile,*selectedPerson,*selectedTableID;
    IBOutlet UICollectionView *collectionviewNummer_Person, *dateCollectionView, *timeSlotCollectioonView;
    IBOutlet UICollectionView *roomCollectionView;
    int currentMonth;
    int yearIndex;
    NSString *countryCode;
    NSString *tableIdString;
    NSString *comment;
    

}

@property (nonatomic, strong) NSMutableArray *timeArray,*roomInfoArray,*timeSlotArray,*personArray,*arrDate,*tableArray,*mobileArray;
@property (nonatomic,strong) NSMutableArray *monthArray,*yearArray;


@end
