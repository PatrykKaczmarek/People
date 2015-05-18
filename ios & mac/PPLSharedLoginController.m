//
//  PPLSharedLoginController.m
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLSharedLoginController.h"
#import "PPLAuthenticator.h"

@implementation PPLSharedLoginController

- (instancetype)init {
    self = [super init];
    if (self) {
        _user = [[PPLLoginUser alloc] init];
    }
    return self;
}

- (void)loginWithCompetion:(void (^)(BOOL, NSError *))completion {
    
    PPLAuthenticator *authenticator = [[PPLAuthenticator alloc] init];
    [authenticator authenticateUser:self.user withCompetion:completion];
}

@end
