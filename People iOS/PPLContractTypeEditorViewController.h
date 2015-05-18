//
//  PPLContractTypeEditorViewController.h
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLUser.h"

@interface PPLContractTypeEditorViewController : UIViewController

- (instancetype)initWithSelectedContractType:(PPLContractType)type saveBlock:(void (^)(PPLContractType type))saveBlock;

@end
