//
//  PPLLoginViewController.m
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLMacLoginViewController.h"
#import "PPLMacLoginView.h"

#import "PPLMacMainWindowController.h"
#import "PPLSharedLoginController.h"

@interface PPLMacLoginViewController ()

@property (nonatomic, strong) PPLMacLoginView *aView;
@property (nonatomic, weak) PPLMacMainWindowController *windowController;
@property (nonatomic, strong) PPLSharedLoginController *sharedLoginController;

@end

@implementation PPLMacLoginViewController

- (instancetype)initWithWindowController:(PPLMacMainWindowController *)windowController {
    self = [super init];
    if (self) {
        _windowController = windowController;
        _sharedLoginController = [[PPLSharedLoginController alloc] init];
    }
    return self;
}

- (void)loadView {
    
    PPLMacLoginView *view = [[PPLMacLoginView alloc] init];
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
    
    self.sharedLoginController.user.email = self.aView.emailField.stringValue;
    self.sharedLoginController.user.password = self.aView.passwordField.stringValue;
    
    [self.sharedLoginController loginWithCompetion:^(BOOL success, NSError *error) {
        
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
