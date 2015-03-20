//
//  Created by Colin Eberhardt on 24/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTRecentSearchItemTableViewCell.h"
#import "RWTPreviousSearch.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWTRecentSearchItemTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *searchLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalResultsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;

@end

@implementation RWTRecentSearchItemTableViewCell

- (void) bindViewModel:(id)viewModel {
    RWTPreviousSearch *prevSearch = (RWTPreviousSearch*)viewModel;
    self.searchLabel.text = prevSearch.searchString;
    self.totalResultsLabel.text = [NSString stringWithFormat:@"%u",prevSearch.totalResults];
    
    self.thumbnailImage.contentMode = UIViewContentModeScaleToFill;
    [self.thumbnailImage sd_setImageWithURL:prevSearch.thumbnail];
}

@end
