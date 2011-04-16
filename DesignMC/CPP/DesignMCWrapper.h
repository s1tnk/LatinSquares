//
//  DesignMCWrapper.h
//  DesignMC
//
//  Created by Andy Drizen on 16/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DesignMC.hpp"

@interface DesignMCWrapper : NSObject {
    Square *square;
}
@property(nonatomic, assign) Square *square;
@end
