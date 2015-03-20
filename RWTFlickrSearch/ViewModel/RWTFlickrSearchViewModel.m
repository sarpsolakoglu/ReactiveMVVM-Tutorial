//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 10/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"
#import "RWTSearchResultsViewModel.h"
#import "RWTFlickrSearchResults.h"
#import "RWTPreviousSearch.h"
#import "RWTFlickrPhoto.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWTFlickrSearchViewModel ()

@property (nonatomic, weak) RWTViewModelServices* services;

@end

@implementation RWTFlickrSearchViewModel

- (instancetype)initWithServices:(RWTViewModelServices*)services {
    self = [super init];
    if (self) {
        _services = services;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.title = @"Flickr Search";
    
    self.previousSearches = [NSMutableArray array];
    
    RACSignal *validSearchSignal = [[RACObserve(self, searchText)
                                    map:^id(NSString *text) {
                                        return @(text.length > 3);
                                    }]
                                    distinctUntilChanged];
    
    [validSearchSignal subscribeNext:^(id x) {
        NSLog(@"search text is valid %@",x);
    }];
    
    self.executeSearch = [[RACCommand alloc] initWithEnabled:validSearchSignal signalBlock:^RACSignal *(id input) {
        return [self executeSearchSignal];
    }];
    
    self.connectionErrors = self.executeSearch.errors;
    
    self.previousSearchSelected = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(RWTPreviousSearch* previousSearch) {
        self.searchText = previousSearch.searchString;
        return [self executeSearchSignal];
    }];
}

- (RACSignal*) executeSearchSignal {
    return [[[self.services getFlickrSearchService]
             flickrSearchSignal:self.searchText]
            doNext:^(id result) {
                RWTSearchResultsViewModel *resultsViewModel = [[RWTSearchResultsViewModel alloc] initWithSearchResults:result services:self.services];
                [[self.services getNavigationService] pushViewModel:resultsViewModel];
                [self addToSearchHistory:result];
            }];
}

- (void) addToSearchHistory:(RWTFlickrSearchResults*) result{
    NSArray *matches = [[self.previousSearches.rac_sequence filter:^BOOL(RWTPreviousSearch* search) {
        return [search.searchString isEqualToString:self.searchText];
    }] array];
    
    NSMutableArray *previousSearchesUpdated = [NSMutableArray arrayWithArray:self.previousSearches];
    
    if (matches.count > 0) {
        NSString *match = matches[0];
        NSMutableArray *withoutMatch = [NSMutableArray arrayWithArray:[[previousSearchesUpdated.rac_sequence filter:^BOOL(RWTPreviousSearch* search) {
            return ![search.searchString isEqualToString:self.searchText];
        }] array]];
        [withoutMatch insertObject:match atIndex:0];
        previousSearchesUpdated = withoutMatch;
    } else {
        RWTPreviousSearch *prevSearch = [RWTPreviousSearch new];
        prevSearch.searchString = self.searchText;
        prevSearch.totalResults = result.totalResults;
        prevSearch.thumbnail = ((RWTFlickrPhoto*)result.photos[0]).url;
        [previousSearchesUpdated insertObject:prevSearch atIndex:0];
    }
    
    if (matches.count > 10) {
        [previousSearchesUpdated removeLastObject];
    }
    
    self.previousSearches = previousSearchesUpdated;
}


@end
