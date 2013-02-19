//
//  KFCMenuViewController.m
//  KFC
//
//  Created by Stanimir Nikolov on 2/18/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "KFCMenuViewController.h"
#import "DataManager.h"
#import "Type.h"
#import "KFCMenuItemsViewController.h"

@interface KFCMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSFetchedResultsController *datasource;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation KFCMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSManagedObjectContext *moc = [DataManager managedObjectContext];
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Type" inManagedObjectContext:moc];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    self.datasource = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:@"types.cache"];
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"TypeItems"]) {
        KFCMenuItemsViewController *vc = [segue destinationViewController];
        vc.items = [NSArray arrayWithArray:((Type*)[self.datasource objectAtIndexPath:self.selectedIndexPath]).typeToMenu.allObjects];
    }
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = ((Type*)[self.datasource objectAtIndexPath:indexPath]).name;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"accesory.png"]];
    cell.backgroundColor = [UIColor colorWithWhite:1.f alpha:.38f];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    self.selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"TypeItems" sender:self];
}

- (IBAction)favoritesButtonTapped:(id)sender {
}
@end
