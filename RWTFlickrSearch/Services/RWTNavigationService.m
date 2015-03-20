//
//  RWTNavigationService.m
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 19/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import "RWTNavigationService.h"
#import "RWTSearchResultsViewModel.h"
#import "RWTSearchResultsViewController.h"

@interface RWTNavigationService()
@property (nonatomic, weak) UINavigationController *navigationController;
@end

@implementation RWTNavigationService
-(instancetype) initWithNavigationController:(UINavigationController*)navigationController {
    if (self = [super init]) {
        _navigationController = navigationController;
    }
    return self;
}

- (void) pushViewModel:(id<RWTViewModel>)viewModel {
    if ([viewModel isKindOfClass:[RWTSearchResultsViewModel class]]) {
        RWTSearchResultsViewController *searchResultsViewController = [[RWTSearchResultsViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:searchResultsViewController animated:YES];
    }
}

@end
