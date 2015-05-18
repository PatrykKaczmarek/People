//
//  NSLabel.m
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "NSLabel.h"

@implementation NSLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBezeled:NO];
        [self setDrawsBackground:NO];
        [self setEditable:NO];
        [self setSelectable:NO];
    }
    return self;
}
@end
