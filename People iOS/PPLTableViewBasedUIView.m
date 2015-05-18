//
//  UITableViewBasedUIView.m
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLTableViewBasedUIView.h"

@implementation PPLTableViewBasedUIView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:_tableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

@end
