//
//  RWTPreviousSearch.h
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 19/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTPreviousSearch : NSObject
@property (nonatomic,strong) NSString* searchString;
@property (nonatomic,strong) NSURL* thumbnail;
@property (nonatomic,assign) NSUInteger totalResults;
@end
