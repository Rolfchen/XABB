//
//  BoxingTipsViewController.m
//  Combos
//
//  Created by Rolf Chen on 9/12/12.
//  Copyright (c) 2012 Australian Tourism Data Warehouse. All rights reserved.
//

#import "BoxingTipsViewController.h"
#import "WebViewController.h"

@interface BoxingTipsViewController ()

@end

@implementation BoxingTipsViewController

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
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
    //BUILD TABLE SOURCE HERE
    NSMutableArray *sourceBuilder = [[NSMutableArray alloc] init];
    [sourceBuilder addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Boxing Stances", @"title", @"stances", @"link", nil]];
    [sourceBuilder addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Hand Wraps", @"title", @"handwrap", @"link", nil]];
    tableSource = [NSArray arrayWithArray:sourceBuilder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WebViewController *tips = [[WebViewController alloc] initWithHTML:[[tableSource objectAtIndex:indexPath.row] objectForKey:@"link"]];
    tips.titleString = [[tableSource objectAtIndex:indexPath.row] objectForKey:@"title"];
    [self.navigationController pushViewController:tips animated:YES];
   /* NSDictionary *comboList = [tableSource objectAtIndex:indexPath.section];
    NSDictionary *comboDetail = [[comboList objectForKey:@"Combos"] objectAtIndex:indexPath.row];
    */
   // ComboDetailViewController *comboDetailView = [[ComboDetailViewController alloc] initWithComboDetail:comboDetail];
   // [self.navigationController pushViewController:comboDetailView animated:YES];
}
#pragma mark UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    /*if (tableSource != nil) {
        return [tableSource count];
    }
    else {
        return 1;
    }*/
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   /* if (tableSource != nil) {
        return [[[tableSource objectAtIndex:section] objectForKey:@"Combos"] count];
    }
    else {
        return 1;
    }*/
    return [tableSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"tipsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }/*
    if (tableSource != nil) {
        NSDictionary *comboList = [tableSource objectAtIndex:indexPath.section];
        
        cell.textLabel.text = [[[comboList objectForKey:@"Combos"] objectAtIndex:indexPath.row] objectForKey:@"name"];
        
    }
    else {
        cell.textLabel.text = @"";
    }*/
    
    cell.textLabel.text = [[tableSource objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableSource != nil) {
        return [[tableSource objectAtIndex:section] objectForKey:@"name"];
    }
    else {
        return @"";
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    [headingView setBackgroundColor:[UIColor colorWithRed:254.0f/255.0f green:197.0f/255.0f blue:64.0f/255.0f alpha:1]];
    
    UILabel *headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, tableView.frame.size.width - 10, 22)];
    [headingLabel setBackgroundColor:[UIColor clearColor]];
    if (tableSource != nil) {
        [headingLabel setText:[[tableSource objectAtIndex:section] objectForKey:@"name"]];
    }
    else {
        [headingLabel setText:@""];
    }
    [headingView addSubview:headingLabel];
    [headingLabel setFont:[UIFont fontWithName:@"UniversCondensed" size:20]];
    [headingLabel setTextColor:[UIColor whiteColor]];
    return headingView;
}

@end
