//
//  RootVC.m
//  RLS
//
//  Created by Andy Drizen on 11/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import "RootVC.h"

@implementation RootVC

#pragma mark - View lifecycle

- (void)loadView
{
	CGRect frame = [UIScreen mainScreen].applicationFrame;
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 20.0, frame.size.width, frame.size.height )];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
	[self.view release];

    hpv = [[[CUIHorizontalPickerView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44.0)] retain];
    hpv.delegate = self;
    hpv.dataSource = self;
    [hpv reloadComponent];
    [self.view addSubview:hpv];
    [hpv release];
    
    n = [[NSNumber alloc] initWithInt:7];
    
    Move1btn = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Move to next square"]];
    Move1btn.momentary = YES;
    [Move1btn setFrame:CGRectMake(2.0, 46.0, (3*self.view.frame.size.width)/4-4, 40.0)];
    Move1btn.segmentedControlStyle = UISegmentedControlStyleBar;
    [Move1btn addTarget:self action:@selector(moveToNextSquare:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:Move1btn];
    
    Move20btn = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"+20"]];
    Move20btn.momentary = YES;
    [Move20btn setFrame:CGRectMake(2+(3*self.view.frame.size.width)/4, 46.0, self.view.frame.size.width/4-4, 40.0)];
    Move20btn.segmentedControlStyle = UISegmentedControlStyleBar;
    Move20btn.tintColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    [Move20btn addTarget:self action:@selector(move20Squares:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:Move20btn];

    sv = [[UIScrollView alloc] init];
    sv.delegate = self;
    sv.frame = CGRectMake(0, 2*44.0, self.view.frame.size.width, self.view.frame.size.height-44*3);
    [self.view addSubview:sv];
    touchedArr = [[NSMutableArray alloc] initWithCapacity:200];
    
    UIBarButtonItem *aboutBtn = [[UIBarButtonItem alloc] initWithTitle:@"About"
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self
                                                                action:@selector(showAbout:)];
    self.navigationItem.leftBarButtonItem = aboutBtn;    
    self.title = @"Latin Squares";
    [aboutBtn release];
    
    loading = [[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-30, self.view.frame.size.height/2-60, 60, 60)] retain];
    [loading setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.9]];
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    act.frame = CGRectMake(20.0, 20.0, 20, 20);
    [act startAnimating];
    
    loading.layer.cornerRadius = 10.0;
    [loading addSubview:act];
    loading.alpha = 0;
    [self.view addSubview:loading];

    [self showCyclicSquare];
}
-(void)showLoading
{
    Move1btn.enabled = NO;
    Move20btn.enabled = NO;
    [hpv setUserInteractionEnabled:NO];
    
    [UIView beginAnimations:@"showLoading" context:nil];
    [UIView setAnimationDelegate:self];
    {
        loading.alpha = 1.0;
    }
    [UIView commitAnimations];

}
-(void)hideLoading
{
    Move1btn.enabled = YES;
    Move20btn.enabled = YES;
    [hpv setUserInteractionEnabled:YES];
    
    [UIView beginAnimations:@"hideLoading" context:nil];
    [UIView setAnimationDelegate:self];
    {
        loading.alpha = 0.0;
    }
    [UIView commitAnimations];
}
-(void)showAbout:(id)sender
{
    AboutVC *aboutVC = [[AboutVC alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:aboutVC];
    [aboutVC release];
    [self presentModalViewController:navVC animated:YES];
    [navVC release];
}

-(void)showCyclicSquare
{
    [self showLoading];
    [self performSelectorInBackground:@selector(createSquare) withObject:nil];
}
-(void)createSquare
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        l = n;
        s = [[DesignMCWrapper alloc] init];
        s.square = new Square([n intValue]);
        [self drawSquare];
    [pool release];
}

- (void)moveToNextSquare:(id)sender
{
    [self showLoading];
    [self performSelectorInBackground:@selector(move1) withObject:nil];
}
-(void)move1
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        s.square->manyStepsProper(1);
        [self drawSquare];
    [pool release];
}
- (void)move20Squares:(id)sender
{
    [self showLoading];
    [self performSelectorInBackground:@selector(move20) withObject:nil];
}
-(void)move20
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        s.square->manyStepsProper(20);
        [self drawSquare];
    [pool release];
}

-(void)drawSquare
{
    int k =[n intValue];
    CGSize cellSize = CGSizeMake(50,50);
    float padding = 1.0;
    sv.minimumZoomScale = MIN(1.0, self.view.frame.size.width/(k*50));
    sv.maximumZoomScale = 1.0;
    sv.alwaysBounceHorizontal = YES;
    sv.alwaysBounceVertical = YES;
    
    [[sv subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [ls autorelease];
    ls = [[UIView alloc] initWithFrame:CGRectMake(MAX(0, sv.frame.size.width/2-cellSize.width*k/2), MAX(0,sv.frame.size.height/2-cellSize.height*k/2), cellSize.width*k, cellSize.height*k)];
    [sv addSubview:ls];
    sv.contentSize = CGSizeMake(ls.frame.size.width, ls.frame.size.height);
    sv.zoomScale = sv.minimumZoomScale;
    for(unsigned int i=0; i < s.square->getVType(); i++)
    {
        for(unsigned int j=0; j < s.square->getVType(); j++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i*cellSize.width+padding, j*cellSize.height+padding, cellSize.width-2*padding, cellSize.height-2*padding);
            button.tag = i*s.square->getVType()+j+2;
            button.backgroundColor = [UIColor blackColor];
            [button addTarget:self action:@selector(touchedCell:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, cellSize.width-2*padding, cellSize.height-2*padding)];
            label.font = [UIFont systemFontOfSize:cellSize.width-10];
            label.backgroundColor = [UIColor whiteColor];
            label.adjustsFontSizeToFitWidth = YES;
            label.textAlignment = UITextAlignmentCenter;
            label.tag=500;
            label.text = [NSString stringWithFormat:@"%d",s.square->getBlocks()[i*s.square->getVType()+j][2]+1-2*s.square->getVType()];
            [button addSubview:label];
            [label release];
            [ls addSubview:button];
        }
    }
    [self hideLoading];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return ls;
}

-(void)touchedCell:(id)sender
{
    UIButton *b = (UIButton *)[sv viewWithTag:[sender tag]];
    UILabel *tmpLabel = (UILabel *)[b viewWithTag:500];
    if([touchedArr containsObject:[NSNumber numberWithInt:[sender tag]]])
    {
        tmpLabel.backgroundColor = [UIColor whiteColor];
        tmpLabel.textColor = [UIColor blackColor];
        [touchedArr removeObject:[NSNumber numberWithInt:[sender tag]]];
    }
    else
    {
        [touchedArr addObject:[NSNumber numberWithInt:[sender tag]]];
        tmpLabel.backgroundColor = [UIColor colorWithRed:192/255.0 green:36/255.0 blue:13/255.0 alpha:1.0];
        tmpLabel.textColor = [UIColor whiteColor];
    }
}

- (NSString *)horizontalPickerView:(CUIHorizontalPickerView *)horizontalPickerView titleForColumn:(NSInteger)column
{
    return [NSString stringWithFormat:@"%d",column+2];
}

- (void)horizontalPickerView:(CUIHorizontalPickerView *)horizontalPickerView userDidScrollToColumn:(NSInteger)column
{
    [n autorelease];
    n = [[NSNumber numberWithInt:column+2] retain];
    [self showCyclicSquare];
}

- (NSInteger)numberOfColumsInHorizontalPickerView:(CUIHorizontalPickerView *)horizontalPickerView
{
    return 19;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [super dealloc];
    [sv release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
