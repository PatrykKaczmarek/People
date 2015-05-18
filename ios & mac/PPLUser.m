//
//  PPLUser.m
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLUser.h"
#import "NGRValidator.h"

@implementation PPLUser

- (NSError *)validate {
    
    NSError *error;
    
    [NGRValidator validateModel:self error:&error delegate:nil rules:^NSArray *{
        return @[NGRValidate(@"name").required(),
                 NGRValidate(@"location").required(),
                 NGRValidate(@"role").required()];
    }];
    
    return error;
}

@end
