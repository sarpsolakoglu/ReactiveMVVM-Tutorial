//
//  RWTFlickrPhotoMetadata.m
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 18/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrPhotoMetadata.h"

@implementation RWTFlickrPhotoMetadata

-(instancetype)initWithComments:(NSUInteger)comment andFavs:(NSUInteger)fav {
    if(self = [super init]) {
        self.comments = comment;
        self.favorites = fav;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"metadata: comments=%lU, faves=%lU",
            (unsigned long)self.comments, (unsigned long)self.favorites];
}
@end
