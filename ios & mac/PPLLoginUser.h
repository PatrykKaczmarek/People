//
//  PPLUser.h
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPLLoginUser : NSObject

- (instancetype)initWithEmail:(NSString *)email password:(NSString *)password;

@property (strong, nonatomic, readonly) NSString *email;
@property (strong, nonatomic, readonly) NSString *password;

- (NSError *)validate;

@end
