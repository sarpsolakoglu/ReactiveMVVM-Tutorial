//
//  RWTFlickrSearchImp.h
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 18/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWTFlickrSearchService : NSObject
- (RACSignal*)flickrSearchSignal:(NSString*)searchString;
- (RACSignal*)flickrImageMetadata:(NSString*)photoId;
@end
