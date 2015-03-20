//
//  RWTFlickrSearchViewModel.h
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 10/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTViewModelServices.h"
#import <ReactiveCocoa.h>

@interface RWTFlickrSearchViewModel : NSObject <RWTViewModel>

@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray *previousSearches;
@property (strong, nonatomic) RACCommand *executeSearch;
@property (strong, nonatomic) RACCommand *previousSearchSelected;
@property (strong, nonatomic) RACSignal *connectionErrors;

- (instancetype) initWithServices:(RWTViewModelServices*)services;

@end
