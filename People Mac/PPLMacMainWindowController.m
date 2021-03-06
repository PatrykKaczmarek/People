//
//  PPLMainWindowController.m
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLMacMainWindowController.h"
#import "PPLMacLoginViewController.h"
#import "PPLMacMainViewController.h"

@interface PPLMacMainWindowController ()

@property (nonatomic, strong) NSViewController *currentController;

@end

@implementation PPLMacMainWindowController

- (instancetype)init {
    return [self initWithWindowNibName:@"PPLMainWindow"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self showViewControllerWithType:PPLLoginViewControllerType];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.window.minSize = NSMakeSize(600, 550);
    self.window.maxSize = NSMakeSize(600, 550);
}

- (void)showViewControllerWithType:(PPLViewControllerType)type {
    
    NSViewController *controller;
    NSString *title;
    
    switch (type) {
        case PPLMainViewControllerType:
            controller = [[PPLMacMainViewController alloc] init];
            title = @"People";
            break;
        case PPLLoginViewControllerType:
            controller = [[PPLMacLoginViewController alloc] initWithWindowController:self];
            title = @"Login";
            break;
            
        default:
            break;
    }
    
    if (self.currentController) {
        [self.currentController.view removeFromSuperview];
    }
    
    self.currentController = controller;
    [self.window setTitle:title];
    
    [self.window.contentView addSubview:controller.view];
    [controller.view setFrame: ((NSView *)self.window.contentView).bounds];
}

@end
