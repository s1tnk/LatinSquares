//
//  Root.m
//  DesignMC
//
//  Created by Andy Drizen on 23/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import "Root.h"


@implementation Root

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Latin Sqaures";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.numberOfLines = 3;
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        cell.textLabel.textColor = [UIColor colorWithRed:39/255.0 green:64/255.0 blue:121/255.0 alpha:1.0];
    }
    
    // Configure the cell...
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Theory";
            //cell.detailTextLabel.text = @"What is a Latin square? How many (n x n) squares are there? All these questions and more can be found here.";
            break;
        case 1:
            cell.textLabel.text = @"Random Square";
            //cell.detailTextLabel.text = @"Use the Jacobson/Matthews method to generate uniformly distributed random Latin squares.";
            break;
        case 2:
            cell.textLabel.text = @"Notable Squares";
            //cell.detailTextLabel.text = @"This is a list of squares with interesting properties.";
            break;
        case 3:
            cell.textLabel.text = @"About This App";
            break;    
        default:
            break;
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            {
                Theory *theory = [[Theory alloc] initWithStyle:UITableViewStylePlain];
                [self.navigationController pushViewController:theory animated:YES];
                [theory release];
            }
            break;
        case 1:
            {
                RandomSquare *randomSquare = [[RandomSquare alloc] init];
                [self.navigationController pushViewController:randomSquare animated:YES];
                [randomSquare release];
            }
            break;
        case 2:
            {
                NotableSquares *notableSquares = [[NotableSquares alloc] initWithStyle:UITableViewStylePlain];
                [self.navigationController pushViewController:notableSquares animated:YES];
                [notableSquares release];
            }
            break;
        case 3:
            {
                ContentView *contentView = [[ContentView alloc] init];
                contentView.titleText = @"About";
                contentView.html = @"<h3>What is a Latin square?</h3>"
                "<p>A Latin square is an (n x n) grid of cells. Each cell contains exactly one symbol from the set {1, 2, ..., n} and every row and column contains each symbol exactly once. This app generates Latin squares uniformly at random using Jacobson and Matthews'  Markov chain. If you'd like to know more about how their method works, I urge you to read their paper, <a href='http://onlinelibrary.wiley.com/doi/10.1002/(SICI)1520-6610(1996)4:6%3C405::AID-JCD3%3E3.0.CO;2-J/abstract'>Generating Uniformly Distributed Latin Squares</a>.</p>"
                
                "<h3>Why, when I click to move to the next square, does it sometimes not change?</h3>"
                "<p>To ensure that the Markov chain is ergodic, it is important that the underlying graph is not bipartite. Putting these loops in the algorithm ensure that the graph is non-bipartite.</p>"
                
                "<h3>Under, &quot;How many..?&quot;, what is the difference between main class and total?</h3>"
                "<p>Take a look at the <a href='http://en.wikipedia.org/wiki/Latin_square'>wikipedia page on Latin Squares</a> - it does a good job of explaining it. Also, I've written <a href='http://www.irregularity.co.uk/2011/03/22/an-introduction-to-latin-squares-part-1/'>a blog post about it</a></p>"
                
                "<h3>How many proper squares do I pass through when I click to move?</h3>"
                "<p>If you tap &quot;Move to next square&quot;, you move from the square you are on to the first proper square found. If you tap &quot;+20&quot;, then you will skip over 19 proper squares and land on the 20th.</p>"
                
                "<h3>Is this Markov chain rapidly mixing?</h3>"
                "<p>Nobody knows, but everyone who I&#39;ve ever spoken to about it would guess that it was.</p>"
                
                "<h3>Who wrote this app?</h3>"
                "<p>Andy Drizen, a London-based freelance iOS developer. For more of my work, you might like to <a href='http://www.andydrizen.co.uk'>visit my website.</a></p>";
                [self.navigationController pushViewController:contentView animated:YES];
                [contentView release];
            }
            break;    
        default:
            break;
    }
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    NSLog(@"Received memory warning in Root.mm");
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
