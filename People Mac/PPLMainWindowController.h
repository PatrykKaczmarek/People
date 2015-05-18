//
//  PPLMainWindowController.h
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, PPLViewControllerType) {
    PPLLoginViewControllerType,
    PPLMainViewControllerType
};

@interface PPLMainWindowController : NSWindowController

- (void)showViewControllerWithType:(PPLViewControllerType)type;

@end
