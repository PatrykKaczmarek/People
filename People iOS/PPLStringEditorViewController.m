//
//  PPLStringEditorViewController.m
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLStringEditorViewController.h"
#import "PPLTableViewBasedUIView.h"

#import "PPLTextFieldTableViewCell.h"

@interface PPLStringEditorViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) PPLTableViewBasedUIView *aView;
@property (nonatomic, strong) NSString *stringToEdit;
@property (copy, nonatomic) void (^saveBlock)(NSString *string);

@end

@implementation PPLStringEditorViewController

- (instancetype)initWithStringToEdit:(NSString *)stringToEdit saveBlock:(void (^)(NSString *string))saveBlock {
    self = [super init];
    if (self) {
        _stringToEdit = stringToEdit;
        _saveBlock = saveBlock;
    }
    return self;
}

- (void)loadView {
    
    PPLTableViewBasedUIView *view = [[PPLTableViewBasedUIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    view.tableView.scrollEnabled = NO;
    self.view = view;
    _aView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Edit";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(didTapSaveBarButtonItem:)];
    
    self.aView.tableView.delegate = self;
    self.aView.tableView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    PPLTextFieldTableViewCell *cell = [self textFieldCell];
    [cell.textField becomeFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PPLTextFieldTableViewCell *cell = (PPLTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:PPLTextFieldTableViewCellIdentfier];
    
    if (cell == nil) {
        cell = [[PPLTextFieldTableViewCell alloc] init];
    }
    
    cell.textField.text = [self.stringToEdit copy];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)didTapSaveBarButtonItem:(UIBarButtonItem *)button {
    
    if (self.saveBlock != NULL) {
        PPLTextFieldTableViewCell *cell = [self textFieldCell];
        self.saveBlock(cell.textField.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (PPLTextFieldTableViewCell *)textFieldCell {
    return (PPLTextFieldTableViewCell *)[self.aView.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

@end
