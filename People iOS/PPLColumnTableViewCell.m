//
//  PPLColumnTableViewCell.m
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLColumnTableViewCell.h"

NSString * const PPLColumnTableViewCellIdentifier = @"PPLColumnTableViewCellIdentifier";

@implementation PPLColumnTableViewCell

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PPLColumnTableViewCellIdentifier];
    if (self) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        self.textLabel.text = @"";
        self.detailTextLabel.text = @"";
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGSize margins = CGSizeMake(20, 5);
    
    self.textLabel.frame = CGRectMake(margins.width, margins.height, CGRectGetMidX(rect) - margins.width * 0.5, CGRectGetHeight(rect) - margins.height);
    self.detailTextLabel.frame = CGRectMake(CGRectGetMidX(rect), margins.height, CGRectGetMidX(rect) - margins.width * 0.5, CGRectGetHeight(rect) - margins.height);
}

@end
