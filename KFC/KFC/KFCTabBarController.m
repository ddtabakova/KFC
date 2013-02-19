//
//  KFCTabBarController.m
//  KFC
//
//  Created by Dobby on 2/15/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "KFCTabBarController.h"

@interface KFCTabBarController () <UITabBarControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, assign) int prevSelectedIndex;

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
    self.delegate = self;
    self.prevSelectedIndex = 0;
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
    [self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"transparent.png"]];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"kfc-tabbar-selected-%d.png", [self.tabBar.selectedItem tag]]]];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [self.tabBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"kfc-tabbar-selected-%d.png", [item tag]]]];
}

#pragma mark - UITabBarControllerDelegate methods

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    int selected = self.prevSelectedIndex;
    if (self.selectedIndex != 1) {
        self.prevSelectedIndex = self.selectedIndex;
    }
    if ([viewController isEqual:[tabBarController.viewControllers objectAtIndex:1]]) {
        [self setSelectedIndex:selected];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Доставка" message:@"Искате ли да направите поръчка по телефона?" delegate:self cancelButtonTitle:@"Не" otherButtonTitles:@"Да", nil];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"] ) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:35970011999"]]];
        } else {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Грешка" message:@"Не може да бъде проведен разговор от това устройство." delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles:nil];
            [alert show];
        }
    }
    [self setSelectedIndex:self.prevSelectedIndex];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"kfc-tabbar-selected-%d.png", self.prevSelectedIndex]]];
}

@end
