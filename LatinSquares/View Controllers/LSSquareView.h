//
//  LSSquareView.h
//  RLS
//
//  Created by Andy Drizen on 11/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DesignMCWrapper.h"
#import "CUIHorizontalPickerView.h"

@interface LSSquareView : UIViewController <UIActionSheetDelegate, UIScrollViewDelegate, CUIHorizontalPickerViewDelegate, CUIHorizontalPickerViewDataSource> {
    UIScrollView *sv;
    NSMutableArray *touchedArr;
    UIView *ls;
    DesignMCWrapper *s;
    UIView *loading;
    UISegmentedControl *Move1btn, *Move20btn;
    CUIHorizontalPickerView *hpv;
    NSDictionary *sqProperties;
    NSMutableDictionary *plistSquares;
    UIBarButtonItem *aboutBtn;
    //UIBarButtonItem *toolsBtn;
    //BOOL HasUserMovedFromCyclicSquare;
    BOOL AreBlocksPredefined;
    UIColor *cellColour;
    //UIToolbar *toolbar;
    UISlider *red_slider;
    UISlider *blue_slider;
    UISlider *green_slider;
    UIView *propertiesView;
    BOOL isToolboxDisplayed;
    UIBarButtonItem *toolboxButton;
}
-(NSDictionary*)getColour;
-(id)initWithSquare:(DesignMCWrapper *)squareWrapper andProperties:(NSDictionary *)properties;
-(void)showCyclicSquare;
-(void)drawSquare;
-(void)showLoading;
-(void)hideLoading;
-(void)move1;
-(void)move20;
-(void)enumerate;
-(void)findTransversal;
-(void)touchedCell:(id)sender;
-(void)subtleMessage:(NSString *)str withDelay:(float)d;
-(void)interfaceEnabled:(BOOL)b;
-(void)colourGridSquare:(int)tag;
@end
