//
//  RWTSearchResultsItemViewModel.h
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 18/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTViewModelServices.h"
#import "RWTViewModel.h"
@class RWTFlickrPhoto;

@interface RWTSearchResultsItemViewModel : NSObject <RWTViewModel>
- (instancetype) initWithPhoto:(RWTFlickrPhoto *)photo services:(RWTViewModelServices*)services;

@property (nonatomic) BOOL isVisible;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSNumber *favorites;
@property (strong, nonatomic) NSNumber *comments;
@end
