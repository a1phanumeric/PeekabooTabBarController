//
//  PeekabooTabBarController.m
//  PeekabooTabBarController
//
//  Created by Ed Rackham on 15/11/2012.
//  Copyright (c) 2012 edrackham.com. All rights reserved.
//

#import "PeekabooTabBarController.h"

#define kTabBarBg               @"tabBar.png"
#define kTabBarOpenButton       @"tabBarBtnOpen.png"
#define kTabBarCloseButton      @"tabBarBtnClose.png"
#define kTabBarClosedBleed      5
#define kAnimationBounceHeight  8

NSString *const TAB_BAR_BUTTON_IMAGES[] = {@"tabBarBtn1", @"tabBarBtn2", @"tabBarBtn3", @"tabBarBtn4", @"tabBarBtn5", @"tabBarBtn6"};

@interface PeekabooTabBarController ()

@property (strong, nonatomic) UIButton *toggleButton;
@property (strong, nonatomic) UIView *tabBarView;
@property (strong, nonatomic) UIScrollView *tabBarScrollView;
@property (strong, nonatomic) UIButton *activeButton;
@property (assign, nonatomic) NSInteger totalTabBarHeight;
@property (assign, nonatomic) NSInteger openYPos;
@property (assign, nonatomic) NSInteger closedYPos;
@property (assign, nonatomic) BOOL isOpen;
@property (assign, nonatomic) BOOL isInitalised;

@end

@implementation PeekabooTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    CGSize usableFrameSize      = [self maximumUsableFrame].size;
    UIImage *openButtonImage    = [UIImage imageNamed:kTabBarOpenButton];
    UIImage *bgImage            = [UIImage imageNamed:kTabBarBg];
    
    _totalTabBarHeight  = openButtonImage.size.height + bgImage.size.height;
    _openYPos           = usableFrameSize.height - _totalTabBarHeight;
    _closedYPos         = _openYPos + bgImage.size.height - kTabBarClosedBleed;
    
    // Main container view
    _tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, _closedYPos, usableFrameSize.width, _totalTabBarHeight)];
    
    // Background image
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, openButtonImage.size.height, usableFrameSize.width, bgImage.size.height)];
    [bgImageView setImage:bgImage];
    [_tabBarView addSubview:bgImageView];
    
    // Show/hide button
    _toggleButton = [[UIButton alloc] initWithFrame:CGRectMake(usableFrameSize.width - openButtonImage.size.width, 0, openButtonImage.size.width, openButtonImage.size.height)];
    [_toggleButton setImage:openButtonImage forState:UIControlStateNormal];
    [_toggleButton addTarget:self action:@selector(toggleOpenState) forControlEvents:UIControlEventTouchUpInside];
    [_toggleButton setAdjustsImageWhenHighlighted:NO];
    [_tabBarView addSubview:_toggleButton];
    
    
    _tabBarScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(_tabBarView.frame.origin.x, openButtonImage.size.height, _tabBarView.frame.size.width, _tabBarView.frame.size.height - openButtonImage.size.height)];
    [_tabBarScrollView setShowsHorizontalScrollIndicator:NO];
    
    // Black background so bounce effect doesn't show the bottom of the container view
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(_tabBarScrollView.frame.origin.x, _tabBarScrollView.frame.origin.y, _tabBarScrollView.frame.size.width, _tabBarScrollView.frame.size.height+kAnimationBounceHeight)];
    [backgroundView setBackgroundColor:[UIColor blackColor]];
    [_tabBarView addSubview:backgroundView];
    [_tabBarView sendSubviewToBack:backgroundView];
    
    NSInteger tabBarItemIdx = 0;
    NSInteger xOffset       = 0;
    for(UITabBarItem *item in self.tabBar.items){
        
        UIImage *tabButtonImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@Off.png", TAB_BAR_BUTTON_IMAGES[tabBarItemIdx]]];
        NSInteger yOffset       = (_tabBarScrollView.frame.size.height - tabButtonImage.size.height) / 2;
        CGRect tabButtonFrame   = CGRectMake(xOffset, yOffset, tabButtonImage.size.width, tabButtonImage.size.height);
        UIButton *tabButton     = [[UIButton alloc] initWithFrame:tabButtonFrame];
        [tabButton setImage:tabButtonImage forState:UIControlStateNormal];
        [tabButton setTag:tabBarItemIdx];
        [tabButton addTarget:self action:@selector(selectTabButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_tabBarScrollView addSubview:tabButton];
        
        if(_activeButton == nil){
            _activeButton = tabButton;
        }
        
        tabBarItemIdx++;
        xOffset += tabButtonImage.size.width;
    }

    [_tabBarScrollView setContentSize:CGSizeMake(xOffset, _tabBarScrollView.frame.size.height)];
    [_tabBarView addSubview:_tabBarScrollView];
    
    [self.view addSubview:_tabBarView];
    [self selectTabButton:_activeButton];
    
    [self.moreNavigationController setDelegate:self];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    CGRect fullScreenRect   = [self maximumUsableFrame];
    fullScreenRect.origin.x = 0;
    fullScreenRect.origin.y = 0;
    self.tabBar.hidden = YES;
    [[self.view.subviews objectAtIndex:0] setFrame:fullScreenRect];
}

- (CGRect)maximumUsableFrame{
    CGRect maxFrame = [UIScreen mainScreen].applicationFrame;
    
    if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        NSInteger width, height;
        width   = maxFrame.size.height;
        height  = maxFrame.size.width;
        maxFrame.size.height = height;
        maxFrame.size.width = width;
    }
    
    if(self.navigationController)
        maxFrame.size.height -= self.navigationController.navigationBar.frame.size.height;
    
    return maxFrame;
}


- (void)toggleOpenState{
    
    [UIView animateWithDuration:0.15 animations:^{
        [_tabBarView setFrame:CGRectMake(_tabBarView.frame.origin.x, (_isOpen) ? _closedYPos : _openYPos-8, _tabBarView.frame.size.width, _tabBarView.frame.size.height)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            [_tabBarView setFrame:CGRectMake(_tabBarView.frame.origin.x, (_isOpen) ? _closedYPos : _openYPos, _tabBarView.frame.size.width, _tabBarView.frame.size.height)];
        }];
        _isOpen = !_isOpen;
        [_toggleButton setImage:(_isOpen) ? [UIImage imageNamed:kTabBarCloseButton] : [UIImage imageNamed:kTabBarOpenButton] forState:UIControlStateNormal];
    }];
}

- (void)selectTabButton:(id)sender{
    UIButton *theButton = (UIButton *)sender;
    
    UIImage *offImage   = [UIImage imageNamed:[NSString stringWithFormat:@"%@Off.png", TAB_BAR_BUTTON_IMAGES[_activeButton.tag]]];
    UIImage *onImage    = [UIImage imageNamed:[NSString stringWithFormat:@"%@On.png", TAB_BAR_BUTTON_IMAGES[theButton.tag]]];
    
    [_activeButton setImage:offImage forState:UIControlStateNormal];
    [theButton setImage:onImage forState:UIControlStateNormal];
    
    [self setSelectedIndex:theButton.tag];
    
    if(!_isInitalised){
        [self.selectedViewController viewWillAppear:NO];
        [self.selectedViewController viewDidAppear:NO];
        _isInitalised = YES;
    }
    
    _activeButton = theButton;
}

#pragma mark - UINavigationControllerDelegate

-(void)navigationController:(UINavigationController *)navigationController
     willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [navigationController setNavigationBarHidden:YES];
    NSLog(@"Nav Will Show");
    [viewController viewWillAppear:NO];
}
@end
