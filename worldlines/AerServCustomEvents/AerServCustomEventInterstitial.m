//
//  AerServCustomEventInterstitial.m
//  AppNexusSample
//
//  Created by Hall on 8/17/16.
//  Copyright © 2016 Aerserv. All rights reserved.
//

#import <AerServSDK/AerServSDK.h>
#import "AerServCustomEventInterstitial.h"
#import "ANCustomAdapter.h"

@interface AerServCustomEventInterstitial () <ANCustomAdapterInterstitial, ASInterstitialViewControllerDelegate>

@property (nonatomic, strong) ASInterstitialViewController* interstitial;
@property (nonatomic, assign) BOOL adLoaded;

@end

@implementation AerServCustomEventInterstitial

@synthesize delegate;

- (void)dealloc {
    _interstitial = nil;
}

#pragma mark - AerServCustomAdapterInterstitial

- (void)requestInterstitialAdWithParameter:(NSString*)parameterString
                                  adUnitId:(NSString*)idString
                       targetingParameters:(ANTargetingParameters*)targetingParameters {
  @try {
    self.adLoaded = NO;

    // Parse parameter
    if(!idString) {
      [self.delegate didFailToLoadAd:ANAdResponseInvalidRequest];
    }
    self.interstitial = [ASInterstitialViewController viewControllerForPlacementID:idString
                                                                      withDelegate:self];
      
    // Interstitial configs
    self.interstitial.pubKeys = targetingParameters.customKeywords;
    self.interstitial.isPreload = YES;
    [self.interstitial loadAd];
  }
  @catch(NSException* e) {
    [self.delegate didFailToLoadAd:ANAdResponseInvalidRequest];
  }
}

- (void)presentFromViewController:(UIViewController*)viewController {
  if(self.adLoaded) {
    [self.interstitial showFromViewController:viewController];
  } else {
    [self.delegate failedToDisplayAd];
  }
}

- (BOOL)isReady {
  return self.adLoaded;
}

#pragma mark - AerServDelegate
- (void)interstitialViewControllerDidPreloadAd:(ASInterstitialViewController*)viewController {
  [self.delegate didLoadInterstitialAd:self];
  self.adLoaded = YES;
}

- (void)interstitialViewControllerAdFailedToLoad:(ASInterstitialViewController*)viewController
                                       withError:(NSError*)error {
  [self.delegate didFailToLoadAd:ANAdResponseUnableToFill];
  self.adLoaded = NO;
}
  
- (void)interstitialViewControllerAdWasTouched:(ASInterstitialViewController*)viewController {
    [self.delegate adWasClicked];
    [self.delegate willLeaveApplication];
}

- (void)interstitialViewControllerWillDisappear:(ASInterstitialViewController*)viewController {
  [self.delegate willCloseAd];
}

- (void)interstitialViewControllerDidDisappear:(ASInterstitialViewController*)viewController {
  [self.delegate didCloseAd];
}

- (void)interstitialViewControllerWillAppear:(ASInterstitialViewController*)viewController {
  [self.delegate willPresentAd];
  self.adLoaded = NO;
}

- (void)interstitialViewControllerDidAppear:(ASInterstitialViewController*)viewController {
  [self.delegate didPresentAd];
}

@end
