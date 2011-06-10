//
//  LSSquareView.m
//  RLS
//
//  Created by Andy Drizen on 11/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import "LSSquareView.h"

@implementation LSSquareView

#pragma mark - View lifecycle

-(id)init
{
    self.title = @"Random Square";
    s = [[DesignMCWrapper alloc] init];
    blockSet bs;
    s.square = new Square(7, bs);
    AreBlocksPredefined = NO;
    return self;
}
-(id)initWithSquare:(DesignMCWrapper *)squareWrapper andProperties:(NSDictionary *)properties
{
    self.title = [properties valueForKey:@"title"];
    s = [squareWrapper retain];
    AreBlocksPredefined = YES;
    sqProperties = [properties retain];
    return self;
}
- (void)loadView
{
    cellColour = [[UIColor colorWithRed:192/255.0 green:36/255.0 blue:13/255.0 alpha:1.0] retain];
    CGRect frame = [UIScreen mainScreen].applicationFrame;
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 20.0, frame.size.width, frame.size.height )];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
	[self.view release];
    isToolboxDisplayed = NO;
    int toolbarOffset = 0;
    if(!AreBlocksPredefined || [[sqProperties valueForKey:@"allowPertubation"] boolValue])
    {
        toolbarOffset = 1;
        hpv = [[[CUIHorizontalPickerView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44.0)] retain];
        hpv.delegate = self;
        hpv.dataSource = self;
        [hpv reloadComponent];
        [self.view addSubview:hpv];
        [hpv release];
    }
    sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, toolbarOffset*44.0, self.view.frame.size.width, self.view.frame.size.height-44-44*2*toolbarOffset)];
    sv.delegate = self;
    [self.view addSubview:sv];
        
    //toolsBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showTools:)];
    //self.navigationItem.rightBarButtonItem = toolsBtn;
    //[toolsBtn release];
    
    loading = [[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-30, self.view.frame.size.height/2-60, 60, 60)] retain];
    [loading setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.9]];
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    act.frame = CGRectMake(20.0, 20.0, 20, 20);
    [act startAnimating];
    loading.layer.cornerRadius = 10.0;
    [loading addSubview:act];
    loading.alpha = 0;
    [self.view addSubview:loading];

    if(!AreBlocksPredefined)
    {
        [self showLoading];
        [self performSelectorInBackground:@selector(move20) withObject:nil];
    }
    else
    {
        [self showLoading];
        [self drawSquare];
    }

    propertiesView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height-2*44, self.view.frame.size.width, 44+200)] retain];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [propertiesView setBackgroundColor:[UIColor colorWithRed:160.0/255 green:165.0/255 blue:178.0/255 alpha:1.0]];
    }
    else
    {
        [propertiesView setBackgroundColor:[UIColor colorWithRed:109.0/255 green:132.0/255 blue:162.0/255 alpha:1.0]];
    }
    
    [self.view addSubview:propertiesView];
    
    UIToolbar *toolbar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44)] retain];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    toolboxButton = [[[UIBarButtonItem alloc] initWithTitle:@"Open Toolbox" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleToolbox:)] retain];
    [toolbar setItems:[NSArray arrayWithObjects:flex,toolboxButton,flex,nil] animated:YES];
    [toolboxButton release];
    [propertiesView addSubview:toolbar];
    
    if(!AreBlocksPredefined)
    {
        red_slider = [[UISlider alloc] initWithFrame:CGRectMake(75.0, 65, self.view.frame.size.width-95, 40)];
        red_slider.minimumValue = 0.0;
        red_slider.maximumValue = 0.9;
        red_slider.value = 0.9;
        [red_slider setMinimumTrackImage:[UIImage imageNamed:@"red_min_track.png"] forState:UIControlStateNormal];
        [propertiesView addSubview:red_slider];

        green_slider = [[UISlider alloc] initWithFrame:CGRectMake(75.0, 105, self.view.frame.size.width-95, 40)];
        green_slider.minimumValue = 0.0;
        green_slider.maximumValue = 0.9;
        green_slider.value = 0.0;
        [green_slider setMinimumTrackImage:[UIImage imageNamed:@"green_min_track.png"] forState:UIControlStateNormal];
        [propertiesView addSubview:green_slider];
        
        blue_slider = [[UISlider alloc] initWithFrame:CGRectMake(75.0, 145, self.view.frame.size.width-95, 40)];
        blue_slider.minimumValue = 0.0;
        blue_slider.maximumValue = 0.9;
        blue_slider.value = 0.0;
        [propertiesView addSubview:blue_slider];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 48, self.view.frame.size.width-10, 16)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"Cell highlight colour"];
        [label setFont:[UIFont boldSystemFontOfSize:14]];
        [propertiesView addSubview:label];
        
        UILabel *red_label = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 60, self.view.frame.size.width-50, 40)];
        [red_label setBackgroundColor:[UIColor clearColor]];
        [red_label setTextColor:[UIColor whiteColor]];
        [red_label setText:@"Red"];
        [red_label setFont:[UIFont boldSystemFontOfSize:12]];
        [propertiesView addSubview:red_label];
        
        UILabel *green_label = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 100, self.view.frame.size.width-50, 40)];
        [green_label setBackgroundColor:[UIColor clearColor]];
        [green_label setTextColor:[UIColor whiteColor]];
        [green_label setText:@"Green"];
        [green_label setFont:[UIFont boldSystemFontOfSize:12]];
        [propertiesView addSubview:green_label];
        
        UILabel *blue_label = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 140, self.view.frame.size.width-50, 40)];
        [blue_label setBackgroundColor:[UIColor clearColor]];
        [blue_label setTextColor:[UIColor whiteColor]];
        [blue_label setText:@"Blue"];
        [blue_label setFont:[UIFont boldSystemFontOfSize:12]];
        [propertiesView addSubview:blue_label];
    }

    UIButton *toolButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [toolButton1 addTarget:self action:@selector(pressedToolButton1:) forControlEvents:UIControlEventTouchUpInside];
    
    if(AreBlocksPredefined)
    {
        [toolButton1 setTitle:@"Tell me about this square" forState:UIControlStateNormal];
        [toolButton1 setFrame:CGRectMake(10.0, 50, self.view.frame.size.width-20.0, 44)];
    }
    else
    {
        [toolButton1 setTitle:@"New Square" forState:UIControlStateNormal];
        [toolButton1 setFrame:CGRectMake(10.0, 190, self.view.frame.size.width/2-20.0, 44)];
        
        UIButton *toolButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [toolButton2 addTarget:self action:@selector(pressedToolButton2:) forControlEvents:UIControlEventTouchUpInside];
        
        [toolButton2 setTitle:@"Show Transversal" forState:UIControlStateNormal];
        [toolButton2 setFrame:CGRectMake(self.view.frame.size.width/2+10.0, 190, self.view.frame.size.width/2-20.0, 44)];
        [propertiesView addSubview:toolButton2];
    }
    
    [propertiesView addSubview:toolButton1];
    

}
-(void)toggleToolbox:(id)sender
{
    NSLog(@"Toggling toolbox");
    if(isToolboxDisplayed)
    {
        NSLog(@"Hiding toolbox");
        [toolboxButton setTitle:@"Open Toolbox"];
        isToolboxDisplayed = NO; 
        [UIView beginAnimations:@"displayToolbox" context:nil];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDelegate:self];
            [propertiesView setFrame:CGRectMake(0.0, self.view.frame.size.height-2*44+44, self.view.frame.size.width, 44+200)];
		[UIView commitAnimations];
    }
    else
    {
        float propertiesViewY;
        if(AreBlocksPredefined)
        {
            propertiesViewY = self.view.frame.size.height-100;
        }
        else
        {
            propertiesViewY = self.view.frame.size.height-propertiesView.frame.size.height;
        }
        NSLog(@"Showing toolbox");
        [toolboxButton setTitle:@"Close Toolbox"];
        isToolboxDisplayed = YES;
        [UIView beginAnimations:@"hideToolbox" context:nil];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDelegate:self];
            [propertiesView setFrame:CGRectMake(0.0, propertiesViewY, self.view.frame.size.width, 44+200)];
		[UIView commitAnimations];
    }
}
-(void)interfaceEnabled:(BOOL)b
{
    if(!b)
    {
        NSLog(@"Disabling interface");
        sv.userInteractionEnabled = NO;
        //toolsBtn.enabled = NO;
        toolboxButton.enabled = NO;
        [hpv setUserInteractionEnabled:NO];
    } 
    else
    {
        NSLog(@"Enabling interface");
        sv.userInteractionEnabled = YES;
        //toolsBtn.enabled = YES;
        toolboxButton.enabled = YES;
        [hpv setUserInteractionEnabled:YES];
    }
    
}
-(void)showLoading
{
    [UIView animateWithDuration:0.5 
                          delay:0 
                        options:UIViewAnimationCurveEaseIn
                     animations:^{
                         loading.alpha = 1.0;
                     }  
                     completion:nil
     ];

}
-(void)hideLoading
{
    [UIView animateWithDuration:0.5 
                          delay:0 
                        options:nil 
                     animations:^{
                                     loading.alpha = 0.0;
                                 }  
                     completion:^(BOOL finished)
                                 {
                                 }
     ];
}
-(void)subtleMessage:(NSString *)str withDelay:(float)d
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-80, self.view.frame.size.height/2-50, 160, 80)];
    [view setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.9]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, view.frame.size.width-10, view.frame.size.height-10)];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:str];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setNumberOfLines:0];
    [label setLineBreakMode:UILineBreakModeWordWrap];
    [view addSubview:label];
    [label release];
    [view setAlpha:0];
    view.layer.cornerRadius = 10.0;
    [self.view addSubview:view];
    [UIView animateWithDuration:0.5 
                          delay:0 
                        options:nil 
                     animations:^{
                         view.alpha = 1.0;                                    
                     }  
                     completion:nil
     ];
    
    [UIView animateWithDuration:0.5 
                          delay:d
                        options:nil 
                     animations:^{
                                    view.alpha = 0;                                    
                                }  
                     completion:^(BOOL finished)
                                {
                                    [view release];
                                }
     ];
}
/*
-(void)showTools:(id)sender
{
    UIActionSheet *actionSheet;
    if(AreBlocksPredefined)
    {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Close" destructiveButtonTitle:nil otherButtonTitles:@"Tell me about this square",nil];
        actionSheet.tag = 2;
    }
    else
    {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Close" destructiveButtonTitle:@"Regenerate Square" otherButtonTitles:@"Find Transversal", @"How many..?",nil];
        actionSheet.tag = 3;
    }

    [actionSheet showInView:self.view];
    [actionSheet release];
}
 */
