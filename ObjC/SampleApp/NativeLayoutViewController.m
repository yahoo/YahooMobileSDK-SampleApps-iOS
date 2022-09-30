///
///  @file
///  @brief Implementation for NativeLayoutViewController
///
///  @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

#import "NativeLayoutViewController.h"

static NSString *const kSampleAppNativeAdPlacementID = @"203891";
static NSString *const kTallLayoutName = @"TallLayout";
static NSString *const kShortLayoutName = @"ShortLayout";

static const CGFloat kFadeInOutDuration = 0.3;
static const CGFloat kStandardUIComponentSpace = 20.0;

@interface NativeLayoutViewController()
@property (nonatomic, strong) UIView *nativeAdContainer;
@property (nonatomic, strong) IBOutlet UIButton *requestButton;
@property (nonatomic, strong) IBOutlet UIButton *showButton;
@property (nonatomic) BOOL firstRequest;
@end

@implementation NativeLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Native Layout";
    
    self.showButton.enabled = NO;
    [self requestAd:self];
    self.firstRequest = YES;
}

#pragma mark - Layout

- (void)removeNativeAdContainer {
    [self.nativeAdContainer removeFromSuperview];
    self.nativeAdContainer = nil;
}

- (void)setupNativeContainer:(CGSize)size {
    [self removeNativeAdContainer];
}

#pragma mark - User Interaction

- (IBAction)requestAd:(id)sender {
    self.requestButton.enabled = NO;
    
    __weak NativeLayoutViewController *weakSelf = self;
    [UIView animateWithDuration:kFadeInOutDuration animations:^{
        weakSelf.nativeAdContainer.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf removeNativeAdContainer];
    }];
}

- (IBAction)showAd:(id)sender {
    self.showButton.enabled = NO;
    
    [self setupNativeContainer:self.view.bounds.size];

    [UIView animateWithDuration:kFadeInOutDuration animations:^{
        self.nativeAdContainer.alpha = 1.0;
        self.requestButton.enabled = YES;
    }];
}

#pragma mark - Helpers

- (CGFloat)availableHeightForSize:(CGSize)size {
    CGFloat availableHeight = size.height;
    availableHeight -= (size.height - self.requestButton.frame.origin.y);  // space for the buttons
    availableHeight -= self.navigationController.navigationBar.frame.size.height;           // space for the nav bar
    availableHeight -= (2 * kStandardUIComponentSpace);                                     // standard UI margins
    return availableHeight;
}

#pragma mark - Rotation

- (void)viewDidTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    // Support for rotation in iOS 8.
    if (self.nativeAdContainer) {
        [self setupNativeContainer:size];
    }
}

@end
