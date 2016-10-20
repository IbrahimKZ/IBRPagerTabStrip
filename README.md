# IBRPagerTabStrip

**IBRPagerTabStrip** is a subclass of UIView that allows you to create <a href="https://developer.android.com/reference/android/support/v4/view/PagerTabStrip.html" target="_blank">Android PagerTabStrip</a> element in your iOS application. 

Look at the example below.

![ibrpagertabstrip](https://cloud.githubusercontent.com/assets/1129619/19551713/74db6d22-96ce-11e6-97c1-023f7bed7216.gif)

## How to use it in your project

**IBRPagerTabStrip** is written in _Objective-C_. It is very simple to use in your project. You just need to drag and drop 2 files _IBRPagerTabStrip.h_ and _IBRPagerTabStrip.m_ to your project. Add **IBRPagerTabStrip view** to your view controller's view. You can add it in storyboard or in code (as addSubview:). After that set it's data (titles and views). Look code example below.
```objective-c
UIView *view1 = [[UIView alloc] initWithFrame:[self.pagerTabStrip boundsForView]];
view1.backgroundColor = [UIColor redColor];
    
UIView *view2 = [[UIView alloc] initWithFrame:[self.pagerTabStrip boundsForView]];
view2.backgroundColor = [UIColor greenColor];

[self.pagerTabStrip addTabs:@[@{@"title": @"Section 1", @"view": view1},
                              @{@"title": @"Section 2", @"view": view2}]];
```
Method _boundsForView_ returns size of one page which you can use in you child views.
You can see how to use it in this example project.

### How to customize it
We added some public properties, so you can customize your **PagerTabStrip**. Look at the code samples below.
```objective-c
self.pagerTabStrip.heightTab = 45;
self.pagerTabStrip.fontBtnTab = [UIFont systemFontOfSize:16];
self.pagerTabStrip.colorBtnTabTextActive = [UIColor redColor];
self.pagerTabStrip.colorBtnTabTextInactive = [UIColor colorWithWhite:1 alpha:.5];
self.pagerTabStrip.offsetXBtnTabText = 16;
self.pagerTabStrip.heightViewRunner = 1;
self.pagerTabStrip.colorViewRunner = [UIColor whiteColor];
self.pagerTabStrip.colorBackgroundViewRunner = [UIColor colorWithWhite:1 alpha:.5];
```
### Delegate methods
**IBRPagerTabStrip** has _@optional_ delegate methods. If you set your ViewController as delegate of **IBRPagerTabStrip** you can handle event when new page is selected. Look at the sample below.
```objective-c
...
self.pagerTabStrip.delegate = self;
...

#pragma mark - IBRPagerTabStrip delegate methods

- (void)pageChangedToPage:(int)page
{
    NSLog(@"page changed to: %i", page);
}
```
That's all
##Author
Ibrakhim Nikishin ([Github](https://github.com/IbrahimKZ), [LinkedIn](https://www.linkedin.com/in/ibrakhim-nikishin-a496bab7))
##License
[The Unlicense](http://choosealicense.com/licenses/unlicense/) You can use it as you want :-)
