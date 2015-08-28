//
//  AlbumDescriptionViewController.h
//  Cibo
//
//  Created by mithun ravi on 18/05/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomeClass.h"
#import "UIImageView+WebCache.h"
#import "AFOpenFlowView.h"



@interface AlbumDescriptionViewController : UIViewController<AFOpenFlowViewDelegate,AFOpenFlowViewDataSource>
{
    NSUserDefaults *albumDefault;
    NSOperationQueue *loadImageOpreteion;
    IBOutlet UILabel *lblTitle;

}
@property (nonatomic, strong) IBOutlet UIImageView *zoomImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLable;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UIImage *imageFromServer;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) IBOutlet UIButton *backButton;

@property (nonatomic, strong) NSMutableArray *coverImageArray,*results;
@property (nonatomic, strong) IBOutlet UIView *coverflowView;
@property (nonatomic, strong) UIImageView *localImageView;


-(IBAction)clickONBackButton:(id)sender;

@end
