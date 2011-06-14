//
//  Overlay.h
//  LatinSquares
//
//  Created by Andy Drizen on 14/06/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@protocol OverlayDelegate;
@interface Overlay : NSObject {
    id <OverlayDelegate> delegate;
    UIView *loading;
}
-(void)subtleMessage:(NSString *)str withDelay:(float)d;
-(void)showLoading;
-(void)hideLoading;

-(void)displaySubtleMessage:(NSDictionary *)info;
-(void)displayShowLoading;
-(void)displayHideLoading;

@property(nonatomic, retain) id <OverlayDelegate> delegate;
@end

@protocol OverlayDelegate
- (UIView *)viewForOverlayDisplay;
@end