//
//  LSWebsiteView.h
//  DesignMC
//
//  Created by Andy Drizen on 16/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LSWebsiteView : UIViewController <UIWebViewDelegate>{
    NSString *titleText;
    NSString *html;
    NSString *url;
    UIWebView *webView;
}
-(void)loadPrepackagedHTML;
@property (nonatomic, retain) NSString *titleText;
@property (nonatomic, retain) NSString *html;
@property (nonatomic, retain) NSString *url;
@end
