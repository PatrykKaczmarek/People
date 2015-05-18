//
//  PPLContractTypeEditorViewController.m
//  People
//
//  Created by Patryk Kaczmarek on 18/05/15.
//  Copyright (c) 2015 netguru. All rights reserved.
//

#import "PPLContractTypeEditorViewController.h"
#import "PPLTableViewBasedUIView.h"

static NSString * const PPLTableViewCellIdentifier = @"PPLTableViewCellIdentifier";

@interface PPLContractTypeEditorViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) PPLTableViewBasedUIView *aView;
@property (nonatomic, assign) PPLContractType selectedContractType;
@property (copy, nonatomic) void (^saveBlock)(PPLContractType type);

@end

@implementation PPLContractTypeEditorViewController

- (instancetype)initWithSelectedContractType:(PPLContractType)type saveBlock:(void (^)(PPLContractType type))saveBlock {
    self = [super init];
    if (self) {
        _selectedContractType = type;
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
    
    self.title = @"Edit";
    
    self.aView.tableView.delegate = self;
    self.aView.tableView.dataSource = self;
    [self.aView.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PPLTableViewCellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PPLTableViewCellIdentifier];
    
    PPLUser *user = [[PPLUser alloc] init];
    user.contract = indexPath.row;
    
    cell.textLabel.text = user.contractToString;
    cell.accessoryType = self.selectedContractType == user.contract ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.saveBlock != NULL) {
        self.saveBlock(indexPath.row);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
