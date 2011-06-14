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
    if ((self = [super init])) {
        self.title = @"Random Square";
        s = [[DesignMCWrapper alloc] init];
        blockSet bs;
        s.square = new Square(8, bs);
        AreBlocksPredefined = NO;
    }
    return self;
}
-(id)initWithSquare:(DesignMCWrapper *)squareWrapper andProperties:(NSDictionary *)properties
{
    if ((self = [super init])) {
        self.title = [properties valueForKey:@"title"];
        s = [squareWrapper retain];
        AreBlocksPredefined = YES;
        sqProperties = [properties retain];
    }
    return self;
}
- (void)loadView
{
    overlay = [[[Overlay alloc] init ] retain];
    overlay.delegate = self;
    cellColour = [[UIColor colorWithRed:192/255.0 green:36/255.0 blue:13/255.0 alpha:1.0] retain];
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    //NSLog(@"orientation: %@",[[UIApplication sharedApplication] statusBarOrientation]);
    float w,h;
    if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) || 
        ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight)) 
        
    {
        w = frame.size.height;
        h = frame.size.width;
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
            h+=10;
        }
    } else {
        w = frame.size.width;
        h = frame.size.height;
    }
    
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, w, h )];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
	[self.view release];
    isToolboxDisplayed = NO;
    toolbarOffset = 0;
    if(!AreBlocksPredefined || [[sqProperties valueForKey:@"allowPertubation"] boolValue])
    {
        toolbarOffset = 1;
        hpv = [[[CUIHorizontalPickerView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44.0)] retain];
        hpv.delegate = self;
        hpv.dataSource = self;
        [hpv reloadComponent];
        [hpv scrollToPositionItem:6 animated:NO];
        [self.view addSubview:hpv];
        [hpv release];
    }

    sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44.0*toolbarOffset, w, h-2*44-44*toolbarOffset)];
    sv.delegate = self;
    [self.view addSubview:sv];

//    loading = [[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-30, self.view.frame.size.height/2-60, 60, 60)] retain];
//    [loading setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.9]];
//    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    act.frame = CGRectMake(20.0, 20.0, 20, 20);
//    [act startAnimating];
//    loading.layer.cornerRadius = 10.0;
//    [loading addSubview:act];
//    loading.alpha = 0;
//    [self.view addSubview:loading];

    if(!AreBlocksPredefined)
    {
        [overlay showLoading];
        [self performSelectorInBackground:@selector(move20) withObject:nil];
    }
    else
    {
        [overlay showLoading];
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
    
    toolbar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44)] retain];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    toolboxButton = [[[UIBarButtonItem alloc] initWithTitle:@"Open Toolbox" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleToolbox:)] retain];
    [toolbar setItems:[NSArray arrayWithObjects:flex,toolboxButton,flex,nil] animated:YES];
    [toolboxButton release];
    [propertiesView addSubview:toolbar];
    [toolbar release];
    
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

    toolButton1 = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
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
        
        toolButton2 = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
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
//-(void)showLoading
//{
//    [UIView animateWithDuration:0.5 
//                          delay:0 
//                        options:UIViewAnimationCurveEaseIn
//                     animations:^{
//                         loading.alpha = 1.0;
//                     }  
//                     completion:nil
//     ];
//
//}
//-(void)hideLoading
//{
//    [UIView animateWithDuration:0.5 
//                          delay:0 
//                        options:nil 
//                     animations:^{
//                                     loading.alpha = 0.0;
//                                 }  
//                     completion:^(BOOL finished)
//                                 {
//                                 }
//     ];
//}
//-(void)subtleMessage:(NSString *)str withDelay:(float)d inView:(UIView *)v
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(v.frame.size.width/2-80, v.frame.size.height/2-50, 160, 80)];
//    [view setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.9]];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, view.frame.size.width-10, view.frame.size.height-10)];
//    [label setTextAlignment:UITextAlignmentCenter];
//    [label setText:str];
//    [label setBackgroundColor:[UIColor clearColor]];
//    [label setTextColor:[UIColor whiteColor]];
//    [label setAdjustsFontSizeToFitWidth:YES];
//    [label setNumberOfLines:0];
//    [label setLineBreakMode:UILineBreakModeWordWrap];
//    [view addSubview:label];
//    [label release];
//    [view setAlpha:0];
//    view.layer.cornerRadius = 10.0;
//    [self.view addSubview:view];
//    [UIView animateWithDuration:0.5 
//                          delay:0 
//                        options:nil 
//                     animations:^{
//                         view.alpha = 1.0;                                    
//                     }  
//                     completion:nil
//     ];
//    
//    [UIView animateWithDuration:0.5 
//                          delay:d
//                        options:nil 
//                     animations:^{
//                                    view.alpha = 0;                                    
//                                }  
//                     completion:^(BOOL finished)
//                                {
//                                    [view release];
//                                }
//     ];
//}

