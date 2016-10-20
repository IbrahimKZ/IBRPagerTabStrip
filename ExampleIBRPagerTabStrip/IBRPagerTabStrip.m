//
//  IBRPagerTabStrip.m
//  ExampleIBRPagerTabStrip
//
//  Created by Ibrahim on 19.10.16.
//  Copyright © 2016 iBro. All rights reserved.
//

#import "IBRPagerTabStrip.h"

@interface IBRPagerTabStrip () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollViewTabs;
@property (strong, nonatomic) UIScrollView *scrollViewPages;
@property (strong, nonatomic) UIView *viewPaging;
@property (strong, nonatomic) UIView *viewPageRunner;
@property (nonatomic) int page;
@property (strong, nonatomic) NSMutableArray *arrayBtns;

@end

@implementation IBRPagerTabStrip

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initProperties];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initProperties];
    }
    return self;
}

- (void)initProperties
{
    self.heightTab = 45;
    self.fontBtnTab = [UIFont systemFontOfSize:16];
    self.colorBtnTabTextActive = [UIColor whiteColor];
    self.colorBtnTabTextInactive = [UIColor colorWithWhite:1 alpha:.5];
    self.offsetXBtnTabText = 16;
    self.heightViewRunner = 1;
    self.colorViewRunner = [UIColor whiteColor];
    self.colorBackgroundViewRunner = [UIColor colorWithWhite:1 alpha:.5];
}

- (UIScrollView *)scrollViewTabs
{
    if (!_scrollViewTabs)
    {
        _scrollViewTabs = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.heightTab)];
        _scrollViewTabs.scrollEnabled = NO;
        _scrollViewTabs.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollViewTabs];
    }
    return _scrollViewTabs;
}

- (UIScrollView *)scrollViewPages
{
    if (!_scrollViewPages)
    {
        _scrollViewPages = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.scrollViewTabs.frame.size.height, self.frame.size.width, self.frame.size.height - self.scrollViewTabs.frame.size.height)];
        _scrollViewPages.showsHorizontalScrollIndicator = NO;
        _scrollViewPages.pagingEnabled = YES;
        _scrollViewPages.delegate = self;
        [self addSubview:_scrollViewPages];
    }
    return _scrollViewPages;
}


- (void)addTabs:(NSArray *)arrayTabs
{
    float offsetXTitle = 0;
    self.arrayBtns = [NSMutableArray array];
    for (int i = 0; i < arrayTabs.count; i++)
    {
        NSString *title = arrayTabs[i][@"title"];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(offsetXTitle, 0, 1, self.scrollViewTabs.frame.size.height);
        btn.titleLabel.font = self.fontBtnTab;
        [btn setTitleColor:self.colorBtnTabTextActive forState:UIControlStateSelected];
        [btn setTitleColor:self.colorBtnTabTextInactive forState:UIControlStateNormal];
        [btn setTitleColor:self.colorBtnTabTextActive forState:UIControlStateHighlighted];
        [btn setTitleColor:self.colorBtnTabTextActive forState:UIControlStateHighlighted|UIControlStateSelected];
        
        [btn setTitle:title forState:UIControlStateNormal];
        [btn sizeToFit];
        CGRect rect = btn.frame;
        rect.size.width += self.offsetXBtnTabText;
        rect.size.height = self.scrollViewTabs.frame.size.height;
        btn.frame = rect;
        btn.tag = i;
        [btn addTarget:self action:@selector(clickedSectionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollViewTabs addSubview:btn];
        
        offsetXTitle += btn.frame.size.width;
        
        [self.arrayBtns addObject:btn];
        
        UIView *view = arrayTabs[i][@"view"];
        rect = view.frame;
        rect.origin.x = i * self.scrollViewPages.frame.size.width;
        view.frame = rect;
        
        [self.scrollViewPages addSubview:view];
    }
    
    if (offsetXTitle < self.scrollViewTabs.frame.size.width)
    {
        float widthExtra = (self.scrollViewTabs.frame.size.width - offsetXTitle) / self.arrayBtns.count;
        offsetXTitle = 0;
        for (UIButton *btn in self.arrayBtns)
        {
            CGRect rect = btn.frame;
            rect.origin.x = offsetXTitle;
            rect.size.width += widthExtra;
            btn.frame = rect;
            offsetXTitle += btn.frame.size.width;
        }
    }
    
    self.scrollViewTabs.contentSize = CGSizeMake(offsetXTitle, self.scrollViewTabs.frame.size.height);
    self.scrollViewPages.contentSize = CGSizeMake(arrayTabs.count * self.scrollViewPages.frame.size.width, self.scrollViewPages.frame.size.height);
    
    [self addViewRunner];
    
    self.page = 0;
}

- (void)addViewRunner
{
    self.viewPaging = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollViewTabs.frame.size.height - self.heightViewRunner, self.scrollViewTabs.contentSize.width, self.heightViewRunner)];
    self.viewPaging.backgroundColor = self.colorBackgroundViewRunner;
    [self.scrollViewTabs addSubview:self.viewPaging];
    
    self.viewPageRunner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.heightViewRunner)];
    self.viewPageRunner.backgroundColor = self.colorViewRunner;
    [self.viewPaging addSubview:self.viewPageRunner];
}

