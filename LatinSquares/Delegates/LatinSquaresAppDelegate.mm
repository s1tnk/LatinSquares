//
//  LatinSquaresAppDelegate.m
//  DesignMC
//
//  Created by Andy Drizen on 16/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import "LatinSquaresAppDelegate.h"

@implementation LatinSquaresAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self createEditableCopyOfPlistIfNeeded];
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    LSTableView *tableView = [[LSTableView alloc] initWithStyle:UITableViewStylePlain];
    navigationController = [[UINavigationController alloc] initWithRootViewController:tableView];
    [tableView release];
	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    return YES;
}
- (void)createEditableCopyOfPlistIfNeeded {
	// First, test for existence - we don't want to wipe out a user's DB
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *writableContentPlistPath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"content.plist"];
	NSString *defaultContentPlistPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"content.plist"];

    //[fileManager removeItemAtPath:writableContentPlistPath error:nil];
	
	BOOL dbexists2 = [fileManager fileExistsAtPath:writableContentPlistPath];
	if (!dbexists2) 
    {
		NSError *error;
		BOOL success1 = [fileManager copyItemAtPath:defaultContentPlistPath toPath:writableContentPlistPath error:&error];
		if (!success1)
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
	
}

- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [window release];
    [navigationController release];
    [super dealloc];
}

@end
