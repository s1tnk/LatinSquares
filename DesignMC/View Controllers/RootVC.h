//
//  RootVC.h
//  RLS
//
//  Created by Andy Drizen on 11/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignMCWrapper.h"
#import "CUIHorizontalPickerView.h"
#import "AboutVC.h"

@interface RootVC : UIViewController <UIScrollViewDelegate, CUIHorizontalPickerViewDelegate, CUIHorizontalPickerViewDataSource> {
    UIScrollView *sv;
    NSNumber *n,*l;
    NSMutableArray *touchedArr;
    UIView *ls;
    DesignMCWrapper *s;
}

-(void)drawSquare;
@end
