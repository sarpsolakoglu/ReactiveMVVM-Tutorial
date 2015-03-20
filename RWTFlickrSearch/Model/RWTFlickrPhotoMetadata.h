//
//  RWTFlickrPhotoMetadata.h
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 18/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrPhotoMetadata : NSObject
@property (nonatomic) NSUInteger favorites;
@property (nonatomic) NSUInteger comments;
-(instancetype)initWithComments:(NSUInteger)comment andFavs:(NSUInteger)fav;
@end
