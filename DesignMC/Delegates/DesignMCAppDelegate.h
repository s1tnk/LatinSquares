//
//  DesignMCAppDelegate.h
//  DesignMC
//
//  Created by Andy Drizen on 16/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSTableView.h"

@interface DesignMCAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
}
- (void)createEditableCopyOfPlistIfNeeded;
- (NSString *)applicationDocumentsDirectory;
@end
