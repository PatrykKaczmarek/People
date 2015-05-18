//
//  PPLUserController.h
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPLUser.h"

@interface PPLSharedUserController : NSObject

- (PPLUser *)sampleUser;

- (NSArray *)users;

- (void)saveUser:(PPLUser *)user;

- (void)removeUser:(PPLUser *)user;

@end
