//
//  RWTViewModelServicesImpl.h
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 18/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

@import Foundation;
#import "RWTNavigationService.h"
#import "RWTFlickrSearchService.h"

@interface RWTViewModelServices : NSObject

- (RWTFlickrSearchService*)getFlickrSearchService;
- (instancetype)initWithNavigationController:(UINavigationController*)navigationController;
- (RWTNavigationService*)getNavigationService;

@end
