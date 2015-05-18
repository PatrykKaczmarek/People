//
//  PPLTextFieldTableViewCell.h
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const PPLTextFieldTableViewCellIdentfier;

@interface PPLTextFieldTableViewCell : UITableViewCell

@property (strong, nonatomic) UITextField *textField;

@end