-(void)pressedToolButton1:(id)sender
{
    [self performSelector:@selector(toggleToolbox:) withObject:nil];
    if(!AreBlocksPredefined)
    {
        [self interfaceEnabled:NO];
        [self showLoading];
        [self performSelectorInBackground:@selector(move20) withObject:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"More Infomation" message:[sqProperties valueForKey:@"description"] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}
-(void)pressedToolButton2:(id)sender
{
    [self performSelector:@selector(toggleToolbox:) withObject:nil];
    if(s.square->getVType() == 2)
    {
        [self subtleMessage:@"No Latin square on 2 points has a transversal." withDelay:2.5];
    }
    else
    {
        [self showLoading];
        [self performSelectorInBackground:@selector(findTransversal) withObject:nil];
    }
}
/*
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            if(actionSheet.tag==3)
            {
                [self showLoading];
                [self performSelectorInBackground:@selector(move20) withObject:nil];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"More Infomation" message:[sqProperties valueForKey:@"description"] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            break;
        case 1:
            if(actionSheet.tag==3)
            {
                if(s.square->getVType() == 2)
                {
                    [self subtleMessage:@"No Latin square on 2 points has a transversal." withDelay:2.5];
                    break;
                }
                [self showLoading];
                [self performSelectorInBackground:@selector(findTransversal) withObject:nil];
            }
            break;
        case 2:
            if(actionSheet.tag==3)
            {
                [self enumerate];
            }
            break;
        default:
            break;
 }
}
 
-(void)enumerate
{
    NSString *iso;
    NSString *nonIso;
    
    switch (s.square->getVType()) {
        case 2:
            iso = @"1";
            nonIso = @"2";
            break;
        case 3:
            iso = @"1";
            nonIso = @"12";
            break;
        case 4:
            iso = @"2";
            nonIso = @"576";
            break;
        case 5:
            iso = @"2";
            nonIso = @"161280";
            break;
        case 6:
            iso = @"12";
            nonIso = @"812851200";
            break;
        case 7:
            iso = @"147";
            nonIso = @"61479419904000";
            break;
        case 8:
            iso = @"283657";
            nonIso = @"108776032459082960000";
            break;
        case 9:
            iso = @"19270853541";
            nonIso = @"5.524751496156892e+27";
            break;
        case 10:
            iso = @"34817397894749940";
            nonIso = @"9.98243765821304e+36";
            break;
        case 11:
            iso = @"2.036029552582883e+24";
            nonIso = @"7.769668361717701e+47";
            break;
        default:
            iso = @"??";
            nonIso = @"??";
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"How many Latin squares of order %d are there?", s.square->getVType()] message:[NSString stringWithFormat:@"Main class:\n%@\n\nTotal:\n%@", iso,nonIso] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
    [alert show];
    [alert release];
}
 */
-(void)findTransversal
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        // clear any coloured squares first.
        [self drawSquare];
        [self interfaceEnabled:NO];
        blockSet b = s.square->generateDiagonal(); 
        int k = 0;
        while(!s.square->IsTransversal(b))
        {
            k++;
            if(k>50000)
            {
                [self interfaceEnabled:YES];
                [self subtleMessage:@"Timed out" withDelay:1.0];
                return;
            }
            b = s.square->diagonalMove(b, 1);
               
        }
        for(int i=0; i<b.size(); i++)
        {
            [self colourGridSquare:b[i][0]*s.square->getVType()+b[i][1]-s.square->getVType()+2];
        }
        [self interfaceEnabled:YES];
        [self hideLoading];
        
    [pool release];
}
-(void)colourGridSquare:(int)tag
{
    UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    tmpBtn.tag = tag;
    [self touchedCell:tmpBtn];
}

-(void)showCyclicSquare
{
    //HasUserMovedFromCyclicSquare = NO;
    [self showLoading];
    [self drawSquare];
}

- (void)moveToNextSquare:(id)sender
{
    [self interfaceEnabled:NO];
    [self showLoading];
    //HasUserMovedFromCyclicSquare = YES;
    [self performSelectorInBackground:@selector(move1) withObject:nil];
}
-(void)move1
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        s.square->manyStepsProper(1);
        [self drawSquare];
    [pool release];
}
/*
- (void)move20Squares:(id)sender
{
    [self interfaceEnabled:NO];
    [self showLoading];
    //HasUserMovedFromCyclicSquare = YES;
    [self performSelectorInBackground:@selector(move20) withObject:nil];
}*/
-(void)move20
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        s.square->manyStepsProper(20);
        [self drawSquare];
    [pool release];
}

