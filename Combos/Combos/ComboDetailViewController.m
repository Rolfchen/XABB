//
//  ComboDetailViewController.m
//  Combos
//
//  Created by Rolf Chen on 24/03/12.
//  Copyright (c) 2012 Australian Tourism Data Warehouse. All rights reserved.
//

#import "ComboDetailViewController.h"
#import "GalleryScrollViewController.h"

@implementation ComboDetailViewController

static NSString *name = @"name";
static NSString *description = @"description";
static NSString *video = @"video";
static NSString *videoName = @"name";
static NSString *videoType = @"type";
static NSString *videoDescription = @"description";
static NSString *kMoves = @"moves";

@synthesize player = _player;

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *moves = [comboDetail objectForKey:kMoves];
    NSDictionary *moveData = [moves objectAtIndex:indexPath.row];
    if ([moveData objectForKey:videoName]!= nil) {        
        NSString *videoURLString = [[NSBundle mainBundle] pathForResource:[moveData objectForKey:videoName] ofType:[moveData objectForKey:videoType]];
        NSURL *videoURL = [NSURL fileURLWithPath:videoURLString];
        self.player.contentURL = videoURL;
        [videoCaption setText:[moveData objectForKey:videoDescription]];
        [self showVideo:YES];
    }
    /*
    GalleryScrollViewController *galleryView = [[GalleryScrollViewController alloc] initViewWithMovesArray:moves atIndex:indexPath.row];
    [self.navigationController pushViewController:galleryView animated:YES];*/
}

#pragma mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[comboDetail objectForKey:kMoves] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"comboCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSArray *moves = [comboDetail objectForKey:kMoves];
    cell.textLabel.text = [[moves objectAtIndex:indexPath.row] objectForKey:videoDescription];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    
    return cell;
}


#pragma mark Constructors
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithComboDetail:(NSDictionary *)comboSource {
    self = [super initWithNibName:@"ComboDetailViewController" bundle:nil];
    if (self) {
        comboDetail = comboSource;
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
    titleLabel.text = [comboDetail objectForKey:name];
    detailText.text = [comboDetail objectForKey:description];
    comboBreakDownTable.rowHeight = 30;
    
    [banner setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BannerBg"]]];
    
    //Setup VideoPlayer
    NSDictionary *videoDictionary = [comboDetail objectForKey:video];
        
    NSString *videoURLString = [[NSBundle mainBundle] pathForResource:[videoDictionary objectForKey:videoName] ofType:[videoDictionary objectForKey:videoType]];
    NSURL *videoURL = [NSURL fileURLWithPath:videoURLString];
    
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    [self.player setShouldAutoplay:NO];
    [self.player prepareToPlay];
    
    [self.view addSubview:[self.player view]];
    [self.view bringSubviewToFront:videoCaption];
    [self.view bringSubviewToFront:closeButton];
    
    //[videoButton setBackgroundImage:[player thumbnailImageAtTime:1 timeOption:MPMovieTimeOptionNearestKeyFrame] forState:UIControlStateNormal];
    [[self.player view] setFrame:self.view.bounds];
    [[self.player view] setHidden:YES];
    
    [closeButton setHidden:YES];
    [videoCaption setHidden:YES];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self resizeTable];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player pause];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [[self.player view] setFrame:self.view.bounds];
    if (!UIInterfaceOrientationIsLandscape(self.interfaceOrientation) && !self.player.view.isHidden) {
        [videoCaption setHidden:NO];
    }
    else {
        [videoCaption setHidden:YES  ];
    }
    
    [self resizeTable];
}

-(void)showVideo:(BOOL)show {
    [self.player prepareToPlay];
    [[self.player view] setFrame:self.view.bounds];
    if (show) {
        [[self.player view] setHidden:NO];
        [[self.player view] setAlpha:0];
        [[self.player view] setCenter:self.view.center];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [[self.player view] setAlpha:1];
        } completion:^(BOOL completed) {
            [self.player prepareToPlay];
            [self.player play];
            [self.view bringSubviewToFront:closeButton];
            [closeButton setHidden:NO];
            if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
                [videoCaption setHidden:YES];
            }
            else {
                [videoCaption setHidden:NO];
            }
        }];
    }
    else {
        [self.player pause];
        [closeButton setHidden:YES];
        [videoCaption setHidden:YES];
        [UIView animateWithDuration:0.5 animations:^{
            [[self.player view] setAlpha:0];
            
        } completion:^(BOOL complete){
            [[self.player view] setHidden:YES];
            [self.player stop];
        }];
    }
}

-(void)resizeTable {
    CGFloat tableHeight = comboBreakDownTable.rowHeight * [[comboDetail objectForKey:kMoves] count] + 10;
   // CGFloat difference =  tableHeight - comboBreakDownTable.frame.size.height;
    
    CGRect tableFrame = comboBreakDownTable.frame;
    tableFrame.size.height = tableHeight;
    
    comboBreakDownTable.frame = tableFrame;
    CGSize contentSize = contentScrollView.frame.size;
    contentSize.height = comboTitleLabel.frame.origin.y + comboTitleLabel.frame.size.height + 3 + tableHeight;
    contentScrollView.contentSize = contentSize;

}

-(IBAction)playVideo:(id)sender {
    [self showVideo:YES];
    NSDictionary *videoDictionary = [comboDetail objectForKey:video];
    
    NSString *videoURLString = [[NSBundle mainBundle] pathForResource:[videoDictionary objectForKey:videoName] ofType:[videoDictionary objectForKey:videoType]];
    NSURL *videoURL = [NSURL fileURLWithPath:videoURLString];

    self.player.contentURL = videoURL;
    [videoCaption setText:@"This is what the combo looks like in action"];
    //VideoViewController *video = [[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:nil];
  //  [self.navigationController pushViewController:video animated:YES];
}

-(IBAction)closeVideo:(id)sender {
    [self showVideo:NO];
}

@end
