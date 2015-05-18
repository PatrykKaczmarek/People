//
//  PPLTextFieldTableViewCell.m
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLTextFieldTableViewCell.h"

NSString * const PPLTextFieldTableViewCellIdentfier = @"PPLTextFieldTableViewCellIdentfier";

@implementation PPLTextFieldTableViewCell

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PPLTextFieldTableViewCellIdentfier];
    if (self) {
        _textField = [[UITextField alloc] init];
        [self addSubview:_textField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textField.frame = CGRectInset(self.bounds, 10, 5);
}

@end
