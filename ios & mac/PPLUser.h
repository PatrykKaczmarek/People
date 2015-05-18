//
//  PPLUser.h
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PPLContractType) {
    PPLContractTypeDG = 0,
    PPLContractTypeUoP,
    PPLContractTypeUoD
};

@interface PPLUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, assign) PPLContractType contract;

- (NSError *)validate;

- (NSString *)contractToString;

@end
