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

- (id)copyWithZone:(NSZone *)zone {
    
    PPLUser *copy = [[PPLUser allocWithZone:zone] init];
    
    if (copy) {
        copy.name = [self.name copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.notes = [self.notes copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.contract = self.contract;
    }
    return copy;
}

- (NSError *)validate {
    
    NSError *error;
    
    [NGRValidator validateModel:self error:&error delegate:nil rules:^NSArray *{
        return @[NGRValidate(@"name").required(),
                 NGRValidate(@"location").required(),
                 NGRValidate(@"role").required()];
    }];
    
    return error;
}

- (NSString *)contractToString {
    
    switch (self.contract) {
        case PPLContractTypeDG:
            return @"Działalność gospodarcza";
        case PPLContractTypeUoP:
            return @"Umowa o pracę";
        case PPLContractTypeUoD:
            return @"Umowa o dzieło";
    }
}

@end
