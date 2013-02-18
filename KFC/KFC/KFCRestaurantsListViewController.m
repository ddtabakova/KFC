//
//  RestaurantsListViewController.m
//  KFC
//
//  Created by Nikola Kirev on 18/02/2013.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "KFCRestaurantsListViewController.h"

@interface KFCRestaurantsListViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation KFCRestaurantsListViewController

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
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"Карта" style:UIBarButtonItemStyleBordered target:self action:@selector(backToMapPressed)];
    [mapButton setTintColor:[UIColor colorWithRed:213.0f/255.0f green:38.0f/255.0f blue:55.0f/255.0f alpha:1.0]];
    self.navigationItem.rightBarButtonItem = mapButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backToMapPressed{
    [self performSegueWithIdentifier:@"BackToMap" sender:nil];
}

#pragma mark - UITableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //cell.textLabel.text = ((Type*)[self.datasource objectAtIndexPath:indexPath]).name;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"accesory.png"]];
    cell.backgroundColor = [UIColor colorWithWhite:1.f alpha:.38f];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
