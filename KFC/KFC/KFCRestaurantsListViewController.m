//
//  RestaurantsListViewController.m
//  KFC
//
//  Created by Nikola Kirev on 18/02/2013.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KFCRestaurantsListViewController.h"
#import "DataManager.h"
#import "City.h"
#import "KFCRestaurantCell.h"
#import "Restaurant.h"
#import "KFCRestaurantsDetailViewController.h"

@interface KFCRestaurantsListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSFetchedResultsController *datasource;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

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
    
    NSManagedObjectContext *moc = [DataManager managedObjectContext];
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"City" inManagedObjectContext:moc];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    self.datasource = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:@"city.cache"];
    
    NSError* error;
	BOOL success = [self.datasource performFetch:&error];
    
    if (!success) {
        NSLog(@"The objects cannot be retrieved");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backToMapPressed{
    [self performSegueWithIdentifier:@"BackToMap" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ShowDetailFromList"]) {
        KFCRestaurantsDetailViewController *destinationVC = [segue destinationViewController];
        [destinationVC setRestaurant:sender];
    }
}

#pragma mark - UITableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasource.fetchedObjects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[(City *)[self.datasource.fetchedObjects objectAtIndex:section] cityToRestaurant] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 6.0f, tableView.frame.size.width, 24.0f)];
    [headerView setBackgroundColor:[UIColor colorWithRed:199.0f/255.0f green:17.0f/255.0f blue:44.0f/255.0f alpha:1.0]];
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 5.0f, tableView.frame.size.width, 20.0f)];
    [cityLabel setBackgroundColor:[UIColor clearColor]];
    [cityLabel setTextColor:[UIColor  colorWithRed:218.0f/255.0f green:154.0f/255.0f blue:20.0f/255.0f alpha:1.0]];
    [cityLabel setText:[(City *)[self.datasource.fetchedObjects objectAtIndex:section] name]];
    [cityLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19.0f]];
    [headerView addSubview:cityLabel];
    headerView.layer.borderColor = [UIColor  colorWithRed:218.0f/255.0f green:154.0f/255.0f blue:20.0f/255.0f alpha:1.0].CGColor;
    headerView.layer.borderWidth = 2.0f;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"RestaurantCell";
    KFCRestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    Restaurant *currentRestaurant = (Restaurant *)[[[(City *)[self.datasource.fetchedObjects objectAtIndex:indexPath.section] cityToRestaurant] allObjects] objectAtIndex:indexPath.row];
    
    [cell.photoImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", currentRestaurant.name]]];
    [cell.nameLabel setText:[currentRestaurant name]];
    [cell.addressLabel setText:[currentRestaurant address]];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowDetailFromList" sender:(Restaurant *)[[[(City *)[self.datasource.fetchedObjects objectAtIndex:indexPath.section] cityToRestaurant] allObjects] objectAtIndex:indexPath.row]];
}

@end
