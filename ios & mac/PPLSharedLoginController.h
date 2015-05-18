//
//  PPLSharedLoginController.h
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPLLoginUser.h"

@interface PPLSharedLoginController : NSObject

- (void)loginWithCompetion:(void (^)(BOOL success, NSError *error))completion;
    
@property (nonatomic, strong, readonly) PPLLoginUser *user;

@end
