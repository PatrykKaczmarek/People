//
//  PPLiOSMainViewController.m
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLiOSEmployeesViewController.h"
#import "PPLTableViewBasedUIView.h"

#import "PPLSharedUserController.h"
#import "PPLEmployeeFormViewController.h"

static NSString * const PPLTableViewCellIdentifier = @"PPLTableViewCellIdentifier";

@interface PPLiOSEmployeesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) PPLTableViewBasedUIView *aView;
@property (nonatomic, strong) PPLSharedUserController *sharedUserController;

@end

@implementation PPLiOSEmployeesViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _sharedUserController = [[PPLSharedUserController alloc] init];
    }
    return self;
}

- (void)loadView {
    
    PPLTableViewBasedUIView *view = [[PPLTableViewBasedUIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = view;
    _aView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Employees";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(didTapAddBarButtonItem:)];
    
    self.aView.tableView.delegate = self;
    self.aView.tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sharedUserController.users.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PPLUser *user = self.sharedUserController.users[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PPLTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PPLTableViewCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Name: %@", user.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Role: %@", user.role];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PPLUser *employee = self.sharedUserController.users[indexPath.row];
    [self pushEmployeeFormWithEmployee:employee];
}

- (void)didTapAddBarButtonItem:(UIBarButtonItem *)button {
    
    PPLUser *employee = [[PPLUser alloc] init];
    [self pushEmployeeFormWithEmployee:employee];
}

- (void)pushEmployeeFormWithEmployee:(PPLUser *)employee {
    
    PPLEmployeeFormViewController *formViewController = [[PPLEmployeeFormViewController alloc] initWithEmployee:employee saveBlock:^(PPLUser *employee) {

        [self.sharedUserController saveUser:employee];
        [self.aView.tableView reloadData];
    }];
    [self.navigationController pushViewController:formViewController animated:YES];
}

@end
