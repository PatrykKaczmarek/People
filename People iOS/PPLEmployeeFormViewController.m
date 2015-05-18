//
//  PPLEmployeeFormViewController.m
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLEmployeeFormViewController.h"
#import "PPLTableViewBasedUIView.h"

#import "PPLUser.h"
#import "PPLColumnTableViewCell.h"
#import "PPLStringEditorViewController.h"
#import "PPLContractTypeEditorViewController.h"

#define kNameRow 0
#define kLocationRow 1
#define kRoleRow 2
#define kContractRow 3
#define kNotesRow 4
#define kNumberOfRows 5

@interface PPLEmployeeFormViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) PPLTableViewBasedUIView *aView;
@property (nonatomic, strong) PPLUser *employee;
@property (copy, nonatomic) void (^saveBlock)(PPLUser *employee);

@end

@implementation PPLEmployeeFormViewController

- (instancetype)initWithEmployee:(PPLUser *)employee saveBlock:(void (^)(PPLUser *employee))saveBlock {
    self = [super init];
    if (self) {
        _employee = employee;
        _saveBlock = saveBlock;
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
    
    self.title = @"Employee Details";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(didTapSaveBarButtonItem:)];
    
    self.aView.tableView.delegate = self;
    self.aView.tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kNumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PPLColumnTableViewCell *cell = (PPLColumnTableViewCell *)[tableView dequeueReusableCellWithIdentifier:PPLColumnTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[PPLColumnTableViewCell alloc] init];
    }
    
    switch (indexPath.row) {
        case kNameRow:
            cell.textLabel.text = @"Name:";
            cell.detailTextLabel.text = self.employee.name;
            break;
        case kLocationRow:
            cell.textLabel.text = @"Location:";
            cell.detailTextLabel.text = self.employee.location;
            break;
        case kRoleRow:
            cell.textLabel.text = @"Role:";
            cell.detailTextLabel.text = self.employee.role;
            break;
        case kContractRow:
            cell.textLabel.text = @"Contract:";
            cell.detailTextLabel.text = [self.employee contractToString];
            break;
        case kNotesRow:
            cell.textLabel.text = @"Notes";
            cell.detailTextLabel.text = self.employee.notes;
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *controllerToPush;
    
    if (indexPath.row == kContractRow) {
        
        controllerToPush = [[PPLContractTypeEditorViewController alloc] initWithSelectedContractType:self.employee.contract saveBlock:^(PPLContractType type) {
            self.employee.contract = type;
            [tableView reloadData];
        }];
        
    } else {
        
        NSString *string = [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text;
        
        controllerToPush = [[PPLStringEditorViewController alloc] initWithStringToEdit:string saveBlock:^(NSString *string) {
            [self saveString:string toModelFromIndexPath:indexPath];
            [tableView reloadData];
        }];
    }
    
    [self.navigationController pushViewController:controllerToPush animated:YES];
}

- (void)didTapSaveBarButtonItem:(UIBarButtonItem *)button {
    
    NSError *error = [self.employee validate];
    if (error) {
        [[[UIAlertView alloc] initWithTitle:@"Opps" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (self.saveBlock != NULL) {
        self.saveBlock(self.employee);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveString:(NSString *)string toModelFromIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case kNameRow:
            self.employee.name = string;
            break;
        case kLocationRow:
            self.employee.location = string;
            break;
        case kRoleRow:
            self.employee.role = string;
            break;
        case kContractRow:
            break;
        case kNotesRow:
            self.employee.notes = string;
            break;
    }
}

@end
