//
//  KFCTabBarController.m
//  KFC
//
//  Created by Dobby on 2/15/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "KFCTabBarController.h"

@interface KFCTabBarController ()

@end

@implementation KFCTabBarController

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
    [self customizeTabBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customizeTabBar {
    for (int i = 0; i < self.tabBar.items.count; ++i) {
        [[self.tabBar.items objectAtIndex:i] setTag:i];
    }
    
    [self.tabBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"kfc-tabbar-selected-%d.png", [self.tabBar.selectedItem tag]]]];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [self.tabBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"kfc-tabbar-selected-%d.png", [item tag]]]];
}


@end
