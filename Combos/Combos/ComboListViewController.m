//
//  ComboListViewController.m
//  Combos
//
//  Created by Rolf Chen on 24/03/12.
//  Copyright (c) 2012 Created by Rolf Chen on 24/03/12.. All rights reserved.
//

#import "ComboListViewController.h"
#import "ComboDetailViewController.h"

@implementation ComboListViewController

#pragma mark private methods
-(void)initJONFromData:(NSData *)jsonData {
    NSError *err = nil;
    NSDictionary *jsonSource = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err == nil && jsonSource != nil) {
        tableSource = [jsonSource objectForKey:@"ComboList"];
    }
}
-(void)initTable {
    //CODE that can be moved. 
    //Copy the comboListAjson from bundel to source CACHE directory; 
    NSString *fileName = @"DundeeList";
    NSString *fileType = @"json";
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];    
    NSString *systemPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", fileName, fileType]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:systemPath]) {
        NSLog(@"File not found at %@ \n copying from: %@", bundlePath, systemPath);
        [[NSFileManager defaultManager] copyItemAtPath:bundlePath toPath:systemPath error:nil];
    }
    
    //Parse JSON Content.
    NSData *jsonData = [NSData dataWithContentsOfFile:systemPath];
    
    [self initJONFromData:jsonData];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *comboList = [tableSource objectAtIndex:indexPath.section];
    NSDictionary *comboDetail = [[comboList objectForKey:@"Combos"] objectAtIndex:indexPath.row];
    
    ComboDetailViewController *comboDetailView = [[ComboDetailViewController alloc] initWithComboDetail:comboDetail];
    [self.navigationController pushViewController:comboDetailView animated:YES];
}
#pragma mark UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableSource != nil) {
        return [tableSource count];
    }
    else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableSource != nil) {
        return [[[tableSource objectAtIndex:section] objectForKey:@"Combos"] count];
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"comboCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (tableSource != nil) {
        NSDictionary *comboList = [tableSource objectAtIndex:indexPath.section];
    
        cell.textLabel.text = [[[comboList objectForKey:@"Combos"] objectAtIndex:indexPath.row] objectForKey:@"name"];
        
    }
    else {
        cell.textLabel.text = @"";
    }
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


#pragma mark Constructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initTable];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleLabel setFont:[UIFont fontWithName:@"UniversCondensed" size:36]];
    [banner setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BannerBg"]]];
   // titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
