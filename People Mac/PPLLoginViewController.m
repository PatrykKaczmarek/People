//
//  PPLLoginViewController.m
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLLoginViewController.h"
#import "PPLLoginView.h"

#import "PPLMainWindowController.h"
#import "PPLAuthenticator.h"
#import "PPLLoginUser.h"

@interface PPLLoginViewController ()

@property (nonatomic, strong) PPLLoginView *aView;
@property (nonatomic, weak) PPLMainWindowController *windowController;

@end

@implementation PPLLoginViewController

- (instancetype)initWithWindowController:(PPLMainWindowController *)windowController {
    self = [super init];
    if (self) {
        _windowController = windowController;
    }
    return self;
}

- (void)loadView {
    
    PPLLoginView *view = [[PPLLoginView alloc] init];
    view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    self.view = view;
    
    // save weak referance
    _aView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.aView.loginButton.target = self;
    self.aView.loginButton.action = @selector(didClickLoginButton:);
}

- (void)didClickLoginButton:(NSButton *)button {
    
    PPLLoginUser *user = [[PPLLoginUser alloc] initWithEmail:self.aView.emailField.stringValue password:self.aView.passwordField.stringValue];
    PPLAuthenticator *authenticator = [[PPLAuthenticator alloc] init];
    
    [authenticator authenticateUser:user withCompetion:^(BOOL success, NSError *error) {
        
        success = YES;
        
        if (success) {
            [self.windowController showViewControllerWithType:PPLMainViewControllerType];
        } else {
            NSAlert *alertSheet = [[NSAlert alloc] init];
            alertSheet.messageText = @"An error did appear";
            alertSheet.informativeText = error.localizedDescription;
            [alertSheet beginSheetModalForWindow:self.windowController.window completionHandler:nil];
        }
    }];
}

@end
