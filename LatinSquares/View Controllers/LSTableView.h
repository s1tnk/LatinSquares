//
//  LSTableView.h
//  DesignMC
//
//  Created by Andy Drizen on 23/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentManager.h"
#import "LSSquareView.h"
#import "LSWebsiteView.h"

@interface LSTableView : UITableViewController {
    NSDictionary *tableFeatures;
    NSDictionary *external_files;
}
@property(nonatomic, retain) NSDictionary *tableFeatures;
@property(nonatomic, retain) NSDictionary *external_files;

@end