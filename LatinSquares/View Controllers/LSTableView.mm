//
//  LSTableView.mm
//  DesignMC
//
//  Created by Andy Drizen on 23/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import "LSTableView.h"


@implementation LSTableView
@synthesize tableFeatures,external_files;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.toolbarHidden = YES;
    
    overlay = [[[Overlay alloc] init] retain];
    overlay.delegate = self;
    isFirstLoad = YES;
    if(!tableFeatures)
    {
        //isFirstScreen = YES;
        //[[ContentManager sharedInstance] setShouldNotify:YES];
        UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateInformation:)];
        self.navigationItem.rightBarButtonItem = refresh;
        [refresh release];

        // Custom initialization
        NSLog(@"Initializing...");
        [[ContentManager sharedInstance] setDelegate:self];
        [[ContentManager sharedInstance] updateContentWithForce:NO];
    }
    else
    {
        //isFirstScreen = NO;
        //[[ContentManager sharedInstance] setShouldNotify:NO];
        self.title = [tableFeatures valueForKey:@"title"];
    }
}

-(void)updateInformation:(id)sender
{
    [overlay showLoading];
    [overlay subtleMessage:@"Checking for update..." withDelay:1.0];
    
    [self.tableView setUserInteractionEnabled:NO];
    [[ContentManager sharedInstance] updateContentWithForce:YES];
}

-(void)contentUpdated:(BOOL)b withMessage:(NSString *)str
{
    NSLog(@"Update string: %@",str);

    if(![str isEqualToString:@"external_files"])
    {
        tableFeatures = [[ContentManager sharedInstance] content];
        [overlay hideLoading];
        if(![str isEqualToString:@""] && isFirstLoad==NO)
        {
            if(b)
                [overlay subtleMessage:str withDelay:2.0];
            else
                [overlay subtleMessage:str withDelay:2.0];
        }
        self.title = [tableFeatures valueForKey:@"title"];
        [self.tableView setUserInteractionEnabled:YES];
    }
    isFirstLoad = NO;

    external_files = [[[ContentManager sharedInstance] content]  valueForKey:@"external_files"];
    
    [self.tableView reloadData];
    
    
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
/*
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(isFirstScreen)
    {
        NSLog(@"view did appear (isFirstScreen = YES;)");
        [[ContentManager sharedInstance] setShouldNotify:YES];
    }
}*/

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
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[tableFeatures valueForKey:@"items"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[tableFeatures valueForKey:@"items"] objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableFeatures valueForKey:@"cell_height"])
        return [[tableFeatures valueForKey:@"cell_height"] floatValue];
    else
        return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UITableViewCellStyle tvc = UITableViewCellStyleDefault;
        if([[tableFeatures valueForKey:@"cell_types"] isEqualToString:@"UITableViewCellStyleSubtitle"])
            tvc = UITableViewCellStyleSubtitle; 
        
        int cell_textLabel_numberOfLines = 2;
        if([tableFeatures valueForKey:@"cell_textLabel_numberOfLines"])
            cell_textLabel_numberOfLines = [[tableFeatures valueForKey:@"cell_textLabel_numberOfLines"] intValue];
        
        int cell_textLabel_fontSize = 20;
        if([tableFeatures valueForKey:@"cell_textLabel_fontSize"])
            cell_textLabel_fontSize = [[tableFeatures valueForKey:@"cell_textLabel_fontSize"] floatValue];
        
        
        cell = [[[UITableViewCell alloc] initWithStyle:tvc reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.numberOfLines = 3;
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:cell_textLabel_fontSize];
        cell.textLabel.numberOfLines = cell_textLabel_numberOfLines;
        cell.textLabel.textColor = [UIColor colorWithRed:39/255.0 green:64/255.0 blue:121/255.0 alpha:1.0];
    }

    NSDictionary *item = [[[tableFeatures valueForKey:@"items"] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if([item valueForKey:@"icon"])
    {
        cell.imageView.image = [UIImage imageWithData:
                                [[external_files valueForKey:[item valueForKey:@"icon"]] valueForKey:@"file"]];
    }
    cell.textLabel.text = [item valueForKey:@"title"];
    cell.detailTextLabel.text = [item valueForKey:@"subtitle"];
    
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
    NSDictionary *item = [[[tableFeatures valueForKey:@"items"] objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row];
    
    if ([[item valueForKey:@"content_type"] isEqualToString:@"LSTableView"]) 
    {
        
        LSTableView *tableView = [[LSTableView alloc] initWithStyle:UITableViewStylePlain];
        tableView.tableFeatures = item;
        tableView.external_files = external_files;
        [self.navigationController pushViewController:tableView animated:YES];
        [tableView release];
    }
    if ([[item valueForKey:@"content_type"] isEqualToString:@"LSWebsiteView"]) 
    {
        LSWebsiteView *websiteView = [[LSWebsiteView alloc] init];
        websiteView.titleText = [item valueForKey:@"title"];
        websiteView.html = [item valueForKey:@"html"];
        websiteView.url = [item valueForKey:@"url"];
        [self.navigationController pushViewController:websiteView animated:YES];
        [websiteView release];
    }
    if ([[item valueForKey:@"content_type"] isEqualToString:@"LSSquareView"]) 
    {
        if([[item valueForKey:@"blocks"] count]==0)
        {
            LSSquareView *squareView = [[LSSquareView alloc] init];
            [self.navigationController pushViewController:squareView animated:YES];
            [squareView release];
        }
        else
        {
            blockSet blocks;
            for(int i=0; i <[[item valueForKey:@"blocks"] count] ; i++)
            {
                block b;
                NSArray *a = [[item valueForKey:@"blocks"] objectAtIndex:i];
                b.push_back([[a objectAtIndex:0] intValue]);
                b.push_back([[a objectAtIndex:1] intValue]);
                b.push_back([[a objectAtIndex:2] intValue]);
                blocks.push_back(b);
            }
            
            DesignMCWrapper *s = [[DesignMCWrapper alloc] init];
            s.square = new Square([[item valueForKey:@"n"] intValue], blocks);
            
            LSSquareView *squareView = [[LSSquareView alloc] initWithSquare:s andProperties:item];
            [self.navigationController pushViewController:squareView animated:YES];
            [squareView release];
        }
    }
}
- (NSString *) tableView: (UITableView *) tv titleForHeaderInSection: (NSInteger) section
{
    return [[tableFeatures valueForKey:@"section_titles"] objectAtIndex:section];
}
- (void)dealloc
{
    [super dealloc];
}
-(UIView *)viewForOverlayDisplay
{
    return self.view;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    NSLog(@"Received memory warning in LSTableView.mm");
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
