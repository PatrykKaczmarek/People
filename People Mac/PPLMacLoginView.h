//
//  LoginView.h
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PPLMacLoginView : NSView

@property (strong, nonatomic) NSButton *loginButton;
@property (strong, nonatomic) NSTextField *passwordField;
@property (strong, nonatomic) NSTextField *emailField;

@end
