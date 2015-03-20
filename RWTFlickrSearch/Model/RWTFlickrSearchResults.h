//
//  RWTFlickrSearchResults.h
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 18/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrSearchResults : NSObject

@property (strong, nonatomic) NSString *searchString;
@property (strong, nonatomic) NSArray *photos;
@property (nonatomic) NSUInteger totalResults;

@end
