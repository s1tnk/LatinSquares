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

    CUIHorizontalPickerView *hpv = [[CUIHorizontalPickerView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44.0)];
    hpv.delegate = self;
    hpv.dataSource = self;
    [hpv reloadComponent];
    [self.view addSubview:hpv];
    [hpv release];
    
    n = [[NSNumber alloc] initWithInt:2];
    
    UISegmentedControl * btn = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Generate"]];
    btn.momentary = YES;
    [btn setFrame:CGRectMake(2.0, 46.0, self.view.frame.size.width-4, 40.0)];
    btn.segmentedControlStyle = UISegmentedControlStyleBar;
    //btn.tintColor = [UIColor redColor];
    [btn addTarget:self action:@selector(displaySquare:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:btn];

    sv = [[UIScrollView alloc] init];
    sv.delegate = self;
    sv.frame = CGRectMake(0, 2*44.0, self.view.frame.size.width, self.view.frame.size.height-44*3);
    [self.view addSubview:sv];
    touchedArr = [[NSMutableArray alloc] initWithCapacity:200];
    
    UIToolbar *t = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    UIBarButtonItem *aboutBtn = [[UIBarButtonItem alloc] initWithTitle:@"About"
                                                                           style:UIBarButtonItemStyleBordered
                                                                          target:self
                                                                          action:@selector(showAbout:)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [t setItems:[NSArray arrayWithObjects:flex, aboutBtn, nil] animated:YES];
    [flex release];
    [aboutBtn release];
    [self.view addSubview:t];
    [t release];
}
-(void)showAbout:(id)sender
{
    AboutVC *aboutVC = [[AboutVC alloc] init];
    aboutVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:aboutVC animated:YES];
    [aboutVC release];
}
- (void)displaySquare:(id)sender
{
    [s autorelease];
    s = [[DesignMCWrapper alloc] init];
    s.square = new Square([n intValue]);
    s.square->manyStepsProper(10);
    [self drawSquare];
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
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return ls;
}

-(void)touchedCell:(id)sender
{
    UIButton *b = (UIButton *)[sv viewWithTag:[sender tag]];
    if([touchedArr containsObject:[NSNumber numberWithInt:[sender tag]]])
    {
        [b viewWithTag:500].backgroundColor = [UIColor whiteColor];
        [touchedArr removeObject:[NSNumber numberWithInt:[sender tag]]];
    }
    else
    {
        [touchedArr addObject:[NSNumber numberWithInt:[sender tag]]];
        [b viewWithTag:500].backgroundColor = [UIColor colorWithRed:1.0 green:0.4 blue:0.5 alpha:1.0];
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
