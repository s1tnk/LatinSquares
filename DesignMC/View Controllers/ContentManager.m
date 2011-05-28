//
//  ContentManager.m
//  DesignMC
//
//  Created by Andy Drizen on 27/05/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import "ContentManager.h"


@implementation ContentManager
@synthesize content;

+ (ContentManager *) sharedInstance
{
	static ContentManager *sharedInstance = nil;
    
	@synchronized (self)
	{
		if (!sharedInstance)
			sharedInstance = [[self alloc] init];
    }
	
	return sharedInstance;
}

- (id) init
{
    if ((self = [super init]))
    {
        contentPlistPath = [[NSString stringWithFormat:@"%@/content.plist", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]] retain];
        content = [[NSMutableDictionary alloc] initWithContentsOfFile:contentPlistPath];

    }
    return self;
}

- (void) updateContentWithForce:(BOOL)shouldForce
{
    NSLog(@"Updating content.");
    NSURL *url = [NSURL URLWithString:@"http://server.andydrizen.co.uk/latinsquares/content.js"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    if(shouldForce)
        request.tag = 1;
    else
        request.tag = 0;
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"Update finished.");
    NSDictionary *response = [[request responseString] JSONValue];
    if([[response valueForKey:@"last_updated"] isEqualToString:[content valueForKey:@"last_updated"]] && [request tag]==0)
    {
        NSLog(@"No updates.");
    }
    else
    {
        if(content)
            [content autorelease];
        content = [[[request responseString] JSONValue] retain];
        [content writeToFile:contentPlistPath atomically:YES];
        
    }
    [self downloadExternalFiles];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"contentUpdateFinished" object:nil];
}
- (void)downloadExternalFiles
{
    NSLog(@"Downloaded external files");
    NSArray *shopping_list = [[content valueForKey:@"external_files"] allKeys];
    for (int i = 0; i < [shopping_list count]; i++)
    {
        NSString *url;
        NSString *type =[[[content valueForKey:@"external_files"] valueForKey:[shopping_list objectAtIndex:i]] valueForKey:@"type"]; 
        if([type isEqualToString:@"image"] && [[[[content valueForKey:@"external_files"] valueForKey:[shopping_list objectAtIndex:i]] valueForKey:@"url_retina"] length] > 0 && [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
            url = [[[content valueForKey:@"external_files"] valueForKey:[shopping_list objectAtIndex:i]] valueForKey:@"url_retina"];
        else
            url = [[[content valueForKey:@"external_files"] valueForKey:[shopping_list objectAtIndex:i]] valueForKey:@"url"];

        NSLog(@"Downloading file: %@",url);
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
        [request setDelegate:self];
        request.userInfo = [NSDictionary dictionaryWithObject:[shopping_list objectAtIndex:i] forKey:@"item"];
        [request setDidFinishSelector:@selector(downloadedFile:)];
        [request startAsynchronous];

    }
}
- (void)downloadedFile:(ASIHTTPRequest *)request
{
    NSString *item = [request.userInfo valueForKey:@"item"];
    NSLog(@"Item downloaded!");
    [[[content valueForKey:@"external_files"] valueForKey:item] setValue:[request responseData] forKey:@"file"];
    [content writeToFile:contentPlistPath atomically:YES];

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fileDownloaded" object:nil];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Error updating content: %@",error);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"contentUpdateFinished" object:nil];
}

@end
