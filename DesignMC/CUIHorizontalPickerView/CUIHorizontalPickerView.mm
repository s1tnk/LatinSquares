//
//  CUIHorizontalPickerView.m
//  Tube-Predictor
//
//  Created by Andy Drizen on 07/01/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import "CUIHorizontalPickerView.h"

@implementation CUIHorizontalPickerView

@synthesize delegate, dataSource;

- (id) initWithFrame: (CGRect) tmpFrame
{
    self = [super initWithFrame: tmpFrame];
    
	if (self)
	{
		scrollViewItemPadding = 0.12;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			scrollViewItemPadding *= 0.5;
		}
		
		scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((self.frame.size.width-self.frame.size.width*scrollViewItemPadding)/2, 0.0, self.frame.size.width*scrollViewItemPadding, self.frame.size.height)];
    }
	
    return self;
}

-(void)reloadComponent
{
	NSInteger numberOfColumns = [dataSource numberOfColumsInHorizontalPickerView:self];
	NSString *label = [delegate horizontalPickerView:self titleForColumn:0];
	
	NSLog(@"number of columns = %d, label = %@", numberOfColumns, label);
	
	self.backgroundColor = [UIColor clearColor];
	
	
	[scrollView setContentSize:CGSizeMake(numberOfColumns*(scrollView.frame.size.width), self.frame.size.height)];
	[scrollView setBackgroundColor:[UIColor clearColor]];
	[scrollView setPagingEnabled:YES];
	[scrollView setClipsToBounds:NO];
	[scrollView setShowsHorizontalScrollIndicator:NO];
	[scrollView setDelegate:self];
	
	for (int i = 0; i < numberOfColumns; i++) 
	{
		UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(scrollView.frame.size.width*i, 0.0, scrollView.frame.size.width, scrollView.frame.size.height)];
		[label1 setBackgroundColor:[UIColor clearColor]];
		[label1 setTextAlignment:UITextAlignmentCenter];
		[label1 setFont:[UIFont systemFontOfSize:18.0]];
		[label1 setText:[delegate horizontalPickerView:self titleForColumn:i]];
		[scrollView addSubview:label1];
		[label1 release];
	}
	
	subView = [[CUIHorizontalPickerViewSubView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
	[subView setClipsToBounds:YES];
	[subView setScrollView:scrollView];
	[subView addSubview:scrollView];
	[self addSubview:subView];
}

- (void) scrollViewWillBeginDecelerating: (UIScrollView *) sv
{

}

- (void) scrollViewDidEndDecelerating: (UIScrollView *) sv
{
	NSInteger page = round(sv.contentOffset.x/sv.frame.size.width);
	[delegate horizontalPickerView:self userDidScrollToColumn:page];
}


- (void)drawRect:(CGRect)rect
{	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	size_t num_locations = 4;
	CGFloat locations[4] = {0.0, 0.499, 0.5, 1.0};
	CGFloat components[16] = {  
		162/255.0, 162/255.0, 170/255.0, 1,
		72/255.0, 72/255.0, 85/255.0, 1,
		40/255.0, 40/255.0, 54/255.0, 1,
		40/255.0, 40/255.0, 57/255.0, 1,
	};
	
	CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef myGradient = CGGradientCreateWithColorComponents (myColorspace, components,locations, num_locations);
	
	CGPoint myStartPoint = CGPointMake(0.0, 0.0); 
	CGPoint myEndPoint = CGPointMake(0.0, rect.size.height);
	CGContextDrawLinearGradient (context, myGradient, myStartPoint, myEndPoint, 0);
	CGGradientRelease(myGradient);
	CGColorSpaceRelease(myColorspace);
	
	float whiteBoxPadding = 3.0;
	float radius = 3.0;
	float strokeWidth = 3.0;
	float gapBetweenBorderAndWhiteBox = 2.0;
	
	CGRect rrect = CGRectMake(whiteBoxPadding, 
							  whiteBoxPadding, 
							  rect.size.width-2*whiteBoxPadding, 
							  rect.size.height-2*whiteBoxPadding);
	CGFloat minx = CGRectGetMinX(rrect);
	CGFloat midx = CGRectGetMidX(rrect);
	CGFloat maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect);
	CGFloat midy = CGRectGetMidY(rrect);
	CGFloat maxy = CGRectGetMaxY(rrect);
	
	CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextMoveToPoint(context, maxx, midy);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextClosePath(context);
	CGContextFillPath(context);
	CGContextClip(context);
	
	CGRect pickerRectWhiteBoxStroke = CGRectMake(whiteBoxPadding+gapBetweenBorderAndWhiteBox, 
								   whiteBoxPadding+gapBetweenBorderAndWhiteBox, 
								   rect.size.width-whiteBoxPadding*2-2*gapBetweenBorderAndWhiteBox, 
								   rect.size.height-2*whiteBoxPadding-2*gapBetweenBorderAndWhiteBox);
	
	CGContextSetFillColorWithColor(context, [UIColor colorWithRed:202.0/255 green:202.0/255 blue:220.0/255 alpha:1.0].CGColor);
	CGContextAddRect(context, pickerRectWhiteBoxStroke);
	CGContextFillPath(context);

	CGRect pickerRectWhiteBox = CGRectMake(whiteBoxPadding+gapBetweenBorderAndWhiteBox, 
								   whiteBoxPadding+strokeWidth+gapBetweenBorderAndWhiteBox, 
								   rect.size.width-whiteBoxPadding*2-2*gapBetweenBorderAndWhiteBox, 
								   rect.size.height-2*(whiteBoxPadding+strokeWidth+gapBetweenBorderAndWhiteBox));
	
	CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextAddRect(context, pickerRectWhiteBox);
	CGContextFillPath(context);
	
	
	size_t num_locations2 = 4;
	CGFloat locations2[4] = {0.0, 0.4, 0.6, 1.0};
	CGFloat components2[16] = {  
		0/255.0, 0/255.0, 0/255.0, 0.3,
		0/255.0, 0/255.0, 0/255.0, 0.0,
		0/255.0, 0/255.0, 0/255.0, 0.0,
		0/255.0, 0/255.0, 0/255.0, 0.3,
	};
	
	CGColorSpaceRef myColorspace2 = CGColorSpaceCreateDeviceRGB();
	CGGradientRef myGradient2 = CGGradientCreateWithColorComponents (myColorspace2, components2,locations2, num_locations2);
	
	CGPoint myStartPoint2 = CGPointMake(0.0, 0.0); 
	CGPoint myEndPoint2 = CGPointMake(rect.size.width, 0.0);
	CGContextDrawLinearGradient (context, myGradient2, myStartPoint2, myEndPoint2, 0);
	CGGradientRelease(myGradient2);
	CGColorSpaceRelease(myColorspace2);
	
	float blueBoxWidth = 50;
	CGRect blueRect = CGRectMake((rect.size.width-blueBoxWidth)/2, 0.0, blueBoxWidth, rect.size.height);
	
	CGContextSaveGState(context);
	CGContextAddRect(context, blueRect);
	CGContextClip(context);
	
	size_t num_locations3 = 4;
	CGFloat locations3[4] = {0.0, 0.499, 0.5, 1.0};
	CGFloat components3[16] = {  
		120/255.0, 130/255.0, 240/255.0, 0.1,
		100/255.0, 130/255.0, 210/255.0, 0.1,
		100/255.0, 120/255.0, 200/255.0, 0.2,
		100/255.0, 110/255.0, 200/255.0, 0.2,
	};
	
	CGColorSpaceRef myColorspace3 = CGColorSpaceCreateDeviceRGB();
	CGGradientRef myGradient3 = CGGradientCreateWithColorComponents (myColorspace3, components3,locations3, num_locations3);
	
	CGPoint myStartPoint3 = CGPointMake(0.0, 0.0); 
	CGPoint myEndPoint3 = CGPointMake(0.0, blueRect.size.height);
	CGContextDrawLinearGradient (context, myGradient3, myStartPoint3, myEndPoint3, 0);
	CGGradientRelease(myGradient3);
	CGColorSpaceRelease(myColorspace3);
	CGContextRestoreGState(context);
	
	CGRect blueBoxBorderL = CGRectMake(blueRect.origin.x-1, 0.0, 1.0, rect.size.height);
	CGContextSetFillColorWithColor(context, [UIColor colorWithRed:120.0/255 green:130.0/255 blue:150.0/255 alpha:0.5].CGColor);
	CGContextAddRect(context, blueBoxBorderL);
	CGContextFillPath(context);

	CGRect blueBoxBorderR = CGRectMake(blueRect.origin.x+blueRect.size.width-1, 0.0, 1.0, rect.size.height);
	CGContextSetFillColorWithColor(context, [UIColor colorWithRed:120.0/255 green:130.0/255 blue:150.0/255 alpha:0.5].CGColor);
	CGContextAddRect(context, blueBoxBorderR);
	CGContextFillPath(context);
}

- (void) dealloc
{

    [super dealloc];
}

@end