-(void)pressedToolButton1:(id)sender
{
    [self performSelector:@selector(toggleToolbox:) withObject:nil];
    if(!AreBlocksPredefined)
    {
        [self interfaceEnabled:NO];
        [overlay showLoading];
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
        [overlay subtleMessage:@"No Latin square on 2 points has a transversal." withDelay:2.5];
    }
    else
    {
        [overlay showLoading];
        [self performSelectorInBackground:@selector(findTransversal) withObject:nil];
    }
}

-(void)findTransversal
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        
        // clear any coloured squares first.
        [self drawSquare];
        [overlay showLoading];
        int limit = 50000;
        NSString *msg = @"Timed out.";
        if(s.square->getVType() < 7)
        {
            limit = 2000;
            msg = @"Timed out. Square probably has no transversal.";
        }
        if(s.square->getVType() > 12)
        {
            [overlay subtleMessage:@"This is a big square so I probably won't be able to find a transversal; I'll try anyway." withDelay:4.0];
        }
        
        
        [self interfaceEnabled:NO];
        blockSet b = s.square->generateDiagonal(); 
        int k = 0;
        while(!s.square->IsTransversal(b))
        {
            k++;
            if(k>limit)
            {
                [self interfaceEnabled:YES];
                [overlay hideLoading];
                [overlay subtleMessage:msg withDelay:1.0];
                return;
            }
            b = s.square->diagonalMove(b, 1);
        }
        for(int i=0; i<b.size(); i++)
        {
            [self colourGridSquare:b[i][0]*s.square->getVType()+b[i][1]-s.square->getVType()+2];
        }
        [self interfaceEnabled:YES];
        [overlay hideLoading];
        
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
    [overlay showLoading];
    [self drawSquare];
}

- (void)moveToNextSquare:(id)sender
{
    [self interfaceEnabled:NO];
    [overlay showLoading];
    [self performSelectorInBackground:@selector(move1) withObject:nil];
}
-(void)move1
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        s.square->manyStepsProper(1);
        [self drawSquare];
    [pool release];
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
    if(touchedArr)
        [touchedArr autorelease];
    touchedArr = [[[NSMutableArray alloc] initWithCapacity:200] retain];

    cellSize = CGSizeMake(60,60);
    padding = 1.0;
    sv.minimumZoomScale = MIN(1.0, MIN(self.view.frame.size.width,self.view.frame.size.height-44*2)/(s.square->getVType()*cellSize.width));
    sv.maximumZoomScale = 1.0;
    sv.alwaysBounceHorizontal = YES;
    sv.alwaysBounceVertical = YES;
    
    [[sv subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [ls autorelease];
    [ls setTag:99];
    ls = [[UIView alloc] initWithFrame:CGRectMake(
                                                  MAX(0, sv.frame.size.width/2-cellSize.width*s.square->getVType()/2), 
                                                  MAX(0,sv.frame.size.height/2-cellSize.height*s.square->getVType()/2), 
                                                  cellSize.width*s.square->getVType(), 
                                                  cellSize.height*s.square->getVType())];
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
    [overlay hideLoading];
    
}
- (CGRect)centeredFrameForScrollView:(UIScrollView *)scroll andUIView:(UIView *)rView {
    CGSize boundsSize = scroll.bounds.size;
    CGRect frameToCenter = rView.frame;
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    }
    else {
        frameToCenter.origin.x = 0;
    }
    // center vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    }
    else {
        frameToCenter.origin.y = 0;
    }
    return frameToCenter;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    ls.frame = [self centeredFrameForScrollView:sv andUIView:ls];
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
    if(isToolboxDisplayed)
        [self performSelector:@selector(toggleToolbox:) withObject:nil];
    blockSet bs;
    s.square = new Square(column+2, bs);
    [self interfaceEnabled:NO];
    [overlay showLoading];
    [self performSelectorInBackground:@selector(move20) withObject:nil];
}

