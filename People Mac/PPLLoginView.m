//
//  LoginView.m
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLLoginView.h"
#import "NSLabel.h"

@interface PPLLoginView()

@property (strong, nonatomic) NSLabel *label;

@end

@implementation PPLLoginView

- (instancetype)init {
    self = [super init];
    if (self) {
        _label = [[NSLabel alloc] init];
        [_label setStringValue:@"Please Login for Access to Protected Area"];
        [_label setAlignment:NSCenterTextAlignment];
        [self addSubview:_label];
        
        _loginButton = [[NSButton alloc] init];
        _loginButton.title = @"Login";
        _loginButton.alignment = NSCenterTextAlignment;
        [self addSubview:_loginButton];
        
        _emailField = [[NSTextField alloc] init];
        _emailField.placeholderString = @"Email Address";
        _emailField.alignment = NSCenterTextAlignment;
        [self addSubview:_emailField];
        
        _passwordField = [[NSSecureTextField alloc] init];
        _passwordField.placeholderString = @"Password";
        _passwordField.alignment = NSCenterTextAlignment;
        [self addSubview:_passwordField];
    }
    return self;
}

- (void)resizeSubviewsWithOldSize:(NSSize)oldSize {
    [super resizeSubviewsWithOldSize:oldSize];
    
    CGFloat margin = 40.f;
    NSSize size = NSMakeSize(200, 40);
    NSRect rect = self.bounds;
    
    self.label.frame = CGRectMake(CGRectGetMidX(rect) - size.width * 0.5, margin, size.width, size.height);
    
    void (^centralizeRelativeTo)(NSView *view, NSView *relativeView) = ^(NSView *view, NSView *relativeView) {
        view.frame = CGRectMake(CGRectGetMidX(rect) - size.width * 0.5, CGRectGetMaxY(relativeView.frame) + 20, size.width, size.height);
    };
    
    centralizeRelativeTo(self.emailField, self.label);
    centralizeRelativeTo(self.passwordField, self.emailField);
    centralizeRelativeTo(self.loginButton, self.passwordField);
}

- (void)drawRect:(NSRect)dirtyRect {
    
    [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

- (BOOL)isFlipped {
    return YES;
}

@end
