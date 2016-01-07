//
//  ZZAppDelegate.m
//  PayPal-iOS-SDK-Sample-App
//
//  Copyright (c) 2014, PayPal
//  All rights reserved.
//

#import "ZZAppDelegate.h"
#import "PayPalMobile.h"

@implementation ZZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"AdCE8mK396FcdjJihjcj7y5XEg-MXVor14nXUiA9eqcVW3Lmiz2ONbHtsJUVxBKwHygKkCwyyhaz3kVJ",
                                                         PayPalEnvironmentSandbox : @"AXGFDvbinkBoR2eQVQ3DlbNS4GW24P-Px-2zUcQVv4pFuZXq-KUwuVSCPPe8hirJLfZXE-a6bo76kwsE"}];
  return YES;
}

@end
