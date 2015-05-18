//
//  PPLiOSLoginViewController.m
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLiOSLoginViewController.h"
#import "PPLTableViewBasedUIView.h"

#import "PPLTextFieldTableViewCell.h"

#import "PPLSharedLoginController.h"
#import "PPLiOSEmployeesViewController.h"

static NSString * const PPLTableViewCellIdentifier = @"PPLTableViewCellIdentifier";

@interface PPLiOSLoginViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) PPLTableViewBasedUIView *aView;
@property (nonatomic, strong) PPLSharedLoginController *sharedLoginController;

@end

@implementation PPLiOSLoginViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _sharedLoginController = [[PPLSharedLoginController alloc] init];
    }
    return self;
}

- (void)loadView {
    
    PPLTableViewBasedUIView *view = [[PPLTableViewBasedUIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.tableView.scrollEnabled = NO;
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = view;
    _aView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Login for Access to Protected Area";
    
    self.aView.tableView.delegate = self;
    self.aView.tableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 2;
        default: return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0: {
            PPLTextFieldTableViewCell *cell = (PPLTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:PPLTextFieldTableViewCellIdentfier];
            if (cell == nil) {
                cell = [[PPLTextFieldTableViewCell alloc] init];
            }
            
            cell.textField.placeholder = indexPath.row == 0 ? @"Email" : @"Password";
            cell.textField.secureTextEntry = indexPath.row == 1;
          
            return cell;
        }
        case 1: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PPLTableViewCellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PPLTableViewCellIdentifier];
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.textColor = [UIColor redColor];
                cell.textLabel.text = @"Login";
            }

            return cell;
        }
            
        default:
            break;
    }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: return NO;
        default: return YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.sharedLoginController.user.email = [self textFromTextFieldInCellAtRow:0];
    self.sharedLoginController.user.password = [self textFromTextFieldInCellAtRow:1];
    
    [self.sharedLoginController loginWithCompetion:^(BOOL success, NSError *error) {
        
        success = YES;
        
        if (success) {
            PPLiOSEmployeesViewController *emplyeesViewController = [[PPLiOSEmployeesViewController alloc] init];
            emplyeesViewController.navigationItem.hidesBackButton = YES;
            [self.navigationController pushViewController:emplyeesViewController animated:YES];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Opps" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
    }];
}

- (NSString *)textFromTextFieldInCellAtRow:(NSUInteger)row {
    PPLTextFieldTableViewCell *cell = (PPLTextFieldTableViewCell *)[self.aView.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    return cell.textField.text;
}

@end
