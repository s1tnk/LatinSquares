//
//  CUIHorizontalPickerView.h
//  Tube-Predictor
//
//  Created by Andy Drizen on 07/01/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#import "CUIHorizontalPickerViewSubView.h"

@protocol CUIHorizontalPickerViewDelegate;
@protocol CUIHorizontalPickerViewDataSource;

@interface CUIHorizontalPickerView : UIView <UIScrollViewDelegate> {
	id <CUIHorizontalPickerViewDelegate> delegate;
	id <CUIHorizontalPickerViewDataSource> dataSource;
	UIScrollView *scrollView;
	CUIHorizontalPickerViewSubView *subView;
	
	float scrollViewItemPadding;
	
}

@property (nonatomic, retain) id <CUIHorizontalPickerViewDelegate> delegate;
@property (nonatomic, retain) id <CUIHorizontalPickerViewDataSource> dataSource;
-(void)reloadComponent;
@end

@protocol CUIHorizontalPickerViewDelegate
- (NSString *)horizontalPickerView:(CUIHorizontalPickerView *)horizontalPickerView titleForColumn:(NSInteger)column;
- (void)horizontalPickerView:(CUIHorizontalPickerView *)horizontalPickerView userDidScrollToColumn:(NSInteger)column;
@end

@protocol CUIHorizontalPickerViewDataSource
- (NSInteger)numberOfColumsInHorizontalPickerView:(CUIHorizontalPickerView *)horizontalPickerView;
@end