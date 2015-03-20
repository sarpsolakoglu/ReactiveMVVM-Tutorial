//
//  Created by Colin Eberhardt on 13/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewController.h"
#import "CETableViewBindingHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWTFlickrSearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *searchHistoryTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) RWTFlickrSearchViewModel *viewModel;
@property (strong, nonatomic) CETableViewBindingHelper *bindingHelper;
@end

@implementation RWTFlickrSearchViewController

- (instancetype)initWithViewModel:(RWTFlickrSearchViewModel *)viewModel {
    self = [super init];
    if (self ) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
  
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
  [self bindViewModel];
}

- (void)bindViewModel {
    self.title = self.viewModel.title;
    RAC(self.viewModel, searchText) = self.searchTextField.rac_textSignal;
    RAC([UIApplication sharedApplication], networkActivityIndicatorVisible) = [RACSignal combineLatest:@[self.viewModel.executeSearch.executing,self.viewModel.previousSearchSelected.executing] reduce:^id(NSNumber *execute1, NSNumber *execute2){
        return @([execute1 boolValue] || [execute2 boolValue]);
    }];
    RAC(self.loadingIndicator, hidden) = [self.viewModel.executeSearch.executing not];
    self.searchButton.rac_command = self.viewModel.executeSearch;
    [self.viewModel.executeSearch.executionSignals subscribeNext:^(id x) {
        [self.searchTextField resignFirstResponder];
    }];
    
    [self.viewModel.connectionErrors subscribeNext:^(NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"There was a problem reaching Flickr" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }];
    
    UINib *nib = [UINib nibWithNibName:@"RWTRecentSearchItemTableViewCell" bundle:nil];
    self.bindingHelper = [CETableViewBindingHelper bindingHelperForTableView:self.searchHistoryTable sourceSignal:RACObserve(self.viewModel, previousSearches) selectionCommand:self.viewModel.previousSearchSelected templateCell:nib];
     self.bindingHelper.delegate = self;
}


@end
