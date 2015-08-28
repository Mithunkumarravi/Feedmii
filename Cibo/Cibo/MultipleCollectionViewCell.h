//
//  MultipleCollectionViewCell.h
//  Reataurant Cibo
//
//  Created by mithun ravi on 13/01/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultipleCollectionViewCell : UICollectionViewCell
{
    
}

@property (nonatomic, strong) IBOutlet UIImageView *logoImageView;
@property (nonatomic, strong) IBOutlet UIButton *likeButton,*likeClickedButton;
@property (nonatomic, strong) IBOutlet UILabel *restName;
@property (nonatomic, strong) IBOutlet UILabel *likeLabel;


@end
