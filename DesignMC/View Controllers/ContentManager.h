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

@interface ContentManager : NSObject <ASIHTTPRequestDelegate> {
    NSMutableDictionary *content;
    NSString *contentPlistPath;
}
+ (ContentManager *) sharedInstance;
- (void) updateContentWithForce:(BOOL)shouldForce;
- (void)downloadExternalFiles;
@property(nonatomic, retain) NSMutableDictionary *content;

@end
