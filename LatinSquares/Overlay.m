//
//  Overlay.m
//  LatinSquares
//
//  Created by Andy Drizen on 14/06/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import "Overlay.h"


@implementation Overlay
@synthesize delegate;
-(id)init
{
    [super init];
    return self;
}

-(void)subtleMessage:(NSString *)str withDelay:(float)d
{
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:str, @"str", [NSNumber numberWithFloat:d], @"duration", nil];
    [self performSelectorInBackground:@selector(displaySubtleMessage:) withObject:info];
}

-(void)displaySubtleMessage:(NSDictionary *)info
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        float d = [[info valueForKey:@"duration"] floatValue];
        NSString *str = [info valueForKey:@"str"];
        UIView *v = [delegate viewForOverlayDisplay];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, v.frame.size.width-10, v.frame.size.height-10)];
        [label setTextAlignment:UITextAlignmentCenter];
        [label setText:str];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setNumberOfLines:0];
        [label setAdjustsFontSizeToFitWidth:YES];
        [label setFont:[UIFont boldSystemFontOfSize:18.0]];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        [label sizeToFit];
    
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(v.frame.size.width/2-label.frame.size.width/2-10, v.frame.size.height/2-label.frame.size.height/2-10, 20+label.frame.size.width, 20+label.frame.size.height)];
        [view setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.9]];
        [view addSubview:label];
    
        [label release];
        [view setAlpha:0];
        view.layer.cornerRadius = 10.0;
        [v addSubview:view];
        [UIView animateWithDuration:0.5 
                              delay:0 
                            options:UIViewAnimationOptionCurveEaseIn 
                         animations:^{
                             view.alpha = 1.0;                                    
                         }  
                         completion:nil
         ];
        
        [UIView animateWithDuration:0.5 
                              delay:d
                            options:UIViewAnimationOptionCurveEaseIn 
                         animations:^{
                             view.alpha = 0;                                    
                         }  
                         completion:^(BOOL finished)
         {
             [view release];
         }
         ];
    [pool drain];
}

-(void)showLoading
{
    [self performSelectorInBackground:@selector(displayShowLoading) withObject:nil];
}

-(void)displayShowLoading
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        UIView *v = [delegate viewForOverlayDisplay];
        loading = [[[UIView alloc] initWithFrame:CGRectMake(v.frame.size.width/2-30, v.frame.size.height/2-60, 60, 60)] retain];
        [loading setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.9]];
        UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        act.frame = CGRectMake(20.0, 20.0, 20, 20);
        [act startAnimating];
        loading.layer.cornerRadius = 10.0;
        [loading addSubview:act];
        loading.alpha = 0;
        [v addSubview:loading];
        [UIView animateWithDuration:0.5 
                              delay:0 
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             loading.alpha = 1.0;
                         }  
                         completion:nil
         ];
    [pool drain];
}
-(void)hideLoading
{
    [self performSelectorInBackground:@selector(displayHideLoading) withObject:nil];
}
-(void)displayHideLoading
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        [UIView animateWithDuration:0.5 
                              delay:0 
                            options:UIViewAnimationOptionCurveEaseIn 
                         animations:^{
                             loading.alpha = 0.0;
                         }  
                         completion:^(BOOL finished)
         {
         }
         ];
    [pool drain];
}

@end
