//
//  AlbumDescriptionViewController.m
//  Cibo
//
//  Created by mithun ravi on 18/05/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "AlbumDescriptionViewController.h"

@interface AlbumDescriptionViewController ()

@end

@implementation AlbumDescriptionViewController
@synthesize zoomImageView;
@synthesize titleLable;
@synthesize imageName;
@synthesize imageFromServer;
@synthesize imageUrl;
@synthesize backButton;
@synthesize coverImageArray;
@synthesize coverflowView;
@synthesize localImageView;
@synthesize results;

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
    
    titleLable.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [titleLable setFont: [titleLable.font fontWithSize: 20.0]];

    lblTitle.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblTitle setFont: [lblTitle.font fontWithSize: 12.0]];



    titleLable.text=imageName;
    localImageView=[[UIImageView alloc] init];
    albumDefault=[NSUserDefaults standardUserDefaults];
    
    if (IS_IPHONE5)
    {
        zoomImageView.frame=CGRectMake(0, 44, 320, 504-49);
    }
    else
    {
        zoomImageView.frame=CGRectMake(0, 44, 320, 416-49);
        
    }
    
    titleLable.text =[NSString stringWithFormat:@"%@",[[coverImageArray objectAtIndex:0] objectForKey:@"name"]];
    // zoomImageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    // zoomImageView.image=imageFromServer;
    // Do any additional setup after loading the view from its nib.
    
    ///// cover flow //
    coverflowView.backgroundColor=[UIColor clearColor];
    loadImageOpreteion = [[NSOperationQueue alloc] init];
    results=[[NSMutableArray alloc] initWithObjects:@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png",@"food_icon.png", nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer) userInfo:nil repeats:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [backButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Back"] forState:UIControlStateNormal];
}

-(void)onTimer
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Loading..." ]];
    [self imageLoadOnView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickONBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:true];
}




#pragma mark - coverflow digramm
-(void)imageLoadOnView
{
    // NSLog(@"%@",coverImageArray);
    for (int i=0; i<[coverImageArray count]; i++)
    {
        NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/gallery/thumb/%@",ciboRestaurantId,[[coverImageArray objectAtIndex:i]objectForKey:@"path"]]];
        //NSLog(@"%@",imageurl);
        NSData *data=[NSData dataWithContentsOfURL:imageurl];
        [localImageView setImageWithURL:imageurl];
        // UIImage *image=localImageView.image;
        UIImage *compresedImage=[self resizeImage:[UIImage imageWithData:data] width:250 height:300];
        
        [(AFOpenFlowView *)self.coverflowView setImage:compresedImage forIndex:i];
    }
    
    [(AFOpenFlowView *)self.coverflowView setViewDelegate:self];
    [(AFOpenFlowView *)self.coverflowView setDataSource:self];
    [(AFOpenFlowView *)self.coverflowView setExclusiveTouch:YES];
    [(AFOpenFlowView *)self.coverflowView setNumberOfImages:[coverImageArray count]];
    [SVProgressHUD dismissWithSuccess:@"successfully loaded"];
    
}
-(UIImage *)resizeImage:(UIImage *)image width:(int)width height:(int)height
{
    
    CGImageRef imageRef = [image CGImage];
    // CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, (image.size.height)/2, 200, 300));
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    
    //if (alphaInfo == kCGImageAlphaNone)
    alphaInfo = kCGImageAlphaNoneSkipLast;
    //alphaInfo = kCGImageAlphaOnly;
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
    
}

#pragma mark -
#pragma coverflow delegate -
-(IBAction)clickOnImageOnflow:(id)sender
{
    
}
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index
{
    titleLable.text =[NSString stringWithFormat:@"%@",[[coverImageArray objectAtIndex:index] objectForKey:@"name"]];
    
}

// setting the image 1 as the default pic
- (UIImage *)defaultImage
{
    return [UIImage imageNamed:@"icon_mail.png"];
}









@end
