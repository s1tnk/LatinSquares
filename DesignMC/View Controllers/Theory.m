//
//  Theory.m
//  DesignMC
//
//  Created by Andy Drizen on 23/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import "Theory.h"


@implementation Theory

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *plistPathTheory = [bundle pathForResource: @"Theory" ofType: @"plist"];
        theory = [[[NSDictionary alloc] initWithContentsOfFile: plistPathTheory] valueForKey:@"theory"];
    }
    return self;
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Theory";
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return [[theory valueForKey:@"fundamentals"] count];
            break;
        case 1:
            return [[theory valueForKey:@"books"] count];
            break;
        case 2:
            return [[theory valueForKey:@"papers"] count];
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    UITableViewCellStyle cellStyle;
    switch (indexPath.section) {
        case 0:
            CellIdentifier = @"fundamentals";
            cellStyle = UITableViewCellStyleDefault;
            break;
        case 1:
            CellIdentifier = @"books";
            cellStyle = UITableViewCellStyleSubtitle;
            break;
        case 2:
            CellIdentifier = @"papers";
            cellStyle = UITableViewCellStyleSubtitle;
            break;
        default:
            CellIdentifier = @"Cell";
            cellStyle = UITableViewCellStyleDefault;
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [[[theory valueForKey:@"fundamentals"] objectAtIndex:indexPath.row] valueForKey:@"title"];
            break;
        case 1:
            cell.textLabel.text = [[[theory valueForKey:@"books"] objectAtIndex:indexPath.row] valueForKey:@"title"];
            cell.detailTextLabel.text = [[[theory valueForKey:@"books"] objectAtIndex:indexPath.row] valueForKey:@"authors"];
            break;
        case 2:
            cell.textLabel.text = [[[theory valueForKey:@"papers"] objectAtIndex:indexPath.row] valueForKey:@"title"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@",[[[theory valueForKey:@"papers"] objectAtIndex:indexPath.row] valueForKey:@"authors"],[[[theory valueForKey:@"papers"] objectAtIndex:indexPath.row] valueForKey:@"journal"]];
            break;
        default:
            break;
    }
    // Configure the cell...
    
    return cell;
}
- (NSString *) tableView: (UITableView *) tv titleForHeaderInSection: (NSInteger) section
{
    switch (section) {
        case 0:
            return @"Fundamentals";
            break;
        case 1:
            return @"Books";
            break;
        case 2:
            return @"Journal Articles";
            break;
            
        default:
            return @"";
            break;
    }
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        return 80;
    else if(indexPath.section==1)
        return 130;
    else
        return 130;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentView *contentView = [[ContentView alloc] init];
    switch (indexPath.section) {
        case 0:
            contentView.titleText = [[[theory valueForKey:@"fundamentals"] objectAtIndex:indexPath.row] valueForKey:@"title"];
            contentView.html = [[[theory valueForKey:@"fundamentals"] objectAtIndex:indexPath.row] valueForKey:@"description"];
            break;
        case 1:
            contentView.titleText = [[[theory valueForKey:@"books"] objectAtIndex:indexPath.row] valueForKey:@"title"];
            contentView.url = [[[theory valueForKey:@"books"] objectAtIndex:indexPath.row] valueForKey:@"url"];
            break;
        case 2:
            contentView.titleText = [[[theory valueForKey:@"papers"] objectAtIndex:indexPath.row] valueForKey:@"title"];
            contentView.url = [[[theory valueForKey:@"papers"] objectAtIndex:indexPath.row] valueForKey:@"url"];
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:contentView animated:YES];
    [contentView release];
}

@end
