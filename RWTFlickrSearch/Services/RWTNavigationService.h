//
//  RWTNavigationService.h
//  RWTFlickrSearch
//
//  Created by Sarp Ogulcan Solakoglu on 19/03/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTViewModel.h"

@interface RWTNavigationService : NSObject
-(instancetype) initWithNavigationController:(UINavigationController*)navigationController;
-(void) pushViewModel:(id<RWTViewModel>)viewModel;
@end
