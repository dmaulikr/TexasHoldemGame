//
//  JoinViewController.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 14/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "JoinViewController.h"

@interface JoinViewController ()

@end

@implementation JoinViewController


-(JoiningNetworkModel*)joiningNetworkModel
{
    if (!_joiningNetworkModel) {
        _joiningNetworkModel = [[JoiningNetworkModel alloc]init];
    }
    return _joiningNetworkModel;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureAvailableHostsTableView];
    [self configureJoiningNetworkModel];
}

-(void)configureJoiningNetworkModel
{
    self.joiningNetworkModel.delegate = self;
    [self.joiningNetworkModel startHostsSearching];
}

-(void)configureAvailableHostsTableView
{
    self.availableHostsTableView.delegate = self;
    self.availableHostsTableView.dataSource = self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JoiningNetworkModelProtocol
-(void)listOfAvailableHostsDidChange
{
    [self.availableHostsTableView reloadData];
}

#pragma mark - UITableViewDelegate methods

#pragma mark - UITableViewDataSource methods
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* const kCellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:kCellIdentifier];
    }
    cell.textLabel.text = [self.joiningNetworkModel.availableHostsNames objectAtIndex:indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.joiningNetworkModel.availableHostsNames count];
}

@end
