//
//  PPLUser.m
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLLoginUser.h"
#import "NGRValidator.h"

@implementation PPLLoginUser

- (instancetype)initWithEmail:(NSString *)email password:(NSString *)password {
    self = [super init];
    if (self) {
        _email = email;
        _password = password;
    }
    return self;
}

- (NSError *)validate {
    
    NSError *error;
    
    [NGRValidator validateModel:self error:&error delegate:nil rules:^NSArray *{
        return @[NGRValidate(@"email").required().syntax(NGRSyntaxEmail),
                 NGRValidate(@"password").required().minLength(5)];
    }];
    
    return error;
}

@end
