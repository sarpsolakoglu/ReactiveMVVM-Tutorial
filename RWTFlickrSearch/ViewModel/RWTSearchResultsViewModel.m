//
//  RWTSearchResultsViewModel.m
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 18/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewModel.h"
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>
#import "RWTSearchResultsItemViewModel.h"
#import "RWTFlickrPhoto.h"

@implementation RWTSearchResultsViewModel

- (instancetype)initWithSearchResults:(RWTFlickrSearchResults*)results services:(RWTViewModelServices*)services {
    if (self = [super init]) {
        _title = results.searchString;
        _seachResults = [results.photos linq_select:^id(RWTFlickrPhoto* photo) {
            return [[RWTSearchResultsItemViewModel alloc] initWithPhoto:photo services:services];
        }];
    }
    return self;
}

@end
