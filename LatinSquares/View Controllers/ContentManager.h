//
//  ContentManager.h
//  DesignMC
//
//  Created by Andy Drizen on 27/05/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "JSON.h"

@protocol ContentManagerDelegate;

@interface ContentManager : NSObject <ASIHTTPRequestDelegate> {
    NSMutableDictionary *content;
    NSString *contentPlistPath;
    BOOL ShouldNotify;
    id <ContentManagerDelegate> delegate;
}
+ (ContentManager *) sharedInstance;
- (void) updateContentWithForce:(BOOL)shouldForce;
- (void)downloadExternalFiles;
@property(nonatomic, retain) NSMutableDictionary *content;
@property(nonatomic, assign) BOOL ShouldNotify;
@property(nonatomic, retain) id <ContentManagerDelegate> delegate;
@end

@protocol ContentManagerDelegate
-(void)contentUpdated:(BOOL)b withMessage:(NSString *)str;
@end