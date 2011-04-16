//
//  CUIHorizontalPickerViewSubView.m
//  Tube-Predictor
//
//  Created by Andy Drizen on 07/01/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import "CUIHorizontalPickerViewSubView.h"


@implementation CUIHorizontalPickerViewSubView
@synthesize scrollView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (UIView *) hitTest:(CGPoint) point withEvent:(UIEvent *)event {
	if ([self pointInside:point withEvent:event]) {
			return scrollView;
	}
	return nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
