//
//  PPLAuthenticator.m
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLAuthenticator.h"
#import "PPLLoginUser.h"
#import "NGRValidator.h"

@interface PPLAuthenticator () <NGRMessaging>

@end

@implementation PPLAuthenticator

- (void)authenticateUser:(PPLLoginUser *)user withCompetion:(void (^)(BOOL, NSError *))completion {
    
    if (completion == NULL) {
        return;
    }
    
    // check model:
    NSError *error = [user validate];
    if (error) {
        completion(NO, error);
        return;
    }
    
    // mock server validation:
    error = [self mockServerValidationOfModel:user withValidEmail:@"admin@o2.pl" validPassword:@"123ewq"];
    if (error) {
        completion(NO, error);
        return;
    }
    
    // success:
    completion(YES, nil);
}

- (NSError *)mockServerValidationOfModel:(PPLLoginUser *)user withValidEmail:(NSString *)email validPassword:(NSString *)password {
    
    NSError *error;
    
    [NGRValidator validateModel:user error:&error delegate:self rules:^NSArray *{
        return @[NGRValidate(@"email").match(email),
                 NGRValidate(@"password").match(password)];
    }];
    
    return error;
}

- (NSDictionary *)validationErrorMessagesByPropertyKey {
    
    return @{@"email" : @{MSGNotMatch : @"Invalid email address"},
             @"password" : @{MSGNotMatch : @"Invalid password"},
             };
}

@end
