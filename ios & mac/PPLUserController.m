//
//  PPLUserController.m
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLUserController.h"

@interface PPLUserController ()

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation PPLUserController

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [@[[self sampleUser]] mutableCopy]; //[NSMutableArray array];
    }
    return self;
}

- (NSArray *)users {
    return [self.array copy];
}

- (PPLUser *)sampleUser {
    
    PPLUser *user = [[PPLUser alloc] init];
    user.location = @"Poznań";
    user.name = @"Marian Kowalski";
    user.contract = PPLContractTypeUoP;
    user.role = @"RoR Dev";
    user.notes = @"Kowalski is awesome!";
    
    return user;
}

- (void)saveUser:(PPLUser *)user {
    
    NSUInteger index = [self.array indexOfObject:user];
    if (index == NSNotFound) {
        [self.array addObject:user];
    } else {
        [self.array replaceObjectAtIndex:index withObject:user];
    }
}

- (void)removeUser:(PPLUser *)user {
    [self.array removeObject:user];
}

@end
