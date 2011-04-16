//
//  AboutVC.m
//  DesignMC
//
//  Created by Andy Drizen on 16/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import "AboutVC.h"


@implementation AboutVC

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 20.0, frame.size.width, frame.size.height )];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.3 alpha:1.0]];
	[self.view release];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 44.0, self.view.frame.size.width-20,  60)];
    [label setNumberOfLines:2];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"Generating Uniformly Distributed Random Latin Squares"];
    [self.view addSubview:label];
    [label release];
    
    UITextView *summary = [[UITextView alloc] initWithFrame:CGRectMake(10.0, 44.0+70, self.view.frame.size.width-20,  300)];
    [summary setBackgroundColor:[UIColor colorWithWhite:0.4 alpha:1.0]];
    [summary setTextColor:[UIColor whiteColor]];
    [summary setEditable:NO];
    [summary setFont:[UIFont systemFontOfSize:14]];
    [summary setDataDetectorTypes:UIDataDetectorTypeAll];
    [summary setText:@"A Latin square is an (n x n) grid of cells. Each cell contains exactly one symbol from the set {1, 2, ..., n} and every row and column contains each symbol exactly once. This app generates Latin squares uniformly at random using Jacobson and Matthews'  Markov chain. If you'd like to know more about how their method works, I urge you to read their paper.\n\nHere are some links you might enjoy reading:\n\nGenerating Unformly Distributed Random Latin Squares, \nhttp://onlinelibrary.wiley.com/doi/10.1002/(SICI)1520-6610(1996)4:6%3C405::AID-JCD3%3E3.0.CO;2-J/abstract\n\nLatin Squares on Wikipedia\nhttp://en.wikipedia.org/wiki/Latin_square"];
    [self.view addSubview:summary];
    [summary release];
    
    
    
    UIToolbar *t = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self
                                                                action:@selector(closeAbout:)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [t setItems:[NSArray arrayWithObjects:flex, closeBtn, nil] animated:YES];
    [flex release];
    [closeBtn release];
    [self.view addSubview:t];
    [t release];

}
-(void)closeAbout:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


@end