-(void)drawSquare
{
    if(touchedArr)
        [touchedArr autorelease];
    touchedArr = [[[NSMutableArray alloc] initWithCapacity:200] retain];

    CGSize cellSize = CGSizeMake(50,50);
    float padding = 1.0;
    sv.minimumZoomScale = MIN(1.0, self.view.frame.size.width/(s.square->getVType()*50));
    sv.maximumZoomScale = 1.0;
    sv.alwaysBounceHorizontal = YES;
    sv.alwaysBounceVertical = YES;
    
    [[sv subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [ls autorelease];
    ls = [[UIView alloc] initWithFrame:CGRectMake(MAX(0, sv.frame.size.width/2-cellSize.width*s.square->getVType()/2), MAX(0,sv.frame.size.height/2-cellSize.height*s.square->getVType()/2), cellSize.width*s.square->getVType(), cellSize.height*s.square->getVType())];
    [sv addSubview:ls];
    sv.contentSize = CGSizeMake(ls.frame.size.width, ls.frame.size.height);
    sv.zoomScale = sv.minimumZoomScale;
    for(unsigned int i=0; i < s.square->getVType(); i++)
    {
        for(unsigned int j=0; j < s.square->getVType(); j++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i*cellSize.width+padding, j*cellSize.height+padding, cellSize.width-2*padding, cellSize.height-2*padding);
            button.tag = j*s.square->getVType()+i+2;
            
            button.backgroundColor = [UIColor blackColor];
            [button addTarget:self action:@selector(touchedCell:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, cellSize.width-2*padding, cellSize.height-2*padding)];
            label.font = [UIFont systemFontOfSize:cellSize.width-10];
            label.backgroundColor = [UIColor whiteColor];
            label.adjustsFontSizeToFitWidth = YES;
            label.textAlignment = UITextAlignmentCenter;
            label.tag=500;
            if(AreBlocksPredefined && ![[sqProperties valueForKey:@"allowRecolouring"] boolValue])
            {
                button.userInteractionEnabled = NO;
            }
            if(AreBlocksPredefined)
            {
                NSArray *tmpArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:j], 
                                     [NSNumber numberWithInt:s.square->getVType()+i], 
                                     [NSNumber numberWithInt:s.square->getBlocks()[j*s.square->getVType()+i][2]],
                                     nil];
                if([[sqProperties valueForKey:@"highlight_blocks"] containsObject:tmpArray])
                {
                    NSNumber *index = [NSNumber numberWithInt:[[sqProperties valueForKey:@"highlight_blocks"] indexOfObject:tmpArray]];
                    CGFloat r = [[[[sqProperties valueForKey:@"highlight_blocks_colours"] objectAtIndex:[index intValue]] valueForKey:@"red"] floatValue];
                    CGFloat g = [[[[sqProperties valueForKey:@"highlight_blocks_colours"] objectAtIndex:[index intValue]] valueForKey:@"green"] floatValue];
                    CGFloat b = [[[[sqProperties valueForKey:@"highlight_blocks_colours"] objectAtIndex:[index intValue]] valueForKey:@"blue"] floatValue];
                    CGFloat a = [[[[sqProperties valueForKey:@"highlight_blocks_colours"] objectAtIndex:[index intValue]] valueForKey:@"alpha"] floatValue];
                    
                    label.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:a];
                    label.textColor = [UIColor whiteColor];
                }
            }
            label.text = [NSString stringWithFormat:@"%d",s.square->getBlocks()[j*s.square->getVType()+i][2]+1-2*s.square->getVType()];
            [button addSubview:label];
            [label release];
            [ls addSubview:button];
        }
    }
    [self interfaceEnabled:YES];
    [self hideLoading];
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return ls;
}
-(NSDictionary*)getColour
{
    UIColor *back = [UIColor colorWithRed:red_slider.value green:green_slider.value blue:blue_slider.value alpha:1.0];
    UIColor *fore;
    float c = red_slider.value + green_slider.value + blue_slider.value;
    if (c >= 2) 
    {
        fore = [UIColor blackColor];
    }
    else
    {
        fore = [UIColor whiteColor];
    }
    NSDictionary *colours = [[[NSDictionary alloc] initWithObjectsAndKeys:back,@"back",fore,@"fore", nil] autorelease];
    return colours;
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
        tmpLabel.backgroundColor = [[self getColour] valueForKey:@"back"];
        tmpLabel.textColor = [[self getColour] valueForKey:@"fore"];
    }
}

- (NSString *)horizontalPickerView:(CUIHorizontalPickerView *)horizontalPickerView titleForColumn:(NSInteger)column
{
    return [NSString stringWithFormat:@"%d",column+2];
}

- (void)horizontalPickerView:(CUIHorizontalPickerView *)horizontalPickerView userDidScrollToColumn:(NSInteger)column
{
    blockSet bs;
    s.square = new Square(column+2, bs);
    [self showLoading];
    [self performSelectorInBackground:@selector(move20) withObject:nil];
}

- (NSInteger)numberOfColumsInHorizontalPickerView:(CUIHorizontalPickerView *)horizontalPickerView
{
    return 10;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc
{
    [super dealloc];
    [s release];
    [sv release];
    [Move1btn release];
    [Move20btn release];
    [loading release];
    [touchedArr release];
    [ls release];
    [red_slider release];
    [green_slider release];
    [blue_slider release];
    
    //[toolbar release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    NSLog(@"Received memory warning in LSSquareView.mm");
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
