//
//  RWTAppDelegate.h
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 20/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//
#import "RWTFlickrSearchViewModel.h"
@import UIKit;

@interface RWTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RWTFlickrSearchViewModel *viewModel;

@end
