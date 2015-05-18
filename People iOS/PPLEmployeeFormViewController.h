//
//  PPLEmployeeFormViewController.h
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPLUser;

@interface PPLEmployeeFormViewController : UIViewController

- (instancetype)initWithEmployee:(PPLUser *)employee saveBlock:(void (^)(PPLUser *employee))save;

@end
