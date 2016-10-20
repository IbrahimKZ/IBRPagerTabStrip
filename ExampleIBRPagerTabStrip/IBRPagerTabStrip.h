//
//  IBRPagerTabStrip.h
//  ExampleIBRPagerTabStrip
//
//  Created by Ibrahim on 19.10.16.
//  Copyright © 2016 iBro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IBRPagerTabStripDelegate <NSObject>

@optional

- (void)pageChangedToPage:(int)page;

@end

@interface IBRPagerTabStrip : UIView

@property (nonatomic, assign) id <IBRPagerTabStripDelegate> delegate;
@property float heightTab, offsetXBtnTabText, heightViewRunner;
@property (nonatomic, strong) UIFont *fontBtnTab;
@property (nonatomic, strong) UIColor *colorBtnTabTextActive, *colorBtnTabTextInactive, *colorViewRunner, *colorBackgroundViewRunner;

- (void)addTabs:(NSArray *)arrayTabs; // @[@{@"title": @"Title", @"view": UIView}]
- (CGRect)boundsForView;

@end