- (CGRect)boundsForView
{
    return self.scrollViewPages.bounds;
}

- (UIButton *)btnWithIndex:(int)index
{
    return (index < self.arrayBtns.count) ? self.arrayBtns[index] : nil;
}

#pragma mark - Action methods

- (void)setPage:(int)page
{
    _page = page;
    
    for (UIButton *btn in self.arrayBtns)
    {
        btn.selected = (page == btn.tag) ? YES : NO;
    }
    
    CGRect rect = self.viewPageRunner.frame;
    rect.size.width = [self btnWithIndex:page].frame.size.width;
    rect.origin.x = [self btnWithIndex:page].frame.origin.x;
    
    [UIView animateWithDuration:.5 animations:^{
        self.viewPageRunner.frame = rect;
        self.scrollViewPages.contentOffset = CGPointMake(_page * self.scrollViewPages.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(centerBtnTab) withObject:nil afterDelay:.1];
    }];
    
    [self.delegate pageChangedToPage:_page];
}

- (void)clickedSectionBtn:(UIButton *)btn
{
    if (btn.tag != self.page)
    {
        self.page = (int)btn.tag;
    }
}

- (void)centerBtnTab
{
    float minX = 0;
    float maxX = self.scrollViewTabs.contentSize.width - (self.scrollViewTabs.frame.size.width);
    float offsetX = [self btnWithIndex:self.page].frame.origin.x - ((self.scrollViewTabs.frame.size.width - [self btnWithIndex:self.page].frame.size.width) / 2);
    
    if (offsetX < minX)
    {
        offsetX = minX;
    }
    else if (offsetX > maxX)
    {
        offsetX = maxX;
    }

    [UIView animateWithDuration:.5 animations:^{
        self.scrollViewTabs.contentOffset = CGPointMake(offsetX, 0);
    }];
}

#pragma mark - UIScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollViewPages == scrollView)
    {
        CGRect rect = self.viewPageRunner.frame;
        
        int page = (int)scrollView.contentOffset.x / scrollView.frame.size.width;
        if ((int)scrollView.contentOffset.x % (int)scrollView.frame.size.width == 0 && page > 0)
        {
            page--;
        }
        
        float offsetX = scrollView.contentOffset.x - (scrollView.frame.size.width * page);
        
        rect.size.width = ((1 - offsetX / scrollView.frame.size.width) * [self btnWithIndex:page].frame.size.width) + ((offsetX / scrollView.frame.size.width) * [self btnWithIndex:page + 1].frame.size.width);
        
        rect.origin.x = [self btnWithIndex:page].frame.origin.x + [self btnWithIndex:page].frame.size.width * (offsetX / scrollView.frame.size.width);
    
        self.viewPageRunner.frame = rect;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollViewPages == scrollView)
    {
        int index = (int)scrollView.contentOffset.x / scrollView.frame.size.width;
        if (self.page != index)
        {
            self.page = index;
        }
    }
}

@end
