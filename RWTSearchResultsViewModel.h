//
//  RWTSearchResultsViewModel.h
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 18/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

@import Foundation;
#import "RWTViewModelServices.h"
#import "RWTFlickrSearchResults.h"
#import "RWTViewModel.h"

@interface RWTSearchResultsViewModel : NSObject <RWTViewModel>

- (instancetype)initWithSearchResults:(RWTFlickrSearchResults*)results services:(RWTViewModelServices*)services;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *seachResults;

@end
