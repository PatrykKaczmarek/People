//
//  PPLAuthenticator.h
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPLLoginUser;

@interface PPLAuthenticator : NSObject

- (void)authenticateUser:(PPLLoginUser *)user withCompetion:(void (^)(BOOL success, NSError *error))completion;

@end
