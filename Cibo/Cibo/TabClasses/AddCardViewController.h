//
//  AddCardViewController.h
//  Boldo
//
//  Created by mithun ravi on 03/07/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomeClass.h"

@interface AddCardViewController : UIViewController
{
    IBOutlet UITextField *cardNumber;
    IBOutlet UITextField *expDate;
    IBOutlet UITextField *cvvNumber;
    IBOutlet UITextField *name;
    IBOutlet UILabel *lblTitle;
    
}
@property (nonatomic, strong) NSString *editString;

@end
