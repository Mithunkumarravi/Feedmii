//
//  AlbumViewController.h
//  Cibo
//
//  Created by mithun ravi on 20/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumCell.h"

#import "AppDelegate.h"
#import "MyCustomeClass.h"
#import "WebServiceHelper.h"
#import "AlbumDescriptionViewController.h"
#import "AlbumCell.h"
#import "AlbumViewCell.h"

@interface AlbumViewController : UIViewController<WebServiceHelperDelegate,UIPickerViewDataSource,UIPickerViewDelegate, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    AppDelegate *appDelegate;
    NSUserDefaults *albumDefault;
    ///////////////////////////
    NSArray * _orderedImageNames;
    NSArray * _imageNames;
    NSUInteger _cellType;
    UIPopoverController * _menuPopoverController;
    ///////////////////////////
    IBOutlet UICollectionViewFlowLayout *flowLayout;
    UIView *timeBackgroundView;
    IBOutlet UILabel *lblTitle;
}

//@property (nonatomic, strong) IBOutlet UICollectionView *albumCollectionView;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *results,*gallaryCategoryArray;
@property (nonatomic, strong) IBOutlet UILabel *titleLable;
@property (nonatomic, strong) NSString *categoryID;
@property (nonatomic, strong) NSMutableArray *gallaryArray;
@property (nonatomic, strong) IBOutlet UILabel *subtitleLabel;

///////

@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIPickerView *pickerView;
////////////////
@property (nonatomic, strong) UIImageView *localImageView;


////////////////

-(IBAction)clickONGalleryCategoryButton:(id)sender;


@end
