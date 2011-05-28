//
//  LSWebsiteView.m
//  DesignMC
//
//  Created by Andy Drizen on 16/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import "LSWebsiteView.h"


@implementation LSWebsiteView
@synthesize titleText, html, url;
#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 20.0, frame.size.width, frame.size.height )];
	[self.view release];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height-44)];
    [self.view addSubview:webView];
    [webView setDelegate:self];
    [webView setScalesPageToFit:YES];
    
    if(url)
    {
        if ([webView isLoading])
            [webView stopLoading];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];;
        [webView loadRequest:request];
    }
    else
    {
        int w=320,h=480;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
            w=768;
            h=960;
        }
        NSString *htmlToDisplay = [NSString stringWithFormat:
                                   @"<html>"
                                   "<head>"
                                   "<meta name=\"viewport\" content=\"width=%d\" /> "
                                   "<meta name=\"viewport\" content=\"height=%d\" /> "
                                   "<style>"
                                   "body"
                                   "{"
                                   "background-color:#FFFFFF;"
                                   "color:#333333;"
                                   "font-family:helvetica;"
                                   "}"
                                   "h3"
                                   "{"
                                   "color:#1B2E69;"
                                   "padding:2px;"
                                   "text-align:center;"
                                   "border-top:1px #333333 solid;"
                                   "border-bottom:1px #333333 solid;"
                                   "}"
                                   "a:link"
                                   "{"
                                   "color:#C0240D;"
                                   "}"
                                   "a:visited"
                                   "{"
                                   "color:#C0240D;"
                                   "}"
                                   "</style>"
                                   "</head>"
                                   "<body><h2>%@</h2>%@</body></html>", w,h,titleText,html];
        [webView loadHTMLString:htmlToDisplay baseURL:nil];
    }
    self.title = titleText;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error.");
}
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillDisappear
{
    
    NSLog(@"ViewWillDisappear...");

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    NSLog(@"ViewDidUnload...");
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
- (void)dealloc
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if ([webView isLoading])
        [webView stopLoading];
    
    [super dealloc];
    [webView setDelegate:nil];
    [webView release];
    [titleText release];
    [html release];
    [url release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    NSLog(@"Received memory warning in LSWebsiteView.mm");
    // Release any cached data, images, etc that aren't in use.
}


@end
