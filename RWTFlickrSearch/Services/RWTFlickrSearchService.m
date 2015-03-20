//
//  RWTFlickrSearchImp.m
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 18/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchService.h"
#import "RWTFlickrSearchResults.h"
#import "RWTFlickrPhoto.h"
#import "RWTFlickrPhotoMetadata.h"
#import <objectiveflickr/ObjectiveFlickr.h>
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>
#import <ReactiveCocoa/RACEXTScope.h>

static NSString * const OFSampleAppAPIKey = @"19d38f2b2c6ad7987e01973ece7fa082";
static NSString * const OFSampleAppAPISharedSecret = @"7acc4703cc860e07";

@interface RWTFlickrSearchService() <OFFlickrAPIRequestDelegate>

@property (strong, nonatomic) NSMutableSet *requests;
@property (strong, nonatomic) OFFlickrAPIContext *flickrContext;

@end

@implementation RWTFlickrSearchService

- (instancetype) init {
    if (self = [super init]) {
        _flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:OFSampleAppAPIKey
                                                       sharedSecret:OFSampleAppAPISharedSecret];
        _requests = [NSMutableSet new];
    }
    return self;
}

- (RACSignal*)flickrSearchSignal:(NSString *)searchString {
    return [self signalFromAPIMethod:@"flickr.photos.search"
                           arguments:@{@"text":searchString,
                                       @"sort":@"interestingness-desc"}
                           transform:^id(NSDictionary *response) {
                               
                               RWTFlickrSearchResults *results = [RWTFlickrSearchResults new];
                               results.searchString = searchString;
                               results.totalResults = [[response valueForKeyPath:@"photos.total"] integerValue];
                               
                               NSArray *photos = [response valueForKeyPath:@"photos.photo"];
                               results.photos = [photos linq_select:^id(NSDictionary *jsonPhoto) {
                                   RWTFlickrPhoto *photo = [RWTFlickrPhoto new];
                                   photo.title = [jsonPhoto objectForKey:@"title"];
                                   photo.identifier = [jsonPhoto objectForKey:@"id"];
                                   photo.url = [self.flickrContext photoSourceURLFromDictionary:jsonPhoto size:OFFlickrSmallSize];
                                   return photo;
                               }];
                               return results;
                           }];
}

-(RACSignal*)flickrImageMetadata:(NSString *)photoId {
    RACSignal *favouritesSignal = [self signalFromAPIMethod:@"flickr.photos.getFavorites" arguments:@{@"photo_id":photoId} transform:^id(NSDictionary *response) {
        return [response valueForKeyPath:@"photo.total"];
    }];
    
    RACSignal *commentsSignal = [self signalFromAPIMethod:@"flickr.photos.getInfo" arguments:@{@"photo_id":photoId} transform:^id(NSDictionary *response) {
        return [response valueForKey:@"photo.comments._text"];
    }];
    
    return [RACSignal combineLatest:@[favouritesSignal,commentsSignal]reduce:^id(NSString* favourites, NSString* comments){
        return [[RWTFlickrPhotoMetadata alloc] initWithComments:[comments integerValue] andFavs:[favourites integerValue]];
    }];
}

- (RACSignal *)signalFromAPIMethod:(NSString*)method
                         arguments:(NSDictionary*)args
                         transform:(id(^)(NSDictionary *response))block {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        OFFlickrAPIRequest *flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:self.flickrContext];
        flickrRequest.delegate = self;
        [self.requests addObject:flickrRequest];
        
        RACSignal *successSignal = [self rac_signalForSelector:@selector(flickrAPIRequest:didCompleteWithResponse:)
                                                  fromProtocol:@protocol(OFFlickrAPIRequestDelegate)];
        
        RACSignal *failureSignal = [self rac_signalForSelector:@selector(flickrAPIRequest:didFailWithError:)
                                                  fromProtocol:@protocol(OFFlickrAPIRequestDelegate)];
        @weakify(flickrRequest)
        [[[[successSignal
        filter:^BOOL(RACTuple *tuple) {
            @strongify(flickrRequest)
            return tuple.first == flickrRequest;
         }]
         map:^id(RACTuple *tuple) {
             return tuple.second;
         }]
         map:block]
         subscribeNext:^(id x) {
             [subscriber sendNext:x];
             [subscriber sendCompleted];
         }];
        
        [[failureSignal
         map:^id(RACTuple *tuple) {
             return tuple.second;
         }]
        subscribeNext:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        [flickrRequest callAPIMethodWithGET:method arguments:args];
        
        return [RACDisposable disposableWithBlock:^{
            [self.requests removeObject:flickrRequest];
        }];
    }];
}

@end
