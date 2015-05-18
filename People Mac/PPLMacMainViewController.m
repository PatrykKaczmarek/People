//
//  PPLMainViewController.m
//  People iOS
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLMacMainViewController.h"
#import "PPLSharedUserController.h"

#define PPLCellIdentifierName @"PPLCellIdentifierName"
#define PPLCellIdentifierRole @"PPLCellIdentifierRole"

@interface PPLMacMainViewController ()

@property (weak) IBOutlet NSTextField *nameField;
@property (weak) IBOutlet NSTextField *locationField;
@property (weak) IBOutlet NSMatrix *contractPicker;
@property (weak) IBOutlet NSComboBox *rolePicker;
@property (unsafe_unretained) IBOutlet NSTextView *noteTextView;
@property (weak) IBOutlet NSButton *saveButton;
@property (weak) IBOutlet NSButton *deleteButton;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSButton *updateButton;

@property (strong, nonatomic) PPLSharedUserController *userController;
@property (strong, nonatomic) PPLUser *highlightedUser;

@end

@interface PPLMacMainViewController () <NSTableViewDataSource, NSTableViewDelegate>

@end

@implementation PPLMacMainViewController

- (instancetype)init {
    self = [self initWithNibName:@"PPLMainView" bundle:[NSBundle mainBundle]];
    if (self) {
        _userController = [[PPLSharedUserController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.deleteButton.enabled = NO;
    self.updateButton.enabled = NO;
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return [self.userController.users count];
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSTableCellView *cell;
    PPLUser *user = [self.userController users][row];
    
    if ([tableColumn.identifier isEqualToString:PPLCellIdentifierName]) {
        
        cell = [tableView makeViewWithIdentifier:PPLCellIdentifierName owner:self];
        cell.textField.stringValue = user.name;
        
    } else if ([tableColumn.identifier isEqualToString:PPLCellIdentifierRole]) {
        
        cell = [tableView makeViewWithIdentifier:PPLCellIdentifierName owner:self];
        cell.textField.stringValue = user.role;
    }

    return cell;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    
    NSInteger row = [self.tableView selectedRow];

    if (row > -1) {
        self.highlightedUser = [self.userController users][row];
        [self populateFieldsWithUser:self.highlightedUser];
    } else {
        self.highlightedUser = nil;
        [self clearFields];
    }
}

#pragma mark - Action - target

- (IBAction)didClickSaveButton:(NSButton *)sender {

    if (!self.highlightedUser) {
        self.highlightedUser = [[PPLUser alloc] init];
    }
    [self saveUser];
}

- (IBAction)didClickDeleteButton:(NSButton *)sender {
    
    if (self.highlightedUser) {
        [self.userController removeUser:self.highlightedUser];
        self.highlightedUser = nil;
        [self.tableView reloadData];
        [self clearFields];
    }
}

- (IBAction)didClickUpdateButton:(NSButton *)sender {
    [self saveUser];
}

#pragma mark - Private

- (void)saveUser {
    self.highlightedUser.name = self.nameField.stringValue;
    self.highlightedUser.location = self.locationField.stringValue;
    self.highlightedUser.contract = self.contractPicker.selectedRow;
    self.highlightedUser.role = self.rolePicker.stringValue;
    self.highlightedUser.notes = [self.noteTextView.string copy];
    
    NSError *error = [self.highlightedUser validate];
    if (error) {
        self.highlightedUser = nil;
        [NSApp presentError:error];
        return;
    }
    
    [self.userController saveUser:self.highlightedUser];
    [self.tableView reloadData];
    self.highlightedUser = nil;
    [self clearFields];
}

- (void)setHighlightedUser:(PPLUser *)highlightedUser {
    _highlightedUser = highlightedUser;
    self.deleteButton.enabled = (highlightedUser != nil);
    self.saveButton.enabled = (highlightedUser == nil);
    self.updateButton.enabled = (highlightedUser != nil);
}

- (void)populateFieldsWithUser:(PPLUser *)user {
    
    self.nameField.stringValue = user.name;
    self.locationField.stringValue = user.location;
    [self.contractPicker selectCellAtRow:user.contract column:0];
    self.rolePicker.stringValue = user.role;
    self.noteTextView.string = user.notes;
}

- (void)clearFields {
    
    self.nameField.stringValue = @"";
    self.locationField.stringValue = @"";
    [self.contractPicker selectCellAtRow:0 column:0];
    self.rolePicker.stringValue = @"";
    self.noteTextView.string = @"";
}

@end
