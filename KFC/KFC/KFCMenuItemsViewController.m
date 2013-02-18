//
//  KFCTypeItemsViewController.m
//  KFC
//
//  Created by Stanimir Nikolov on 2/18/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "KFCMenuItemsViewController.h"
#import "Menu.h"
#import "KFCMenuItemCell.h"

@interface KFCMenuItemsViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation KFCMenuItemsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    KFCMenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"KFCMenuItemCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.itemNameLabel.text = ((Menu*)[self.items objectAtIndex:indexPath.row]).name;
    cell.itemPriceLabel.text = [NSString stringWithFormat:@"%.2fлв", ((Menu*)[self.items objectAtIndex:indexPath.row]).price.doubleValue];
    cell.itemDescriptionLabel.text = ((Menu*)[self.items objectAtIndex:indexPath.row]).desc;
    [cell.itemImageView setImage:[UIImage imageNamed:((Menu*)[self.items objectAtIndex:indexPath.row]).image]];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(.0f, .0f, 320.f, 30.f)];
    [bg setBackgroundColor:UIColor.clearColor];
    return bg;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(.0f, .0f, 320.f, 10.f)];
    [bg setBackgroundColor:UIColor.clearColor];
    return bg;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
}

@end
