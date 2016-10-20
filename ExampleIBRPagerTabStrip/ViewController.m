//
//  ViewController.m
//  ExampleIBRPagerTabStrip
//
//  Created by Ibrahim on 19.10.16.
//  Copyright © 2016 iBro. All rights reserved.
//

#import "ViewController.h"
#import "IBRPagerTabStrip.h"

@interface ViewController () <IBRPagerTabStripDelegate>
@property (weak, nonatomic) IBOutlet IBRPagerTabStrip *pagerTabStrip;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(addTabStrip) withObject:nil afterDelay:.5];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)addTabStrip
{
    UIView *view1 = [[UIView alloc] initWithFrame:[self.pagerTabStrip boundsForView]];
    view1.backgroundColor = [UIColor redColor];
    
    UIView *view2 = [[UIView alloc] initWithFrame:[self.pagerTabStrip boundsForView]];
    view2.backgroundColor = [UIColor greenColor];
    
    UIView *view3 = [[UIView alloc] initWithFrame:[self.pagerTabStrip boundsForView]];
    view3.backgroundColor = [UIColor yellowColor];
    
    UIView *view4 = [[UIView alloc] initWithFrame:[self.pagerTabStrip boundsForView]];
    view4.backgroundColor = [UIColor purpleColor];
    
    UIView *view5 = [[UIView alloc] initWithFrame:[self.pagerTabStrip boundsForView]];
    view5.backgroundColor = [UIColor blueColor];
    
    UIView *view6 = [[UIView alloc] initWithFrame:[self.pagerTabStrip boundsForView]];
    view6.backgroundColor = [UIColor orangeColor];
    
    UIView *view7 = [[UIView alloc] initWithFrame:[self.pagerTabStrip boundsForView]];
    view7.backgroundColor = [UIColor brownColor];
    
    /* --- Change this properties to customize your PagerTabStrip -- */

//    self.pagerTabStrip.heightTab = 45;
//    self.pagerTabStrip.fontBtnTab = [UIFont systemFontOfSize:16];
//    self.pagerTabStrip.colorBtnTabTextActive = [UIColor redColor];
//    self.pagerTabStrip.colorBtnTabTextInactive = [UIColor colorWithWhite:1 alpha:.5];
//    self.pagerTabStrip.offsetXBtnTabText = 16;
//    self.pagerTabStrip.heightViewRunner = 1;
//    self.pagerTabStrip.colorViewRunner = [UIColor whiteColor];
//    self.pagerTabStrip.colorBackgroundViewRunner = [UIColor colorWithWhite:1 alpha:.5];
    
    self.pagerTabStrip.delegate = self;
    
    [self.pagerTabStrip addTabs:@[@{@"title": @"All", @"view": view1},
                                  @{@"title": @"News", @"view": view2},
                                  @{@"title": @"Analytics", @"view": view3},
                                  @{@"title": @"Accidents", @"view": view4},
                                  @{@"title": @"Advices", @"view": view5},
                                  @{@"title": @"FAQ", @"view": view6},
                                  @{@"title": @"Contacts", @"view": view7}
                                  ]];
}

#pragma mark - IBRPagerTabStrip delegate methods

- (void)pageChangedToPage:(int)page
{
    NSLog(@"page changed to: %i", page);
}


@end
