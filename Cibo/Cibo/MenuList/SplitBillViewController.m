//
//  SplitBillViewController.m
//  Restaurant Cibo
//
//  Created by Naveen Rajput on 27/07/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import "SplitBillViewController.h"

@interface SplitBillViewController ()

@end

@implementation SplitBillViewController
@synthesize arrItemOrder;
@synthesize spliteBillArray;
@synthesize orderAmount;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    imgBGPatti.layer.cornerRadius = 10;
    imgBGPatti.layer.borderWidth = 2;
    imgBGPatti.layer.borderColor = [[UIColor brownColor] CGColor];
    
    btnCheckOut.layer.cornerRadius = 10;
    btnCheckOut.layer.borderWidth = 2;
    btnCheckOut.layer.borderColor = [[UIColor brownColor] CGColor];
    
    tblSplitBill.layer.cornerRadius = 10;
    tblSplitBill.layer.borderWidth = 2;
    tblSplitBill.layer.borderColor = [[UIColor brownColor] CGColor];
    
    lblTatalAmount.text = [NSString stringWithFormat:@"%.2f",orderAmount];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate and datasource method list
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return spliteBillArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Where you want to move?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Bill 01", @"Bill 02", @"Bill 03",@"Bill 04", nil];
    
    [actionSheet showInView:self.view];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SplitBillViewCell";
    SplitBillViewCell *cell = (SplitBillViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SplitBillViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    cell.lblItemName.text =[[[spliteBillArray objectAtIndex:indexPath.row]objectForKey:@"p" ] objectForKey:@"name"];
    //cell.lblItemPrice.text =[[[spliteBillArray objectAtIndex:indexPath.row]objectForKey:@"p" ] objectForKey:@"sub_total"];
    //cell.lblItemName.text   = [spliteBillArray objectAtIndex:indexPath.row];
    //cell.imgCatIcon.image = [UIImage imageNamed:[arrCatIcon objectAtIndex:indexPath.row]];
    return cell;
    
}
-(IBAction)tapped_btnMenu:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