- (NSInteger)numberOfColumsInHorizontalPickerView:(CUIHorizontalPickerView *)horizontalPickerView
{
    return 14;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation ==  UIInterfaceOrientationLandscapeLeft 
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight 
            || interfaceOrientation == UIInterfaceOrientationPortrait 
            || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{    
    [propertiesView setHidden:YES];
    [hpv setHidden:YES];
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    float w,h;
    w = self.view.frame.size.width;
    h = self.view.frame.size.height;
    NSLog(@"width of hpv = %f, height of hpv = %f",w,h);
    [sv setFrame:CGRectMake(0, 44.0*toolbarOffset, w, h-44-44*toolbarOffset)];
    sv.minimumZoomScale = MIN(1.0, MIN(w,h-44*2)/(s.square->getVType()*cellSize.width));
    [sv setZoomScale:sv.minimumZoomScale];

    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDidStopSelector:@selector(rotationFinished)];
    [UIView setAnimationDelegate:self];

        [propertiesView setFrame:CGRectMake(0.0, h, w, 44+200)];
        [hpv setFrame:CGRectMake(0.0, 0.0-44, w, 44.0)];
        NSLog(@"x = %f",sv.frame.size.width/2-cellSize.width*s.square->getVType()/2);
        [ls setFrame:[self centeredFrameForScrollView:sv andUIView:ls]];
    
        [toolbar setFrame:CGRectMake(0.0, 0.0, w, 44)];
        [red_slider setFrame:CGRectMake(75.0, 65, w-95, 40)];
        [green_slider setFrame:CGRectMake(75.0, 105, w-95, 40)];
        [blue_slider setFrame:CGRectMake(75.0, 145, w-95, 40)];
        if(AreBlocksPredefined)
        {
            [toolButton1 setFrame:CGRectMake(10.0, 50, w-20.0, 44)];
        }
        else
        {
            [toolButton1 setFrame:CGRectMake(10.0, 190, w/2-20.0, 44)];
            [toolButton2 setFrame:CGRectMake(w/2+10.0, 190, w/2-20.0, 44)];
        }

        [loading setFrame:CGRectMake(w/2-30, h/2-60, 60, 60)];
        
    [UIView commitAnimations];
}
-(void)rotationFinished
{
    [hpv autorelease];
    hpv = [[[CUIHorizontalPickerView alloc] initWithFrame:CGRectMake(0.0, 0.0-44, self.view.frame.size.width, 44.0)] retain];
    hpv.delegate = self;
    hpv.dataSource = self;
    [hpv reloadComponent];
    [self.view addSubview:hpv];
    [hpv release];
    
    float w,h;
    w = self.view.frame.size.width;
    h = self.view.frame.size.height;
    [propertiesView setHidden:NO];
    [hpv setHidden:NO];
    [hpv scrollToPositionItem:s.square->getVType()-2 animated:NO];
    
    
    [UIView beginAnimations:@"showbars" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
        [hpv setFrame:CGRectMake(0.0, 0.0, w, 44.0)];
        [propertiesView setFrame:CGRectMake(0.0, h-44, w, 44+200)];
    [UIView commitAnimations];
     
    if(isToolboxDisplayed)
    {
        isToolboxDisplayed = NO;
        [self performSelector:@selector(toggleToolbox:) withObject:nil];
    }
}
-(UIView *)viewForOverlayDisplay
{
    return self.view;
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
    [toolboxButton release];
    [propertiesView release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    NSLog(@"Received memory warning in LSSquareView.mm");
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
