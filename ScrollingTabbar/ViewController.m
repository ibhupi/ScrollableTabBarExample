//
//  ViewController.m
//  ScrollingTabbar
//
//  Created by Bhupendra Singh on 6/7/15.
//  Copyright (c) 2015 Bhupendra Singh. All rights reserved.
//

#import "ViewController.h"
#import "WTScrollableTabbar.h"

@interface ViewController () <WTScrollableTabbarDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGFloat height = 50;
    CGFloat yPos = CGRectGetMaxY(self.view.window.bounds) - height;
    CGRect rect = CGRectMake(0, yPos, CGRectGetWidth(self.view.window.bounds), height);
    
    WTScrollableTabbar *scrollableTabbar = [WTScrollableTabbar scrollableTabbarWithTabItems:[self tabItems] frame:rect tabBarDelegate:self];
    [self.view addSubview:scrollableTabbar];
    
    // Optional
    scrollableTabbar.tabSize = CGSizeMake(50, 50);
}

- (NSArray *)tabItems
{
    static NSMutableArray *tabItems;
    if (tabItems)
    {
        return tabItems;
    }
    NSString *imagesString = @"4sq.png,Instagram.png,facebook.png,skype.png,wordpress.png,Behance.png,Rss.png,g+.png,tumblr.png,youtube.png,Forrst.png,dribbble.png,linkedin.png,twitter.png,Github.png,evernote.png,pinterest.png,vimeo.png";
    NSArray *imageStringArray = [imagesString componentsSeparatedByString:@","];
    tabItems = [NSMutableArray new];
    for (NSString *imageName in imageStringArray)
    {
        UIImage *image = [UIImage imageNamed:imageName];
        NSString *name = [imageName stringByDeletingPathExtension];
        WTScrollableTabbarTabItem *tabItem = [WTScrollableTabbarTabItem tabItemWithText:name image:image];
        if (!tabItem)
        {
            continue;
        }
        tabItem.textColor = [self _randomColor];
        [tabItems addObject:tabItem];
    }
    return tabItems;
}

#pragma mark - WTScrollableTabbarDelegate

- (void)scrollableTabbar:(WTScrollableTabbar *)tabbar
         didTapOnTabItem:(WTScrollableTabbarTabItem *)tabItem
{
    NSLog(@"%s", __FUNCTION__);
    self.imageView.image = tabItem.image;
    self.label.text = tabItem.text;
}


#pragma mark - Other helper

/**
 * Helper function for random color
 * https://gist.github.com/kylefox/1689973
 */
- (UIColor *)_randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.7;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.4;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}


@end
