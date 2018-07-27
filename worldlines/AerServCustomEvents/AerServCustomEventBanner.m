//
//  AerServCustomEventBanner.m
//  AppNexusSample
//
//  Created by Hall on 8/17/16.
//  Copyright © 2016 Aerserv. All rights reserved.
//

#import <AerServSDK/AerServSDK.h>
#import "AerServCustomEventBanner.h"
#import "ANCustomAdapter.h"

@interface AerServCustomEventBanner ()  <ANCustomAdapterBanner, ASAdViewDelegate>

@property (nonatomic, strong) ASAdView* adView;
@property (nonatomic, strong) UIViewController* rootVC;

@end

@implementation AerServCustomEventBanner

@synthesize delegate;

- (void)dealloc {
    [_adView removeFromSuperview];
    _adView = nil;
    _rootVC = nil;
}

#pragma mark AerservCustomAdapterBanner

- (void)requestBannerAdWithSize:(CGSize)bannerSize
              rootViewController:(UIViewController*)rootViewController
                 serverParameter:(NSString*)parameterString
                        adUnitId:(NSString*)idString
             targetingParameters:(ANTargetingParameters*)targetingParameters {
  @try {
    // The rootviewControllers needs to be passed to the delegate.
    self.rootVC = rootViewController;
    
    // Parse parameters
    if(!idString) {
      [self.delegate didFailToLoadAd:ANAdResponseInvalidRequest];
    }     
    self.adView = [ASAdView viewWithPlacementID:idString
                                      andAdSize:bannerSize];
    
    //Banner config
    self.adView.delegate = self;
    self.adView.sizeAdToFit = YES;
    self.adView.bannerRefreshTimeInterval = 0;
    self.adView.pubKeys = targetingParameters.customKeywords;
    [self.adView loadAd];
  }
  @catch(NSException* e) {
    [self.delegate didFailToLoadAd:ANAdResponseInvalidRequest];
  }
}

#pragma mark AerservBannerDelegate

- (UIViewController*)viewControllerForPresentingModalView {
  return self.rootVC;
}

- (void)adViewDidLoadAd:(ASAdView*)adView {
  [self.delegate didLoadBannerAd:adView];
}

- (void)adWasClicked:(ASAdView*)adView {
  [self.delegate adWasClicked];
}

- (void)willLeaveApplicatonFromAd:(ASAdView*)adView {
  [self.delegate willLeaveApplication];
}

- (void)willPresentModalViewForAd:(ASAdView *)adView {
    [self.delegate willPresentAd];
}

- (void)didDismissModalViewForAd:(ASAdView*)adView {
  [self.delegate didCloseAd];
}

- (void)adViewDidFailToLoadAd:(ASAdView*)adView
                    withError:(NSError*)error {
  [self.delegate didFailToLoadAd:ANAdResponseUnableToFill];
}

@end
