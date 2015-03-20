//
//  RWTViewModelServicesImpl.m
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 18/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import "RWTViewModelServices.h"
#import "RWTSearchResultsViewModel.h"
#import "RWTSearchResultsViewController.h"

@interface RWTViewModelServices ()

@property (strong, nonatomic) RWTFlickrSearchService *searchService;
@property (strong, nonatomic) RWTNavigationService *navigationService;

@end

@implementation RWTViewModelServices

- (instancetype)initWithNavigationController:(UINavigationController*)navigationController {
    if (self = [super init]) {
        _searchService = [RWTFlickrSearchService new];
        _navigationService = [[RWTNavigationService alloc] initWithNavigationController:navigationController];
    }
    return self;
}

- (RWTFlickrSearchService*)getFlickrSearchService {
    return self.searchService;
}

-(RWTNavigationService*)getNavigationService {
    return self.navigationService;
}

@end
